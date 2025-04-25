import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class StudyCourseTabWidget extends StatefulWidget {
  const StudyCourseTabWidget({super.key});

  @override
  State<StudyCourseTabWidget> createState() => _StudyCourseTabWidgetState();
}

class _StudyCourseTabWidgetState extends State<StudyCourseTabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _pages;
  final controller = Get.find<StudyCourseController>();

  @override
  void initState() {
    super.initState();
    // 初始化 TabController
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _pages = [
      StudyCourseTableContentsWidget(), // 第一个分页
      if (controller.isContentEmpty)
        const SizedBox.shrink()
      else
        CourseDetailBriefWidget(
            courseDetail: controller.courseDetail!), // 第二个分页

      StudyCourseReviewWidget(), // 第三个分页
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTabBar(BuildContext context) {
    final bkcolor = context.theme.colorScheme.surface;
    return Container(
      height: 44.h,
      color: bkcolor,
      child: TabBar(
        controller: _tabController,
        indicatorColor: context.theme.colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerHeight: 0.5.h,
        dividerColor: context.theme.colorScheme.surface,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelPadding: EdgeInsets.symmetric(horizontal: 20.w),
        labelStyle: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: context.theme.colorScheme.primary,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 17,
          color: context.theme.colorScheme.onSurfaceVariant,
        ),
        tabs: [
          Tab(text: LocaleKeys.courseBrief.tr),
          Tab(text: LocaleKeys.courseCatalog.tr),
          Tab(text: LocaleKeys.courseComment.tr),
        ],
      ),
    );
  }

  Widget _buildTabBody(BuildContext context) {
    _tabController.addListener(() {
      if (_tabController.index != controller.currentTabIndex) {
        controller.changeTabIndex(_tabController.index);
      }
    });

    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: _pages,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _buildTabBar(context),
          _buildTabBody(context),
        ],
      ),
    );
  }
}
