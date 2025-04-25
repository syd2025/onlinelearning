import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class NicknameSettingPage extends GetView<NicknameSettingController> {
  const NicknameSettingPage({super.key});

  // 主视图
  Widget _buildView() {
    return <Widget>[
      const SizedBox(height: 15),
      Obx(
        () => TextField(
          decoration: InputDecoration(
            labelText: LocaleKeys.nickname.tr,
            hintText: LocaleKeys.nicknameHint.tr,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            suffix: Text("${controller.leftCount}"),
          ),
          controller: controller.textController,
          focusNode: controller.focusNode,
          autofocus: true,
          maxLength: 20,
          buildCounter: (context,
                  {required currentLength,
                  required isFocused,
                  required maxLength}) =>
              null,
        ),
      ),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    final fontSize =
        (Theme.of(context).appBarTheme.titleTextStyle?.fontSize ?? 20) - 2;
    return GetBuilder<NicknameSettingController>(
      init: NicknameSettingController(),
      id: "nickname_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.updateNickName.tr), actions: [
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: fontSize)),
              onPressed: controller.okAction,
              child: Text(LocaleKeys.ok.tr),
            ),
          ]),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
