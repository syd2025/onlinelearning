import 'dart:developer';

import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CategoryIndexController extends GetxController {
  CategoryIndexController();

  List<CourseCategoryModel> categories = [];
  List<String>? topCourseKeys;
  bool loading = false;
  bool error = false;

  bool get isCategoryEmpty => categories.isEmpty;

  int _majorCategoryIndex = 0;

  int get majorCategoryIndex => _majorCategoryIndex;

  /// 设置一级分类索引
  set majorCategoryIndex(int index) {
    _majorCategoryIndex = index;
    update(["category_index"]);
  }

  /// 一级分类ID
  int get majorCategoryId {
    final category = categories[_majorCategoryIndex];
    return category.id;
  }

  /// 二级分类
  List<CourseSubcategoryModel>? get minorCategories {
    final majorCategory = categories[_majorCategoryIndex];
    return majorCategory.subCategories;
  }

  /// 加载所有分类
  Future<void> loadAllCategories() async {
    try {
      Loading.show();
      loading = true;
      error = false;
      update(["category_index"]);
      final response = await CourseApi.getAllCategories();
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.categories != null) {
        categories = response.categories!;
      } else {
        categories = [];
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["category_index"]);
    } catch (e) {
      loading = false;
      error = true;
      update(["category_index"]);
      Loading.dismiss();
      Loading.error(LocaleKeys.unknownError.tr);
      log("Error: $e");
    }
  }

  /// 加载热门课程关键字
  Future<void> loadTopCourseKeys() async {
    try {
      // 从服务器获取热门课程
      final response = await CourseApi.getTopCategories();
      if (response.code == 0 && response.keys != null) {
        final keys = response.keys!;
        var tmp = "";
        final groupedKeys = <String>[];
        for (var i = 0; i < keys.length; i++) {
          tmp += '${keys[i]} · ';
          if (i != 0 && i % 3 == 2) {
            tmp = tmp.substring(0, tmp.length - 3);
            groupedKeys.add(tmp);
            tmp = '';
          }
        }
        if (tmp.isNotEmpty) {
          tmp = tmp.substring(0, tmp.length - 3);
          groupedKeys.add(tmp);
        }
        topCourseKeys = groupedKeys;
        update(["category_index"]);
      } else if (response.code != 0) {
        topCourseKeys = [];
      }
    } catch (e) {
      topCourseKeys = [];
    }
  }

  _initData() {
    Future.delayed(Duration.zero, () {
      loadAllCategories();
      loadTopCourseKeys();
    });
    update(["category_index"]);
  }

  jumpToCourseList(int id, String nextTitle) {
    Get.toNamed(
      RouteNames.courseCourseList,
      arguments: {
        'categoryId': '$id',
        'title': nextTitle,
      },
    );
  }

  void jumpToSearchPage() {
    Get.toNamed(RouteNames.courseCourseSearch);
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
