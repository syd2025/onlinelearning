import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class CredentialSettingPage extends GetView<CredentialSettingController> {
  const CredentialSettingPage({super.key});

  Widget _buildInputTextFeild(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).colorScheme.surface.withAlpha(128),
      child: <Widget>[
        Text(controller.inputPreText, style: Get.textTheme.titleMedium),
        const SizedBox(width: 5),
        Expanded(
          child: TextField(
            keyboardType: controller.inputType,
            controller: controller.textController,
            focusNode: controller.focusNode,
            decoration: InputDecoration(
              hintText: controller.inputHintText,
              hintStyle:
                  Get.textTheme.titleMedium?.copyWith(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ].toRow(),
    );
  }

  Widget _buildMainButtonRow(BuildContext context) {
    return <Widget>[
      const SizedBox(width: 20),
      Expanded(
        child: SizedBox(
          height: 44,
          child: ElevatedButton(
            onPressed: controller.validCredential
                ? controller.mainButtonPressed
                : null,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            child: Text(
              controller.buttonTitle,
              style: Get.textTheme.titleMedium,
            ),
          ),
        ),
      ),
      const SizedBox(width: 20),
    ].toRow(mainAxisAlignment: MainAxisAlignment.center);
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      const SizedBox(height: 20),
      _buildInputTextFeild(context),
      const SizedBox(height: 20),
      _buildMainButtonRow(context),
    ].toColumn();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CredentialSettingController>(
      init: CredentialSettingController(),
      id: "credential_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(controller.title)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
