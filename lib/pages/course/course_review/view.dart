import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class CourseReviewPage extends GetView<CourseReviewController> {
  const CourseReviewPage({super.key});

  _buildAppBar(BuildContext context) {
    final fontSize = context.textTheme.titleMedium?.fontSize ?? 16;
    return AppBar(
      title: TextWidget.body(
        LocaleKeys.editReview.tr,
        size: fontSize,
      ),
      leadingWidth: 80.w,
      leading: TextButton(
        child: TextWidget.body(
          LocaleKeys.commonBottomCancel.tr,
          size: fontSize,
        ),
        onPressed: () => Get.back(),
      ),
      actions: [
        TextButton(
          onPressed: controller.onConfirm,
          child: TextWidget.body(
            LocaleKeys.commonBottomConfirm.tr,
            size: fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingWidget(BuildContext context) {
    final rating = controller.rating;
    return <Widget>[
      TextWidget.body(
        LocaleKeys.myRating.tr,
        textStyle: context.textTheme.titleLarge,
      ),
      const Spacer(),
      FiveStarRatingWidget(
        rating: rating!,
        starSize: 24,
        onRatingChanged: (v) {
          controller.newRating = v;
        },
      ),
    ].toRow();
  }

  Widget _buildReplyEditorWidget(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          labelText: LocaleKeys.myReview.tr,
          labelStyle: TextStyle(fontSize: 22, height: 0.75),
          hintText: LocaleKeys.replyHint.tr,
          contentPadding: EdgeInsets.only(top: 0)),
      controller: controller.textController,
      focusNode: controller.focusNode,
      autofocus: true,
      maxLength: 500,
      maxLines: 8,
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      SizedBox(height: 25.h),
      _buildRatingWidget(context),
      SizedBox(height: 30.h),
      _buildReplyEditorWidget(context),
    ].toColumn().paddingSymmetric(horizontal: 16.w);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseReviewController>(
      init: CourseReviewController(),
      id: "course_review",
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
