import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyIndexController extends GetxController {
  StudyIndexController();

  final List<CourseOrderModel> purchasedCourses = [];
  bool loading = false;
  bool error = false;

  // 当前选中的课程ID
  final activeCourseId = 0.obs;

  bool get isContentEmpty => purchasedCourses.isEmpty;

  late final _cancelToken = CancelToken();

  _initData() {
    Future.delayed(Duration.zero, loadPurchasedCourses);
    update(["study_index"]);
  }

  void loadPurchasedCourses() {
    final purchasedCourseIdList = UserService.to.purchasedCourses;
    final fetchedCourseIdList = purchasedCourses.map((e) => e.id).toList();
    final difference = purchasedCourseIdList
        .where((element) => !fetchedCourseIdList.contains(element))
        .toList();
    if (difference.isNotEmpty && !loading) {
      _loadPurchasedCourses(difference);
    }
  }

  void _loadPurchasedCourses(List<int> courseIds) async {
    try {
      Loading.show();
      loading = true;
      error = false;
      update(["study_index"]);

      final response = await BusinessApi.getCourseOrders(
        courseIds: courseIds,
        cancelToken: _cancelToken,
      );
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.orders != null) {
        final fetchedCourseIdList = purchasedCourses.map((e) => e.id).toList();
        final newOrders = response.orders!
            .where((element) => !fetchedCourseIdList.contains(element.id))
            .toList();
        purchasedCourses.addAll(newOrders);
      } else {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
      update(["study_index"]);
    } on DioException catch (e) {
      Loading.dismiss();
      loading = false;
      if (e.type == DioExceptionType.cancel) {
        return;
      }
      error = true;
      update(["study_index"]);
      Loading.error(e.toString());
    } catch (e) {
      log('Error: $e');
    }
  }

  // 跳转指定页面
  void onJumpToCoursePage() {
    final mainController = Get.find<MainController>();
    mainController.onJumpToPage(1);
  }

  void onJumpToStudyCourse(CourseOrderModel order) {
    Get.toNamed(RouteNames.studyStudyCourse, arguments: {
      "id": order.id,
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

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
