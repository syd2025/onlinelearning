import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class StudyIndexPage extends GetView<StudyIndexController> {
  const StudyIndexPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    if (controller.isContentEmpty) {
      return EmptyContentWidget(
        loading: controller.loading,
        error: controller.error,
        reloadAction: controller.loadPurchasedCourses,
        buttonTitle: LocaleKeys.noCourseGoFind.tr,
        otherAction: controller.onJumpToCoursePage,
      );
    } else {
      return _buildCourseList(context);
    }
  }

  Widget _buildCourseList(BuildContext context) {
    return ListView.builder(
        itemCount: controller.purchasedCourses.length,
        itemBuilder: (context, index) {
          final order = controller.purchasedCourses[index];
          return CourseLearningCellWidget(
            course: order,
            onTap: () => controller.onJumpToStudyCourse(order),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyIndexController>(
      init: StudyIndexController(),
      id: "study_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: TextWidget.body(LocaleKeys.learning.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
