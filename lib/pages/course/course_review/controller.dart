import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseReviewController extends GetxController {
  CourseReviewController();

  final courseId = int.tryParse(Get.arguments["course_id"]);
  final rating = int.tryParse(Get.arguments["rating"]);
  final reviewContent = Get.arguments["review_content"];

  late final TextEditingController textController;
  late final FocusNode focusNode;
  late int newRating = rating!;

  _initData() {
    update(["course_review"]);
  }

  Future<CourseReviewModel?> review() async {
    final newReview = textController.text.trim();
    if (newReview.isEmpty) {
      Loading.error(LocaleKeys.contentCannotBeEmpty.tr);
      return null;
    }

    if (newReview == reviewContent && newRating == rating) {
      return null;
    }
    try {
      Loading.show();
      final response = await BusinessApi.reviewCourse(
        courseId!,
        newRating,
        newReview,
      );
      Loading.dismiss();
      if (response.code == 0) {
        Loading.success(LocaleKeys.reviewSuccess.tr);
        final newReview = response.review!;
        return newReview;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return null;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return null;
    }
  }

  void onConfirm() {
    review().then((value) {
      if (value != null) {
        Get.back(result: value);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    textController = TextEditingController();
    focusNode = FocusNode();
    textController.text = reviewContent ?? '';
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
