import 'package:cached_network_image/cached_network_image.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseLearningCellWidget extends StatelessWidget {
  CourseLearningCellWidget({super.key, required this.course, this.onTap});

  final CourseBriefModel course;
  final GestureTapCallback? onTap;

  final controller = Get.put(StudyIndexController());

  Widget _buildThumbnailWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: course.imageUrl,
        width: 90.w,
        height: 125.h,
        errorWidget: (context, url, error) =>
            const IconWidget.icon(Icons.error, color: Colors.red),
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
  }

  Widget _buildMajorTitle(BuildContext context, TextStyle? majorStyle) {
    return TextWidget.body(
      course.title,
      textStyle: majorStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      weight: FontWeight.bold,
    );
  }

  Widget _buildMinorTyleRow(BuildContext context, TextStyle? minorStyle) {
    return <Widget>[
      TextWidget.body(
        course.author,
        textStyle: minorStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: Colors.grey[500],
      ),
      SizedBox(width: 16.w),
      TextWidget.body(
        course.levelTitle,
        textStyle: minorStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: Colors.grey[500],
      ),
    ].toRow();
  }

  Widget _buildCourseVideoInfo(BuildContext context) {
    final videoCountSpan1 = TextSpan(
      text: LocaleKeys.videoCount.tr,
      style: context.textTheme.titleSmall,
    );
    final videoCountSpan2 = TextSpan(
      text: course.videoCount.toString(),
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );

    final durationSpan1 = TextSpan(
      text: LocaleKeys.duration.tr,
      style: Theme.of(context).textTheme.titleSmall,
    );
    final durationSpan2 = TextSpan(
      text: course.durationInMinutes.toString(),
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
    final durationSpan3 = TextSpan(
      text: 'm',
      style: Theme.of(context).textTheme.titleSmall,
    );

    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              videoCountSpan1,
              videoCountSpan2,
            ],
          ),
        ),
        const Spacer(),
        RichText(
          text: TextSpan(
            children: [
              durationSpan1,
              durationSpan2,
              durationSpan3,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextInfoWidget(BuildContext context) {
    final majorStyle = context.textTheme.titleMedium;
    final minorStyle = context.textTheme.titleSmall;

    return Expanded(
      child: SizedBox(
        height: 125.h,
        child: <Widget>[
          <Widget>[
            _buildMajorTitle(context, majorStyle),
            SizedBox(height: 4.h),
            _buildMinorTyleRow(context, minorStyle),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          const Spacer(),
          _buildCourseVideoInfo(context),
        ].toColumn(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyIndexController>(
      init: controller,
      id: "study_index_cell",
      builder: (_) {
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              children: [
                _buildThumbnailWidget(context),
                SizedBox(width: 16.w),
                _buildTextInfoWidget(context),
              ],
            ),
          ),
        );
      },
    );
  }
}
