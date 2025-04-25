import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class CourseDetailTableContentsWidget extends StatelessWidget {
  CourseDetailTableContentsWidget({super.key});

  final controller = Get.find<CourseDetailController>();

  Widget _buildCourseCategoryUnits(BuildContext context) {
    final units = controller.categoryUnits;
    return controller.isContentEmpty
        ? const SizedBox.shrink()
        : SliverFixedExtentList(
            itemExtent: 48.0,
            delegate: SliverChildBuilderDelegate(childCount: units.length,
                (context, index) {
              final unit = units[index];
              if (unit.isChapter) {
                return _buildCourseChapterUnit(context, unit);
              } else {
                return _buildCourseVideoUnit(context, unit);
              }
            }),
          );
  }

  Widget _buildCourseChapterUnit(
      BuildContext context, CourseTableContentUnitModel unit) {
    final style = context.textTheme.titleMedium;
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: TextWidget.body(
              unit.title,
              textStyle: style,
              maxLines: 2,
              weight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCourseVideoUnit(
      BuildContext context, CourseTableContentUnitModel unit) {
    final style = context.textTheme.titleSmall;
    final videoIconColor = unit.isFree || controller.isPruchased
        ? style?.color
        : AppTheme.greyColor;
    final title = unit.timeString != null
        ? '${unit.title}(${unit.timeString})'
        : unit.title;
    return ListTile(
      onTap: unit.isFree || controller.isPruchased ? () {} : null,
      title: <Widget>[
        SizedBox(height: 8.h),
        <Widget>[
          IconWidget.icon(
            Icons.play_circle_outline,
            size: 20,
            color: videoIconColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextWidget.body(
              title,
              textStyle: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (unit.isFree && !controller.isPruchased) SizedBox(width: 10.w),
          if (unit.isFree && !controller.isPruchased)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.commonTipColor, width: 1),
              ),
              child: TextWidget.body(
                LocaleKeys.freeWatch.tr,
                textStyle:
                    TextStyle(color: AppTheme.commonTipColor, fontSize: 10),
              ),
            ),
          SizedBox(height: 11.h),
          Divider(
            indent: 30,
            height: 1,
            thickness: 0.5,
            color: AppTheme.greyColor,
          ),
        ].toRow(),
      ].toColumn(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const PageStorageKey('content'),
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(bottom: 20.h),
          sliver: _buildCourseCategoryUnits(context),
        ),
      ],
    );
  }
}
