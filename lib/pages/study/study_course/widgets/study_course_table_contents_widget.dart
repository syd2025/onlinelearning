import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyCourseTableContentsWidget extends StatelessWidget {
  StudyCourseTableContentsWidget({super.key});

  final controller = Get.find<StudyCourseController>();

  Widget _buildCourseTitle(BuildContext context) {
    if (controller.isContentEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    } else {
      return SliverToBoxAdapter(
        child: SizedBox(
          width: double.infinity,
          child: <Widget>[
            SizedBox(height: 20.h),
            TextWidget.body(
              controller.courseDetail!.title,
              textStyle: context.textTheme.titleMedium,
              weight: FontWeight.bold,
            ),
            SizedBox(height: 8.h),
            <Widget>[
              TextWidget.body(
                controller.courseDetail!.levelTitle,
                textStyle: context.textTheme.titleSmall,
                color: AppTheme.greyColor,
              ),
              SizedBox(width: 20.w),
              IconWidget.icon(
                Icons.person_outline,
                size: 20,
                color: AppTheme.greyColor,
              ),
              TextWidget.body(
                controller.courseDetail!.studentCount.toString(),
                textStyle: context.textTheme.titleSmall,
                color: AppTheme.greyColor,
              ),
            ].toRow(),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      );
    }
  }

  Widget _buildCourseChapterUnitWidget(
      BuildContext context, CourseTableContentUnitModel unit) {
    final style = context.textTheme.titleMedium;
    return <Widget>[
      Expanded(
        child: TextWidget.body(
          unit.title,
          textStyle: style,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          weight: FontWeight.bold,
        ),
      ),
    ].toRow().paddingOnly(left: 16.w, right: 16.w, top: 20.h, bottom: 10.h);
  }

  Widget _buildCourseVideoUnitWidget(BuildContext context,
      CourseTableContentUnitModel unit, bool showDivider) {
    return GestureDetector(
      onTap: () {
        controller.playVideo(unit.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.h),
        color: context.theme.colorScheme.surface,
        child: <Widget>[
          <Widget>[
            IconWidget.icon(
                controller.currentVideoId == unit.id
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline,
                color: controller.currentVideoId == unit.id
                    ? AppTheme.purchaseTipColor
                    : null,
                size: 20),
            SizedBox(width: 10.w),
            Expanded(
              child: TextWidget.body(
                unit.title,
                textStyle: controller.currentVideoId == unit.id
                    ? context.textTheme.titleSmall
                    : null,
                color: controller.currentVideoId == unit.id
                    ? AppTheme.purchaseTipColor
                    : null,
              ),
            ),
          ].toRow(),
          SizedBox(height: 10.h),
          <Widget>[
            SizedBox(width: 28.w),
            TextWidget.body(
              LocaleKeys.duration.tr,
              textStyle: context.textTheme.titleSmall,
              color: AppTheme.greyColor,
            ),
            TextWidget.body(
              unit.timeString ?? '',
              textStyle: context.textTheme.titleSmall,
              color: AppTheme.greyColor,
            ),
            const Spacer(),
            TextWidget.body(
              LocaleKeys.progress.tr,
              textStyle: context.textTheme.titleSmall,
              color: AppTheme.greyColor,
            ),
            TextWidget.body(
              "0 %",
              textStyle: context.textTheme.titleSmall,
              color: AppTheme.greyColor,
            ),
          ].toRow(),
          SizedBox(height: 16.h),
          Divider(
            indent: 0,
            height: 1.h,
            thickness: 0.5,
            color: AppTheme.greyColor,
          ),
        ].toColumn(),
      ),
    );
  }

  Widget _buildCourseCategoryUnitsWidget(BuildContext context) {
    final units = controller.categoryUnits;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: units.length,
        (context, index) {
          final unit = units[index];
          var showDivider = true;
          if (index < units.length - 1) {
            if (units[index + 1].isChapter) {
              showDivider = false;
            }
          } else {
            showDivider = false;
          }
          if (unit.isChapter) {
            return _buildCourseChapterUnitWidget(context, unit);
          } else {
            return _buildCourseVideoUnitWidget(context, unit, showDivider);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyCourseController>(
      init: controller,
      id: 'study_course_table_contents', // 唯一的i,
      builder: (_) {
        return CustomScrollView(key: const PageStorageKey('content'), slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: _buildCourseTitle(context),
          ),
          SliverPadding(
            padding: EdgeInsets.only(bottom: 20.h),
            sliver: _buildCourseCategoryUnitsWidget(context),
          ),
        ]);
      },
    );
  }
}
