import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class StudyCoursePage extends GetView<StudyCourseController> {
  const StudyCoursePage({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.zero,
      child: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      _buildCoursePlayWidget(context),
      _buildCourseContentWidget(context),
    ].toColumn();
  }

  // 课程内容
  Widget _buildCoursePlayWidget(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = width * 9.0 / 16.0;
    return <Widget>[
      Container(
        width: width,
        height: height,
        color: Colors.black,
        child: StudyCourseVideoPlayWidget(),
      ),
      Positioned(
        top: 5.h,
        left: 5.w,
        child: ButtonWidget.icon(
          Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onTap: controller.jumpToBack,
        ),
      ),
      Positioned(
        top: 5.h,
        right: 5.w,
        child: ButtonWidget.icon(
          Icon(
              controller.isMyFavorite ? Icons.favorite : Icons.favorite_outline,
              color: Colors.white,
              size: 26),
          onTap: controller.toggleFavorite,
        ),
      ),
    ].toStack();
  }

  Widget _buildCourseContentWidget(BuildContext context) {
    if (controller.isContentEmpty) {
      return Expanded(
        child: EmptyContentWidget(
          loading: controller.loading,
          error: controller.error,
          reloadAction: controller.loadCourseDetail,
        ),
      );
    } else {
      return StudyCourseTabWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyCourseController>(
      init: StudyCourseController(),
      id: "study_course",
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
