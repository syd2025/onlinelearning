import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseListPage extends GetView<CourseListController> {
  const CourseListPage({super.key});

  AppBar _buildAppBar(BuildContext context) {
    final title = controller.title ?? '';
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        ButtonWidget.icon(
          Icon(Icons.search_outlined),
          onTap: controller.jumpToSearchCourse,
        ),
        SizedBox(width: 20.w),
        ShoppingCartButtonWidget().marginOnly(top: 10.h),
        SizedBox(width: 20.w),
      ],
    );
  }

  Widget _buildContentList(BuildContext context) {
    final canLoadMore = controller.canLoadMore;
    final courses = controller.courses;
    if (canLoadMore) {
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: courses.length + 1,
        itemBuilder: (context, index) {
          if (index == courses.length) {
            return const CourseLoadingCellWidget();
          } else {
            final course = courses[index];
            return CourseListCellWidget(
              course: course,
              onTap: () => controller.jumpToCourseDetail(course.id),
            );
          }
        },
      );
    } else {
      return ListView.builder(
        controller: controller.scrollController,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CourseListCellWidget(
            course: course,
            onTap: () => controller.jumpToCourseDetail(course.id),
          );
        },
      );
    }
  }

  Widget _buildMainBody(BuildContext context) {
    if (controller.isCourseEmpty) {
      return EmptyContentWidget(
        loading: controller.loading,
        error: controller.error,
        reloadAction: controller.loadCourseList,
      );
    } else {
      return _buildContentList(context);
    }
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return _buildMainBody(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseListController>(
      init: CourseListController(),
      id: "course_list",
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
