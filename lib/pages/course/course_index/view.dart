import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseIndexPage extends GetView<CategoryIndexController> {
  const CourseIndexPage({super.key});

  Widget _buildMajorCategoryWidget(
      BuildContext context, List<String> majorTitles) {
    final majorIndex = controller.majorCategoryIndex;
    // 调整颜色方案
    final defaultColor = Theme.of(context).colorScheme.surface;
    final selectedColor = Theme.of(context).colorScheme.primary;
    final titleDefaultColor = Theme.of(context).colorScheme.onSurface;
    final titleSelectedColor = Theme.of(context).colorScheme.onPrimary;

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false),
      child: ListView.builder(
        itemCount: majorTitles.length,
        itemBuilder: (context, index) {
          final title = majorTitles[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Material(
              color: index == majorIndex ? selectedColor : defaultColor,
              shape: RoundedRectangleBorder(
                // 添加圆角
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                splashColor: selectedColor.withValues(alpha: 0.2),
                onTap: () {
                  if (index < majorTitles.length - 1) {
                    controller.majorCategoryIndex = index;
                  } else {
                    controller.jumpToCourseList(0, LocaleKeys.allCourses.tr);
                  }
                },
                child: SizedBox(
                  height: 60,
                  child: ListTile(
                    titleTextStyle: TextStyle(
                      color: index == majorIndex
                          ? titleSelectedColor
                          : titleDefaultColor,
                      fontWeight: index == majorIndex
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    title: Text(title),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMinorCategoryWidget(BuildContext context) {
    final minorCategories = controller.minorCategories ?? [];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 100,
          mainAxisSpacing: 12, // 添加垂直间距
          crossAxisSpacing: 12, // 添加水平间距
        ),
        itemCount: minorCategories.length + 1,
        itemBuilder: (context, index) {
          String title;
          Widget image;
          final color = Theme.of(context).textTheme.labelLarge!.color;
          if (index == 0) {
            title = LocaleKeys.all.tr;
            image = Icon(Icons.apps, size: 40, color: color);
          } else {
            title = minorCategories[index - 1].title;
            final icon = minorCategories[index - 1].icon;
            image = Image.asset('assets/icons/categories/$icon',
                width: 40, height: 40);
          }
          return InkWell(
            onTap: () {
              int id;
              String nextTitle;
              if (index == 0) {
                id = controller.majorCategoryId;
                nextTitle =
                    controller.categories[controller.majorCategoryIndex].title;
              } else {
                id = minorCategories[index - 1].id;
                nextTitle = title;
              }
              controller.jumpToCourseList(id, nextTitle);
            },
            child: Center(
              child: Column(
                children: [
                  const Spacer(),
                  image,
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentWidget(BuildContext context) {
    final categories = controller.categories;
    final majorTitles = categories.map((e) => e.title).toList();
    majorTitles.add(LocaleKeys.allCourses.tr);
    return <Widget>[
      Container(
        width: 120,
        decoration: BoxDecoration(
          // 添加装饰效果
          color: context.theme.colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(-2, 0),
                  ),
                ],
              ),
              child: _buildMajorCategoryWidget(context, majorTitles)),
        ),
      ),
      Expanded(
        child: _buildMinorCategoryWidget(context),
      ),
    ].toRow();
  }

  Widget _buildMainBody(BuildContext context, List<String>? keys) {
    if (controller.isCategoryEmpty) {
      return EmptyContentWidget(
        loading: controller.loading,
        error: controller.error,
        reloadAction: controller.loadAllCategories,
      );
    }
    return _buildContentWidget(context);
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return _buildMainBody(
      context,
      controller.topCourseKeys,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final tipColor = AppTheme.appBarSearchTextTip;
    final titleStyle = context.theme.textTheme.titleMedium!.copyWith(
      color: tipColor,
      fontWeight: FontWeight.w600,
    );
    return AppBar(
      title: GestureDetector(
        onTap: controller.jumpToSearchPage,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Get.context!.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
          ),
          child: <Widget>[
            SizedBox(
              width: 36.w,
              height: 36.h,
              child: IconWidget.icon(
                Icons.search,
                color: tipColor,
              ),
            ),
            SizedBox(width: 6.w),
            RollingTextWidget(titleStyle: titleStyle),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
      actions: [
        ShoppingCartButtonWidget().marginOnly(top: 10.h),
        SizedBox(width: 20.w),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryIndexController>(
      init: CategoryIndexController(),
      id: "category_index",
      builder: (_) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
