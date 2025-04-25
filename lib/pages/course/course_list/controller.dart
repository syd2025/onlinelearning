import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseListController extends GetxController {
  CourseListController();

  late final int categoryId;
  final String? title = Get.arguments["title"];
  late final ScrollController scrollController;
  List<CourseBriefModel> courses = [];
  bool loading = false;
  bool error = false;
  int? _lastPage;
  int _page = 1;
  int _pageSize = 20;
  CancelToken? _cancelToken;

  bool get isCourseEmpty => courses.isEmpty;

  bool get canLoadMore {
    if (_lastPage != null) {
      return _page <= _lastPage!;
    } else {
      return true;
    }
  }

  _initData() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (canLoadMore) {
          loadCourseList();
        }
      }
    });

    Future.delayed(Duration.zero, () {
      loadCourseList();
    });
  }

  void loadCourseList() async {
    try {
      if (loading) {
        return;
      }

      Loading.show();
      loading = true;
      error = false;
      update(["course_list"]);

      _cancelToken ??= CancelToken();
      final response = await CourseApi.getCourseList(
        categoryId: categoryId,
        page: _page,
        pageSize: _pageSize,
        cancelToken: _cancelToken,
      );
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.courses != null) {
        courses.addAll(response.courses!);
        _lastPage = response.pageMeta?.lastPage;

        _pageSize = response.pageMeta?.pageSize ?? 20;
        _page = (response.pageMeta?.currentPage ?? _page) + 1;
      } else if (response.code != 0) {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["course_list"]);
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return;
      }
      loading = false;
      error = true;
      update(["course_list"]);
      Loading.error(e.toString());
    } catch (e) {
      log('Error: $e');
    } finally {
      _cancelToken?.cancel();
      _cancelToken = null;
    }
  }

  /// 跳转到搜索课程页面
  jumpToSearchCourse() {
    Get.toNamed(RouteNames.courseCourseSearch);
  }

  /// 跳转到课程详情页面
  jumpToCourseDetail(int id) {
    Get.toNamed(RouteNames.courseCourseDetail, arguments: {
      "id": "$id",
    });
  }

  @override
  void onInit() {
    super.onInit();
    categoryId = int.parse(Get.arguments["categoryId"]);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
