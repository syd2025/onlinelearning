import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  CourseDetailController();

  late final int _id;
  CourseDetailModel? courseDetail;
  bool loading = false;
  bool error = false;

  bool get isContentEmpty => courseDetail == null;
  bool get isMyCourse => courseDetail?.author.id == UserService.to.accountId;
  bool get isPruchased => UserService.to.purchasedCourses.contains(_id);
  int get courseId => _id;

  late final mainScrollController = ScrollController();
  // 底部按钮的key
  late final GlobalKey bottomPurchaseButtonKey = GlobalKey();
  // 顶部的购物车按钮的key
  late final GlobalKey appbarShoppingCartButtonKey = GlobalKey();
  // 评论分页
  late List<Widget> pages;
  // 0: 课程详情 1: 课程目录 2: 课程评论
  int currentTabIndex = 0;
  List<CourseReviewModel> reviews = [];
  int? _lastReviewPage;
  int _reviewPage = 1;
  int _reviewPageSize = 20;
  bool reviewLoading = false;
  bool reviewError = false;
  bool get isReviewEmpty => reviews.isEmpty;
  CancelToken? _reviewCancelToken;
  List<CourseTableContentUnitModel> categoryUnits = [];

  // AppBar是否显示标题
  bool _showTitle = false;
  bool get showTitle => _showTitle;
  // 课程标题
  String? get courseTitle => courseDetail?.title;
  // 是否正在收藏
  bool _favoriteChanging = false;
  // 是否收藏
  bool get isMyFavorite => courseDetail?.isFavorite ?? false;
  // 是否在企业网络环境下
  bool _onBusinessNetwork = false;
  // 购物车中的课程数量
  final RxInt cartCount = 0.obs;
  // 获取购物车数量
  int get courseCount => cartCount.value;

  // 添加购物车的动画效果
  late OverlayEntry animatedOverlayEntry;
  late AnimationController animatedController;
  late Animation<Offset> animation;

  // 载入更多的评论
  bool get canLoadMoreReivews {
    if (_lastReviewPage != null) {
      return _reviewPage <= _lastReviewPage!;
    } else {
      return true;
    }
  }

  // 载入课程详情
  void loadCourseDetail() async {
    try {
      if (loading) {
        return;
      }

      Loading.show();
      loading = true;
      error = false;
      update(["course_detail"]);

      final response = await CourseApi.getCourseDetail(_id);
      Loading.dismiss();
      loading = false;
      if (response.code == 0) {
        courseDetail = response.course;
        error = false;
        _makeCategoryUnits();
      } else {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["course_detail"]);
    } catch (e) {
      Loading.dismiss();
      loading = false;
      error = true;
      Loading.error(e.toString());
      update(["course_detail"]);
    }
  }

  _initData() {
    loadCourseDetail();
    update(["course_detail"]);
  }

  // 点击收藏按钮
  clickMyFavorite() {
    if (!UserService.to.isLogin) {
      Get.toNamed(RouteNames.systemLogin);
    } else {
      toggleFavorite();
    }
  }

  // 载入评论
  void loadReviews() async {
    try {
      if (reviewLoading) {
        return;
      }

      Loading.show();
      reviewLoading = true;
      reviewError = false;
      update(["course_detail_review"]);

      _reviewCancelToken ??= CancelToken();
      final response = await BusinessApi.getCourseReviews(
        courseId: _id,
        page: _reviewPage,
        pageSize: _reviewPageSize,
        cancelToken: _reviewCancelToken,
      );
      reviewLoading = false;
      Loading.dismiss();
      if (response.code == 0) {
        // 追加元素
        reviews.addAll(response.reviews ?? []);
        _lastReviewPage = response.pageMeta?.lastPage;
        _reviewPage = (response.pageMeta?.currentPage ?? _reviewPage) + 1;
        _reviewPageSize = response.pageMeta?.pageSize ?? 20;
      } else {
        reviewError = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["course_detail_review"]);
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        log('Request cancelled: $e');
        reviewLoading = false;
        reviewError = false;
        update(["course_detail_review"]);
        return;
      }

      reviewError = true;
      reviewLoading = false;
      update(["course_detail_review"]);
      Loading.error(e.toString());
    } catch (e) {
      Loading.dismiss();
      reviewLoading = false;
      reviewError = true;
      update(["course_detail_review"]);
      log('Error: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    _id = int.parse(Get.arguments["id"]);
    mainScrollController.addListener(_scrollListener);
    // 添加购物车的动画效果
    animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animatedController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animatedOverlayEntry.remove();
        animatedController.reset();
      }
    });
  }

// 切换tab
  void changeTabIndex(int index) {
    currentTabIndex = index;
    if (index == 2 && reviews.isEmpty) {
      loadReviews();
    }
    update(["course_detail"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  @override
  void dispose() {
    mainScrollController.removeListener(_scrollListener);
    mainScrollController.dispose();
    _reviewCancelToken?.cancel();
    animatedController.dispose(); // 添加动画控制器销毁
    super.dispose();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  void _makeCategoryUnits() {
    final chapters = courseDetail?.chapters;
    if (chapters == null) {
      return;
    }

    categoryUnits.clear();
    var index = 0;
    for (final chapter in chapters) {
      final chapterTitle =
          '${Strings.chapterIndex(chapter.index)} ${chapter.title}';
      categoryUnits.add(
        CourseTableContentUnitModel(
          id: chapter.id,
          title: chapterTitle,
          isChapter: true,
          isFree: false,
        ),
      );

      for (final item in chapter.videos ?? []) {
        final cIndex = chapter.index;
        final vIndex = item.index;
        final vTitle = item.title;
        final vMinutes = item.duration ~/ 60;
        final vSeconds = (item.duration % 60).toString().padLeft(2, '0');
        final videoTitle = '$cIndex-$vIndex $vTitle';
        final timeString = '$vMinutes:$vSeconds';
        categoryUnits.add(
          CourseTableContentUnitModel(
            id: item.id,
            title: videoTitle,
            timeString: timeString,
            isChapter: false,
            isFree: index++ < 2,
          ),
        );
      }
    }
  }

  // 滚动监听
  void _scrollListener() {
    if (mainScrollController.offset > 80 && !showTitle) {
      _showTitle = true;
      update(["course_detail"]);
    } else if (mainScrollController.offset <= 80 && showTitle) {
      _showTitle = false;
      update(["course_detail"]);
    }
    update(["course_detail"]);
  }

  // 收藏/取消收藏课程
  void toggleFavorite() async {
    if (_favoriteChanging) {
      return;
    }
    _favoriteChanging = true;

    try {
      if (isMyFavorite) {
        final response = await BusinessApi.removeFavoriteCourse(_id);
        if (response.code == 0) {
          courseDetail?.isFavorite = false;
          Loading.toast(LocaleKeys.unfavorite.tr);
          update(["course_detail_appbar"]);
        } else {
          if (response.message != null) {
            log(response.message!);
          }
        }
      } else {
        final response = await BusinessApi.addFavoriteCourse(_id);
        if (response.code == 0) {
          courseDetail?.isFavorite = true;
          Loading.toast(LocaleKeys.favorite.tr);
          update(["course_detail_appbar"]);
        } else {
          if (response.message != null) {
            log(response.message!);
          }
        }
      }
    } catch (e) {
      log('toggleFavorite: $e');
    } finally {
      _favoriteChanging = false;
    }
  }

  // 添加到购物车
  Future<bool> addToShoppingCarts() async {
    if (UserService.to.purchasedCourses.contains(_id)) {
      Loading.toast(LocaleKeys.courseAlreadyPurchased.tr);
      return false;
    }

    if (UserService.to.purchasingCourses.contains(_id)) {
      Loading.toast(LocaleKeys.courseAlreadyInShoppingCart.tr);
    }

    if (_onBusinessNetwork || courseDetail == null) {
      return false;
    }

    _onBusinessNetwork = true;

    try {
      final response =
          await BusinessApi.addCourseToShoppingCart(_id, courseDetail!.price);
      if (response.code == 0) {
        Loading.toast(LocaleKeys.courseAdded.tr); // 课程已加入购物车
        // 同步数据
        UserService.to.addCourseToShoppingCarts(_id);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
    } catch (e) {
      log('addToShoppingCarts error: $e');
    } finally {
      _onBusinessNetwork = false;
    }
    return false;
  }

  // 购买课程
  void purchase() async {
    if (UserService.to.purchasedCourses.contains(_id)) {
      Loading.toast(LocaleKeys.courseAlreadyPurchased.tr);
      return;
    }

    if (_onBusinessNetwork || courseDetail == null) {
      return;
    }

    _onBusinessNetwork = true;

    try {
      final response = await BusinessApi.purchaseCourses([_id]);
      if (response.code == 0 && response.totalPrice != null) {
        Loading.success(LocaleKeys.coursePurchased.tr);
        UserService.to.coursePurchased([_id]);
        update(["course_detail_appbar", "course_detail_bottom"]);
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
    } catch (e) {
      log('purchase error: $e');
    } finally {
      _onBusinessNetwork = false;
    }
  }
}
