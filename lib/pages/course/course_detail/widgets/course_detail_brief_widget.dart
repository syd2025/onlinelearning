import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseDetailBriefWidget extends StatelessWidget {
  const CourseDetailBriefWidget({super.key, required this.courseDetail});

  final CourseDetailModel courseDetail;

  Widget _buildCourseDescription(BuildContext context) {
    final desc = courseDetail.description;
    final titleStyle = context.textTheme.titleMedium;
    final bodyStyle = context.textTheme.bodyMedium;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: context.theme.colorScheme.surface.withAlpha(128),
      child: <Widget>[
        SizedBox(height: 15.h),
        TextWidget.body(
          LocaleKeys.courseDescription.tr,
          textStyle: titleStyle,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 5.h),
        TextWidget.body(
          desc,
          textStyle: bodyStyle,
          size: 17.5,
        ),
        SizedBox(height: 15.h),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildCourseSkills(BuildContext context) {
    final v = courseDetail.skills;
    final titleStyle = context.textTheme.titleMedium;
    final bodyStyle = context.textTheme.bodyMedium?.copyWith(height: 1.75);
    var index = 1;
    final skills = v
        .map((e) => TextSpan(text: '${index++}、$e\n', style: bodyStyle))
        .toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: <Widget>[
        SizedBox(height: 15.h),
        TextWidget.body(
          LocaleKeys.courseSkills.tr,
          textStyle: titleStyle,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 5.h),
        RichText(text: TextSpan(children: skills)),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildAuthorIntroduction(BuildContext context) {
    final intro = courseDetail.author.introduction;
    if (intro != null) {
      final titleStyle = context.textTheme.titleMedium;
      final bodyStyle = context.textTheme.bodyMedium?.copyWith(height: 1.75);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).colorScheme.surface.withAlpha(128),
        child: <Widget>[
          SizedBox(height: 15.h),
          TextWidget.body(
            LocaleKeys.authorIntroduction.tr,
            textStyle: titleStyle,
            weight: FontWeight.bold,
          ),
          SizedBox(height: 5.h),
          TextWidget.body(intro, textStyle: bodyStyle),
          SizedBox(height: 15.h),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey("brief"),
      slivers: [
        SliverToBoxAdapter(
          child: <Widget>[
            _buildCourseDescription(context),
            _buildCourseSkills(context),
            _buildAuthorIntroduction(context),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ],
    );
  }
}
