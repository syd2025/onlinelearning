import 'package:cached_network_image/cached_network_image.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailHeaderWidget extends StatelessWidget {
  CourseDetailHeaderWidget({super.key});

  final controller = Get.find<CourseDetailController>();

  Widget _buildTextInfoWidget(BuildContext context, CourseDetailModel course) {
    final majorTitleStyle =
        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final minorTitleStyle =
        context.textTheme.titleSmall?.copyWith(color: Colors.grey[500]);
    return Expanded(
      child: SizedBox(
        height: 115.h,
        child: <Widget>[
          <Widget>[
            TextWidget.body(
              course.title,
              textStyle: majorTitleStyle,
              maxLines: 2,
              weight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.h),
            TextWidget.body(
              course.minorTitle,
              textStyle: minorTitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          const Spacer(),
          _buildFooterTextRow(context, course),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }

  Widget _buildFooterTextRow(BuildContext context, CourseDetailModel course) {
    final primaryColor = context.theme.colorScheme.primary;
    final refundTipColor = AppTheme.commonTipColor;

    String tipString;
    if (controller.isMyCourse) {
      tipString = LocaleKeys.myCourses.tr;
    } else if (controller.isPruchased) {
      tipString = LocaleKeys.courseAlreadyPurchased.tr;
    } else {
      tipString = LocaleKeys.refoundTip.tr;
    }

    return <Widget>[
      TextWidget.body(
        '¥ ${course.price}',
        weight: FontWeight.bold,
        color: primaryColor,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        margin: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: refundTipColor, width: 0.5.w),
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextWidget.body(
          tipString,
          textStyle: TextStyle(color: refundTipColor, fontSize: 10),
        ),
      ),
    ].toRow();
  }

  Widget _buildThumbnailWidget(BuildContext context, String imgUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        width: 90,
        height: 120,
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(
          radius: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.surface,
      child: <Widget>[
        _buildThumbnailWidget(context, controller.courseDetail!.imageUrl),
        SizedBox(width: 16.w),
        _buildTextInfoWidget(context, controller.courseDetail!),
      ].toRow(),
    ).paddingSymmetric(horizontal: 16.w, vertical: 10.h);
  }
}
