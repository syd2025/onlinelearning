import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyCourseReviewWidget extends StatelessWidget {
  StudyCourseReviewWidget({super.key});

  final controller =
      Get.find<StudyCourseController>(); // 这里需要引入 GetX 的 Get 方法，用于获取控制器实例。

  Widget _buildMyReview(BuildContext context) {
    return SliverToBoxAdapter(
      child: controller.myReview != null
          ? CourseReviewListCellWidget(
              review: controller.myReview!,
              courseId: controller.courseId,
              isMyCourse: false,
              isMyReview: true,
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Center(
                    child: ButtonWidget.primary(
                      LocaleKeys.writeReivew.tr,
                      onTap: () {
                        Get.toNamed(
                          RouteNames.courseCourseReview,
                          arguments: {
                            'course_id': controller.courseId.toString(),
                            'rating': '5',
                          },
                        )?.then(
                          (v) {
                            if (v != null) {
                              controller.assignMyReview(v);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
    );
  }

  Widget _buildReviewList(BuildContext context) {
    if (controller.isReviewEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: ImageWidget.img(
            AssetsImages.noContent.tr,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      final canLoadMore = controller.canLoadMoreReviews;
      final reviews = controller.reviews ?? [];
      final itemCount =
          canLoadMore ? controller.reviewCount + 1 : controller.reviewCount;
      return SliverList(
        delegate:
            SliverChildBuilderDelegate(childCount: itemCount, (context, index) {
          final review = index < reviews.length ? reviews[index] : null;
          final courseId = controller.courseId;
          if (review != null) {
            return CourseReviewListCellWidget(
              review: review,
              courseId: courseId,
              isMyCourse: false,
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Builder(
                  builder: (context) {
                    Future.delayed(Duration.zero, () {
                      controller.loadReviews();
                    });
                    return const CupertinoActivityIndicator();
                  },
                ),
              ),
            );
          }
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyCourseController>(
      init: controller,
      id: "study_course_review", // 这里需要指定一个唯一的 ID，用于区分不同的控制器实例。,
      builder: (_) {
        return CustomScrollView(
          key: const PageStorageKey('review'),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            SliverToBoxAdapter(child: Builder(
              builder: (context) {
                final summary = controller.courseDetail?.reviewSummary;
                if (summary != null) {
                  return CourseRatingSummaryWidget(summary: summary);
                } else {
                  return const SizedBox.shrink();
                }
              },
            )),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            _buildMyReview(context),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
            _buildReviewList(context),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        );
      },
    );
  }
}
