import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseReviewReplyController extends GetxController {
  CourseReviewReplyController();

  late final TextEditingController editController;
  late final FocusNode focusNode;
  final reviewId = int.tryParse(Get.arguments['id']);
  final courseId = int.tryParse(Get.arguments['course_id']);
  final ratting = int.tryParse(Get.arguments['rating']);
  final reviewUser = Get.arguments['user'];
  final reviewContent = Get.arguments['content'];
  final replyId = int.tryParse(Get.arguments['reply_id'] ?? '');
  final replyContent = Get.arguments['reply_content'];

  _initData() {
    editController.text = replyContent ?? '';
    update(["course_review_reply"]);
  }

  Future<String?> replyReview() async {
    final newReply = editController.text.trim();
    if (newReply.isEmpty) {
      Loading.error(LocaleKeys.contentCannotBeEmpty.tr);
      return null;
    }
    if (newReply == replyContent) {
      return '';
    }

    try {
      Loading.show();
      final response =
          await BusinessApi.replyCourseReview(courseId!, reviewId!, newReply);
      Loading.dismiss();
      if (response.code == 0) {
        Loading.success(LocaleKeys.replySuccess.tr);
        return newReply;
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

  // 点击确认按钮，评论课程内容
  void onConfirm() {
    replyReview().then((value) {
      if (value != null) {
        Get.back(result: value);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
    editController = TextEditingController();
    focusNode = FocusNode();
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
