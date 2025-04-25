import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailSummaryWidget extends StatelessWidget {
  CourseDetailSummaryWidget({super.key});

  final controller = Get.find<CourseDetailController>();

  Widget _buildColumnStuff(BuildContext context, String title, String value) {
    return <Widget>[
      TextWidget.body(
        title,
        textStyle: context.textTheme.titleMedium,
      ),
      const SizedBox(height: 10),
      TextWidget.body(
        value,
        textStyle: context.textTheme.titleSmall,
        weight: FontWeight.bold,
      ),
    ].toColumn();
  }

  Widget _buildReviewColumn(BuildContext context, CourseDetailModel course) {
    var style = context.textTheme.titleSmall;
    final summary = course.reviewSummary;

    return <Widget>[
      TextWidget.body(
        LocaleKeys.courseRating.tr,
        textStyle: context.textTheme.titleMedium,
      ),
      SizedBox(height: 10.h),
      if (summary.hasRatings)
        TextWidget.body(
          summary.hasRatings ? summary.ratingString : LocaleKeys.noRatings.tr,
          textStyle: style,
          weight: FontWeight.bold,
        )
      else
        TextWidget.body(
          summary.hasRatings ? summary.ratingString : LocaleKeys.noRatings.tr,
          textStyle: style,
          color: AppTheme.greyColor,
        )
    ].toColumn();
  }

  Widget _buildMainBody(BuildContext context) {
    return <Widget>[
      _buildColumnStuff(context, LocaleKeys.courseLevel.tr,
          controller.courseDetail!.levelTitle),
      _buildColumnStuff(context, LocaleKeys.videoDuration.tr,
          controller.courseDetail!.durationInHours),
      _buildColumnStuff(context, LocaleKeys.studentCount.tr,
          '${controller.courseDetail!.studentCount}'),
      _buildReviewColumn(context, controller.courseDetail!),
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround);
  }

  @override
  Widget build(BuildContext context) {
    final bkColor = context.theme.colorScheme.surface;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      color: bkColor,
      height: 75.h,
      child: _buildMainBody(context),
    );
  }
}
