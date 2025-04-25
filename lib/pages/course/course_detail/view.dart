import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class CourseDetailPage extends GetView<CourseDetailController> {
  const CourseDetailPage({super.key});

  Widget _buildMainBody(BuildContext context) {
    if (controller.isContentEmpty) {
      return EmptyContentWidget(
        loading: controller.loading,
        error: controller.error,
        reloadAction: controller.loadCourseDetail,
      );
    } else {
      return _buildContentBody(context);
    }
  }

  void startAnimation(BuildContext context) {
    controller.animatedOverlayEntry = createAnimatedOverlayEntry();
    Overlay.of(context).insert(controller.animatedOverlayEntry);
    controller.animatedController.forward();
  }

  OverlayEntry createAnimatedOverlayEntry() {
    final renderBox1 = controller.bottomPurchaseButtonKey.currentContext
        ?.findRenderObject() as RenderBox;
    final startSize = renderBox1.size;
    final startOffset = renderBox1.localToGlobal(
        Offset(startSize.width * 0.5 - 8, startSize.height * 0.5 - 8));
    final renderBox2 = controller.appbarShoppingCartButtonKey.currentContext
        ?.findRenderObject() as RenderBox;
    final endSize = renderBox2.size;
    final endOffset = renderBox2.localToGlobal(
        Offset(endSize.width * 0.5 - 8, endSize.height * 0.5 - 8));
    final tween = Tween<Offset>(begin: startOffset, end: endOffset);
    controller.animation = tween.animate(controller.animatedController);
    return OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          builder: (context, child) {
            return Positioned(
              top: controller.animation.value.dy,
              left: controller.animation.value.dx,
              child: _buildMovingWidget(),
            );
          },
          animation: controller.animation,
        );
      },
    );
  }

  Widget _buildMovingWidget() {
    return Container(
      padding: EdgeInsets.all(1.w),
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextWidget.body(
          "1",
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 11,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 内容视图
  Widget _buildContentBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        controller: controller.mainScrollController,
        headerSliverBuilder: (context, isInnerBoxScrolled) {
          return [
            SliverToBoxAdapter(
              child: CourseDetailHeaderWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
            SliverToBoxAdapter(
              child: CourseDetailSummaryWidget(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 5),
            ),
          ];
        },
        body: CourseDetailTabWidget(),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return _buildMainBody(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CourseDetailController>(
      init: CourseDetailController(),
      id: "course_detail",
      builder: (_) {
        return Scaffold(
          appBar: CourseDetailAppbarWidget(
              shoppingCartButtonKey: controller.appbarShoppingCartButtonKey),
          body: SafeArea(
            child: _buildView(context),
          ),
          bottomNavigationBar: CourseDetailBottomWidget(
            purchaseButtonKey: controller.bottomPurchaseButtonKey,
            startAnimation: () => startAnimation(context),
          ),
        );
      },
    );
  }
}
