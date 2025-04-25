import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class RollingTextWidget extends StatelessWidget {
  RollingTextWidget({super.key, this.titleStyle});

  final controller = Get.put(CategoryIndexController());

  final TextStyle? titleStyle;

  /// 滚动流
  late final Stream<int> _stream =
      Stream.periodic(const Duration(seconds: 3), (i) => i);

  Widget _buildMainBody(BuildContext context, List<String>? keys) {
    if (keys == null) {
      return TextWidget.body(
        LocaleKeys.searchCourse.tr,
        textStyle: titleStyle,
      );
    }

    final groupedKeys = keys;
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        final index = snapshot.data ?? 0;
        final String prevKey;
        if (index == 0) {
          prevKey = LocaleKeys.searchCourse.tr;
        } else {
          prevKey = groupedKeys[(index - 1) % groupedKeys.length];
        }
        final key = groupedKeys[index % groupedKeys.length];
        final toggle = index % 2 == 1;
        return ClipRect(
          child: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                final Tween<Offset> tween;
                if (toggle) {
                  tween = Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, 0));
                } else {
                  tween = Tween<Offset>(
                      begin: const Offset(0, 1), end: const Offset(0, 0));
                }
                return SlideTransition(
                  position: tween.animate(animation),
                  child: child,
                );
              },
              child: toggle
                  ? const SizedBox.shrink()
                  : Text(
                      toggle ? prevKey : key,
                      key: const ValueKey<String>('key1'),
                      style: titleStyle,
                    ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final Tween<Offset> tween;
                if (toggle) {
                  tween = Tween<Offset>(
                      begin: const Offset(0, 1), end: const Offset(0, 0));
                } else {
                  tween = Tween<Offset>(
                      begin: const Offset(0, -1), end: const Offset(0, 0));
                }

                return SlideTransition(
                  position: tween.animate(animation),
                  child: child,
                );
              },
              child: toggle
                  ? Text(
                      toggle ? key : prevKey,
                      key: const ValueKey<String>('key2'),
                      style: titleStyle,
                    )
                  : const SizedBox.shrink(),
            ),
          ].toStack(alignment: Alignment.centerLeft),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      id: "rolling_text",
      init: controller,
      builder: (controller) =>
          _buildMainBody(context, controller.topCourseKeys),
    );
  }
}
