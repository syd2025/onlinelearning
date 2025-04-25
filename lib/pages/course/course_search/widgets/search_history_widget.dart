import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class SearchHistoryWidget extends StatelessWidget {
  SearchHistoryWidget({super.key});

  final controller = Get.find<CourseSearchController>();

  Widget _buildMainBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextWidget.body(
                LocaleKeys.searchHistory.tr,
                textStyle: context.textTheme.bodyLarge,
              ),
              const Spacer(),
              GestureDetector(
                onTap: controller.clearSearchHistories,
                child: IconWidget.icon(
                  Icons.delete_forever,
                  color: Colors.grey[500],
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.searchHistories.map((text) {
              return GestureDetector(
                onTap: () {
                  controller.updateSearchText(text);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.primary
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextWidget.body(
                    text,
                    textStyle: context.textTheme.bodySmall,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isSearchHistoryEmpty) {
      return const SizedBox.shrink();
    } else {
      return _buildMainBody(context);
    }
  }
}
