import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onlinelearning/common/index.dart';

class CourseReviewListCellWidget extends StatefulWidget {
  const CourseReviewListCellWidget({
    super.key,
    required this.courseId,
    required this.isMyCourse,
    this.isMyReview = false,
    required this.review,
  });

  final int courseId;
  final bool isMyCourse;
  final bool isMyReview;
  final CourseReviewModel review;

  @override
  _CourseReviewListCellWidgetState createState() =>
      _CourseReviewListCellWidgetState();
}

class _CourseReviewListCellWidgetState
    extends State<CourseReviewListCellWidget> {
  late final CourseReviewModel review;

  @override
  void initState() {
    super.initState();
    review = widget.review;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: <Widget>[
        _buildReviewTitleRow(context),
        SizedBox(height: 8.h),
        _buildContentRow(context),
        SizedBox(height: 8.h),
        _buildReviewTimeRow(context),
        _buildReplyWidget(context),
        _buildAuthorActionWidget(context),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildAuthorActionWidget(BuildContext context) {
    if (widget.isMyCourse) {
      final v = review.reply == null;
      final text = v ? LocaleKeys.reply.tr : LocaleKeys.editReply.tr;
      return <Widget>[
        SizedBox(height: 6.h, width: double.infinity),
        TextButton(
          onPressed: () =>
              Get.toNamed(RouteNames.courseCourseReviewReply, arguments: {
            'id': review.id.toString(),
            'course_id': widget.courseId.toString(),
            'rating': review.rating.toString(),
            'user': review.userName,
            'content': review.content,
            'reply_id': review.replyId?.toString() ?? '',
            'reply_content': review.reply ?? '',
          })?.then((value) {
            if (value != null && value.isNotEmpty) {
              setState(
                () {
                  review.reply = value;
                },
              );
            }
          }),
          child: Text(text),
        )
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.end);
    } else if (widget.isMyReview) {
      return <Widget>[
        SizedBox(height: 6.h, width: double.infinity),
        TextButton(
          onPressed: () {
            Get.toNamed(
              RouteNames.courseCourseReview,
              arguments: {
                'course_id': widget.courseId.toString(),
                'rating': review.rating.toString(),
                'review_content': review.content,
              },
            )?.then(
              (r) => {
                if (r != null)
                  {
                    setState(
                      () {
                        review.rating = r.rating;
                        review.content = r.content;
                        review.reviewAt = r.reviewAt;
                      },
                    ),
                  }
              },
            );
          },
          child: Text(LocaleKeys.editReview.tr),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.end);
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildReplyWidget(BuildContext context) {
    if (review.reply == null) {
      return const SizedBox.shrink();
    } else {
      final span1 = TextSpan(
        text: LocaleKeys.teacherReply.tr,
        style:
            context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
      );
      final span2 = TextSpan(
        text: review.reply,
        style: context.textTheme.bodyMedium?.copyWith(height: 1.75),
      );

      return <Widget>[
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            children: [span1, span2],
          ),
        ),
      ].toColumn();
    }
  }

  Widget _buildReviewTimeRow(BuildContext context) {
    final text = DateFormat('yyyy-MM-dd kk:mm').format(review.reviewAt);
    return SizedBox(
      width: double.infinity,
      child: TextWidget.body(
        text,
        textAlign: TextAlign.right,
        textStyle: context.textTheme.bodySmall,
      ),
    );
  }

  Widget _buildContentRow(BuildContext context) {
    return TextWidget.body(
      review.content,
      textStyle: context.textTheme.bodyMedium?.copyWith(height: 1.75),
    );
  }

  Widget _buildReviewTitleRow(BuildContext context) {
    final title = widget.isMyReview ? LocaleKeys.myReview.tr : review.userName;
    return <Widget>[
      Expanded(
        child: TextWidget.body(
          title,
          textStyle: context.textTheme.titleMedium,
          weight: FontWeight.bold,
        ),
      ),
      SizedBox(width: 8.w),
      FiveStarRatingWidget(
        rating: review.rating,
        starSize: 16,
      ),
    ].toRow();
  }
}
