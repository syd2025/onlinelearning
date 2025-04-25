import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  const ForgetPasswordPage({super.key});

  Widget _buildAccountInputRow(BuildContext context) {
    return <Widget>[
      Expanded(
        child: TextField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          controller: controller.textController,
          autofocus: true,
          focusNode: controller.focusNode,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[100],
            filled: true,
            hintText: LocaleKeys.accountHintText.tr,
          ),
        ),
      ),
    ].toRow();
  }

  Widget _buildMainButtonRow(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.canSubmit ? controller.mainButtonPressed : null,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
          ),
        ),
        child: Text(
          LocaleKeys.submit.tr,
          style: Get.textTheme.titleMedium,
        ),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return <Widget>[
      const SizedBox(height: 20),
      _buildAccountInputRow(context),
      const SizedBox(height: 30),
      _buildMainButtonRow(context),
    ].toColumn().paddingHorizontal(20);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      id: "forget_password",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.findPassword.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
