import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class CourseReviewReplyPage extends GetView<CourseReviewReplyController> {
  const CourseReviewReplyPage({super.key});

  AppBar _buildAppBar(BuildContext context) {
    final fontSize = context.textTheme.titleMedium?.fontSize ?? 16;
    return AppBar(
      title: TextWidget.body(
        LocaleKeys.editReply.tr,
        textStyle: TextStyle(fontSize: fontSize),
      ),
      leadingWidth: 80,
      leading: TextButton(
        onPressed: () => Get.back(),
        child: TextWidget.body(
          LocaleKeys.commonBottomCancel.tr,
          textStyle: TextStyle(fontSize: fontSize),
        ),
      ),
      actions: [
        TextButton(
          onPressed: controller.onConfirm,
          child: TextWidget.body(
            LocaleKeys.commonBottomConfirm.tr,
            textStyle: TextStyle(fontSize: fontSize),
          ),
        ),
      ],
    );
  }

  Widget _buildReplyEditorWidget(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: LocaleKeys.myReply.tr,
        labelStyle: TextStyle(fontSize: 22, height: 0.75),
        hintText: LocaleKeys.replyHint.tr,
        contentPadding: EdgeInsets.only(top: 0),
      ),
      controller: controller.editController,
      focusNode: controller.focusNode,
      autofocus: true,
      maxLength: 500,
      maxLines: 8,
    );
  }

  Widget _buildUserReviewWidget(BuildContext context) {
    final userName = controller.reviewUser;
    final reviewRating = controller.ratting;
    final review = controller.reviewContent;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 180.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: <Widget>[
            <Widget>[
              Expanded(
                child: TextWidget.body(
                  userName,
                  textStyle: context.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8.w),
              FiveStarRatingWidget(rating: reviewRating!, starSize: 16),
            ].toRow(),
            SizedBox(height: 10.h),
            TextWidget.body(
              review,
              textStyle: context.textTheme.bodyMedium,
            ),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      SizedBox(height: 20.h),
      _buildUserReviewWidget(context),
      SizedBox(height: 30.h),
      _buildReplyEditorWidget(context),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .paddingSymmetric(horizontal: 16.w);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseReviewReplyController>(
      init: CourseReviewReplyController(),
      id: "course_review_reply",
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
