import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:rxdart/rxdart.dart';

class CourseSearchController extends GetxController {
  CourseSearchController();

  String searchText = '';
  String? searchKey;

  List<CourseBriefModel> courses = [];
  bool loading = false;
  bool error = false;

  late final focusNode = FocusNode();
  late final textController = TextEditingController();
  late final textSubject = PublishSubject<String>();
  late final StreamSubscription<String> subscription;
  late final ScrollController scrollController;

  int? _lastPage;
  int _page = 1;
  int _pageSize = 20;

  CancelToken? _cancelToken;

  List<String>? topCourseKeys;

  bool get isCourseEmpty => courses.isEmpty;
  bool get isSearchTextEmpty => searchText.isEmpty;

  bool get canLoadMore {
    if (_lastPage != null) {
      return _page <= _lastPage!;
    } else {
      return true;
    }
  }

  List<String> searchHistories = [];
  bool get isSearchHistoryEmpty => searchHistories.isEmpty;

  Future<void> insertSearchText(String text) async {
    await DataBaseService.to.insertSearchText(text.trim());
    searchHistories = await DataBaseService.to.getSearchHistories();
    update(["course_search"]);
  }

  /// 设置搜索文本
  void _setSearchText({required String text, required String key}) {
    if (text == searchText) {
      return;
    }

    searchText = text;
    if (key.isEmpty) {
      courses.clear();
      update(["course_search"]);
    }

    if (loading && _cancelToken != null) {
      _cancelToken?.cancel('new search');
      _cancelToken = null;
      loading = false;
    }

    _page = 1;
    searchKey = key;
    if (searchKey != null && searchKey!.isNotEmpty) {
      search();
    }
  }

  /// 清空搜索文本
  void clearSearchText() {
    textController.clear();
    _setSearchText(text: '', key: '');
    focusNode.requestFocus();
  }

  _initData() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (canLoadMore) {
          search();
        }
      }
    });

    textController.addListener(() {
      textSubject.add(textController.text);
    });

    subscription = textSubject.stream
        .sampleTime(const Duration(milliseconds: 1000))
        .listen((text) {
      _setSearchText(text: text, key: text.trim());
    });

    DataBaseService.to.getSearchHistories().then((value) {
      searchHistories = value;
      update(["course_search"]);
    });

    Future.delayed(Duration.zero, () {
      loadTopCourseKeys();
    });
  }

  /// 加载热门搜索关键词
  Future<void> loadTopCourseKeys() async {
    try {
      final response = await CourseApi.getTopCourseKeys();
      if (response.code == 0 && response.keys != null) {
        topCourseKeys = response.keys;
        update(["course_search"]);
      } else if (response.code != 0) {
        topCourseKeys = null;
      }
    } catch (e) {
      topCourseKeys = null;
    }
  }

  /// 加载热门搜索关键词
  updateSearchText(String text) {
    focusNode.unfocus();
    textController.text = text;
    _setSearchText(text: text, key: text.trim());
    insertSearchText(text);
  }

  /// 清空搜索历史
  void clearSearchHistories() {
    DataBaseService.to.clearSearchHistories().then((value) {
      searchHistories.clear();
      update(["course_search"]);
    });
  }

  /// 搜索课程
  Future<void> search({String? key}) async {
    final k = key ?? searchKey;
    if (k == null || k.isEmpty) {
      return;
    }

    try {
      if (loading) {
        return;
      }

      Loading.show();
      loading = true;
      error = false;
      update(["course_search"]);

      _cancelToken ??= CancelToken();
      final response = await CourseApi.searchCourses(
        key: k,
        page: _page,
        pageSize: _pageSize,
        cancelToken: _cancelToken,
      );
      loading = false;
      Loading.dismiss();

      if (response.code == 0 && response.courses != null) {
        if (_page == 1) {
          courses.clear();
        }

        courses.addAll(response.courses!);
        _lastPage = response.pageMeta?.lastPage;
        _pageSize = response.pageMeta?.pageSize ?? 20;
        _page = (response.pageMeta?.currentPage ?? _page) + 1;
      } else {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["course_search"]);
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return;
      }
      loading = false;
      error = true;
      update(["course_search"]);
      Loading.error(e.toString());
    } catch (e) {
      log('Error: $e');
    } finally {
      _cancelToken?.cancel();
      _cancelToken = null;
    }
  }

  /// 跳转到课程详情页面
  jumpToCourseDetail(int id) {
    Get.toNamed(RouteNames.courseCourseDetail, arguments: {
      "id": "$id",
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _cancelToken?.cancel();
    subscription.cancel();
    textSubject.close();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
