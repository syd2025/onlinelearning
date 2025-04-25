import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CourseLoadingCellWidget extends StatelessWidget {
  const CourseLoadingCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CupertinoActivityIndicator(),
            const SizedBox(width: 8),
            Text(
              LocaleKeys.loadingMore.tr,
              style: Get.context!.textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
