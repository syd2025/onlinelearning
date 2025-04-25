import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class HotSearchWidget extends StatelessWidget {
  HotSearchWidget({super.key});

  final controller = Get.find<CourseSearchController>();

  Widget _buildMainBody(BuildContext context, List<String>? keys) {
    if (keys == null || keys.isEmpty) {
      return const SizedBox.shrink();
    }

    final topKeys = keys;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.hotSearch.tr,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 10,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: topKeys.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final key = topKeys[index];
                      controller.updateSearchText(key);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          topKeys[index],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainBody(context, controller.topCourseKeys);
  }
}
