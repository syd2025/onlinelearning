import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'index.dart';

class PinPage extends GetView<PinController> {
  const PinPage({super.key});

  Widget _buildPinCodeInput(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
      ],
      keyboardType: TextInputType.text,
      controller: controller.textController,
      focusNode: controller.focusNode,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Theme.of(context).colorScheme.surface,
        inactiveFillColor: Theme.of(context).colorScheme.surface.withAlpha(128),
        inactiveColor: Colors.grey,
        activeColor: Theme.of(context).colorScheme.primary,
        selectedFillColor: Theme.of(context).colorScheme.surface,
        selectedColor: Theme.of(context).colorScheme.primary,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
    );
  }

  Widget _buildPasswordInputWidget(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final Widget? suffixIcon1;
    final Widget? suffixIcon2;
    if (controller.password1Ready != null) {
      suffixIcon1 = Icon(controller.password1Ready! ? Icons.check : Icons.error,
          color: controller.password1Ready! ? primaryColor : Colors.red);
    } else {
      suffixIcon1 = null;
    }
    if (controller.password2Ready != null) {
      suffixIcon2 = Icon(controller.password1Ready! ? Icons.check : Icons.error,
          color: controller.password1Ready! ? primaryColor : Colors.red);
    } else {
      suffixIcon2 = null;
    }
    if (controller.submitType == ActionType.kResetPassword) {
      return <Widget>[
        TextField(
          obscureText: true,
          autofocus: true,
          controller: controller.passwordController1,
          focusNode: controller.focusNode1,
          maxLength: 20,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            return null;
          },
          decoration: InputDecoration(
            labelText: LocaleKeys.newPassword.tr,
            hintText: LocaleKeys.inputNewPassword.tr,
            suffixIcon: suffixIcon1,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          obscureText: true,
          controller: controller.passwordController2,
          focusNode: controller.focusNode2,
          maxLength: 20,
          buildCounter: (context,
              {required currentLength, required isFocused, maxLength}) {
            return null;
          },
          decoration: InputDecoration(
            labelText: LocaleKeys.confirmPassword.tr,
            hintText: LocaleKeys.inputConfirmPassword.tr,
            suffixIcon: suffixIcon2,
          ),
        ),
      ].toColumn();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget buildMainButtonRow(BuildContext context) {
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
  Widget buildView(BuildContext context) {
    return <Widget>[
      const SizedBox(height: 20),
      Text(LocaleKeys.inputVerifyCode.tr),
      const SizedBox(height: 10),
      _buildPinCodeInput(context),
      const SizedBox(height: 20),
      _buildPasswordInputWidget(context),
      const SizedBox(height: 30),
      buildMainButtonRow(context),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .paddingHorizontal(20);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PinController>(
      init: PinController(),
      id: "pin",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(controller.title)),
          body: SafeArea(
            child: buildView(context),
          ),
        );
      },
    );
  }
}
