import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseRatingSummaryWidget extends StatelessWidget {
  final CourseReviewSummaryModel summary;

  const CourseRatingSummaryWidget({super.key, required this.summary});

  Widget _buildStarProgressRow(
      BuildContext context, int star, int reviewCount, int totalCount) {
    final color = context.theme.textTheme.titleMedium?.color;
    final greyColor = AppTheme.greyColor.withAlpha(128);
    return <Widget>[
      SizedBox(
        width: 80.w,
        child: Row(
          children: [
            const Spacer(),
            ...List.generate(
              star,
              (index) {
                return Icon(Icons.star, color: color, size: 10);
              },
            ),
          ],
        ),
      ),
      SizedBox(width: 10.w),
      Expanded(
        flex: totalCount > 0 ? reviewCount : 1,
        child: Container(
          color: color,
          height: 3.h,
          width: totalCount > 0 ? null : 0,
        ),
      ),
      Expanded(
        flex: totalCount > 0 ? (totalCount - reviewCount) : 1,
        child: Container(
          color: greyColor,
          height: 3.h,
          width: totalCount > 0 ? null : 0,
        ),
      ),
    ].toRow();
  }

  Widget _buildTextInfoWidget(BuildContext context) {
    return <Widget>[
      TextWidget.h1(
        summary.rating.toStringAsFixed(1),
        textStyle: TextStyle(
          fontSize: 60,
          color: context.textTheme.titleMedium?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 10.h),
      Text(
        LocaleKeys.fullScoreTip.tr,
        style: TextStyle(
          fontSize: 14,
          color: AppTheme.greyColor,
        ),
      ),
    ].toColumn();
  }

  Widget _buildRatingDistributeWidget(BuildContext context) {
    final totalCount = summary.totalCount;
    final star1Count = summary.ratingCounts?[1] ?? 0;
    final star2Count = summary.ratingCounts?[2] ?? 0;
    final star3Count = summary.ratingCounts?[3] ?? 0;
    final star4Count = summary.ratingCounts?[4] ?? 0;
    final star5Count = summary.ratingCounts?[5] ?? 0;

    return Expanded(
      child: <Widget>[
        _buildStarProgressRow(context, 5, star5Count, totalCount),
        SizedBox(height: 1.h),
        _buildStarProgressRow(context, 4, star4Count, totalCount),
        SizedBox(height: 1.h),
        _buildStarProgressRow(context, 3, star3Count, totalCount),
        SizedBox(height: 1.h),
        _buildStarProgressRow(context, 2, star2Count, totalCount),
        SizedBox(height: 1.h),
        _buildStarProgressRow(context, 1, star1Count, totalCount),
        SizedBox(height: 10.h),
        Text(
          '$totalCount ${LocaleKeys.reviewCountTip.tr}',
          style:
              context.textTheme.bodySmall?.copyWith(color: AppTheme.greyColor),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.end),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (summary.hasRatings == false) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: <Widget>[
          _buildTextInfoWidget(context),
          SizedBox(width: 20.w),
          _buildRatingDistributeWidget(context),
        ].toRow(crossAxisAlignment: CrossAxisAlignment.center),
      );
    }
  }
}
