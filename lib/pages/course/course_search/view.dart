import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

import 'index.dart';

class CourseSearchPage extends GetView<CourseSearchController> {
  const CourseSearchPage({super.key});

  AppBar _buildAppBar(BuildContext context) {
    final tipColor = controller.textController.text.isNotEmpty
        ? null
        : AppTheme.appBarSearchTextTipColor;
    return AppBar(
      title: Container(
        height: 36,
        width: 320,
        decoration: BoxDecoration(
          color: Get.context!.theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: TextField(
          controller: controller.textController,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            hintText: LocaleKeys.searchHint.tr,
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: tipColor),
            suffixIcon: controller.textController.text.isNotEmpty
                ? IconButton(
                    onPressed: controller.clearSearchText,
                    icon: const Icon(Icons.close),
                  )
                : null,
          ),
          focusNode: controller.focusNode,
          autofocus: true,
          textInputAction: TextInputAction.done,
          onSubmitted: (text) {
            controller.insertSearchText(text.trim());
          },
        ),
      ),
      actions: const [],
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
              searchKey: controller.searchKey,
              onTap: controller.jumpToCourseDetail(course.id),
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
            searchKey: controller.searchKey,
            onTap: () => controller.jumpToCourseDetail(course.id),
          );
        },
      );
    }
  }

  Widget _buildMainBody(BuildContext context) {
    if (controller.isCourseEmpty) {
      if (controller.isSearchTextEmpty) {
        return <Widget>[
          SearchHistoryWidget(),
          Expanded(child: HotSearchWidget()),
        ].toColumn();
      } else {
        return Center(
          child: ImageWidget.img(AssetsImages.noContent, fit: BoxFit.cover),
        );
      }
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
    return GetBuilder<CourseSearchController>(
      init: CourseSearchController(),
      id: "course_search",
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
