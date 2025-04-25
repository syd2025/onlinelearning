import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/i18n/index.dart';
import 'package:onlinelearning/common/routers/index.dart';

import 'index.dart';

class PasswordSettingPage extends GetView<PasswordSettingController> {
  const PasswordSettingPage({super.key});

  Widget _buildOldPasswordInputWidget(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final Widget? suffixIcon;
    if (controller.password0Ready != null) {
      suffixIcon = Icon(
        controller.password0Ready! ? Icons.check : Icons.error,
        color: controller.password0Ready! ? primaryColor : Colors.red,
      );
    } else {
      suffixIcon = null;
    }
    return <Widget>[
      Text(
        LocaleKeys.oldPassword.tr,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      TextField(
        obscureText: true,
        autofocus: true,
        controller: controller.passwordController0,
        focusNode: controller.focusNode0,
        maxLength: 20,
        buildCounter: (context,
            {required currentLength, required isFocused, maxLength}) {
          return null;
        },
        decoration: InputDecoration(
          hintText: LocaleKeys.passwordHintText.tr,
          suffixIcon: suffixIcon,
        ),
      ),
      const SizedBox(height: 10),
      <Widget>[
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed(
              RouteNames.securityForgetPassword,
              arguments: {
                'prev_route': RouteNames.securitySecurityIndex,
              },
            );
          },
          child: Text(
            LocaleKeys.forgetPassword.tr,
            style:
                Get.context!.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
        ),
      ].toRow(),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildNewPasswordInputWidget(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final Widget? suffixIcon;
    if (controller.password1Ready != null) {
      suffixIcon = Icon(controller.password1Ready! ? Icons.check : Icons.error,
          color: controller.password1Ready! ? primaryColor : Colors.red);
    } else {
      suffixIcon = null;
    }

    final Widget? suffixIcon2;
    if (controller.password2Ready != null) {
      suffixIcon2 = Icon(controller.password2Ready! ? Icons.check : Icons.error,
          color: controller.password2Ready! ? primaryColor : Colors.red);
    } else {
      suffixIcon2 = null;
    }
    return <Widget>[
      Text(
        LocaleKeys.newPassword.tr,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
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
          hintText: LocaleKeys.inputNewPassword.tr,
          suffixIcon: suffixIcon,
        ),
      ),
      const SizedBox(height: 10.0),
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
          hintText: LocaleKeys.inputConfirmPassword.tr,
          suffixIcon: suffixIcon2,
        ),
      ),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
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
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  Widget _buildMainBody(BuildContext context) {
    return <Widget>[
      const SizedBox(height: 20),
      _buildOldPasswordInputWidget(context),
      const SizedBox(height: 50),
      _buildNewPasswordInputWidget(context),
      const SizedBox(height: 40),
      _buildMainButtonRow(context),
    ].toColumn().paddingHorizontal(20);
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return _buildMainBody(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordSettingController>(
      init: PasswordSettingController(),
      id: "password_setting",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.passwordSetting.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
