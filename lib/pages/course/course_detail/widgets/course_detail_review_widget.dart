import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailReviewWidget extends StatelessWidget {
  CourseDetailReviewWidget({super.key});

  final controller = Get.find<CourseDetailController>();

  Widget _buidMainBody(BuildContext context) {
    if (controller.isReviewEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: ImageWidget.img(
            AssetsImages.noContent,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      final canLoadMore = controller.canLoadMoreReivews;
      final reviews = controller.reviews;
      final itemCount = canLoadMore ? reviews.length + 1 : reviews.length;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final reivew = index < reviews.length ? reviews[index] : null;
            final courseId = controller.courseId;
            final isMyCourse = controller.isMyCourse;
            if (reivew != null) {
              return CourseReviewListCellWidget(
                review: reivew,
                courseId: courseId,
                isMyCourse: isMyCourse,
                isMyReview: reivew.userId == UserService.to.accountId,
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Builder(
                    builder: (context) {
                      Future.delayed(Duration.zero, () {
                        controller.loadReviews();
                      });
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              );
            }
          },
          childCount: itemCount,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        id: "course_detail_review",
        builder: (_) {
          return CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  final summary = controller.courseDetail?.reviewSummary;
                  if (summary != null) {
                    return CourseRatingSummaryWidget(summary: summary);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            _buidMainBody(context),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          ]);
        });
  }
}
