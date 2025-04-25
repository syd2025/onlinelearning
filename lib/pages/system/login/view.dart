import 'dart:io';

import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  Widget _buildAccountInputRow(BuildContext context) {
    return <Widget>[
      Expanded(
        child: TextField(
          enabled: !controller.isFetching,
          keyboardType: controller.keyboardType,
          textInputAction: TextInputAction.done,
          controller: controller.accountController,
          autofocus: true,
          focusNode: controller.acountFocusNode,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide.none,
            ),
            fillColor: AppTheme.primary.withAlpha(10),
            filled: true,
            hintText: controller.inputHitText,
            suffixIcon: controller.accountController.text.isNotEmpty
                ? IconButton(
                    onPressed: controller.clearAccountText,
                    icon: const Icon(Icons.close_rounded),
                  )
                : null,
          ),
        ),
      )
    ].toRow();
  }

  Widget _buildTitleRow(BuildContext context) {
    return <Widget>[
      <Widget>[
        if (controller.type == LoginInputType.accountPassword)
          Text(
            LocaleKeys.passwordLogin.tr,
            style: Get.textTheme.titleLarge,
          ),
        if (controller.type == LoginInputType.phoneVerifyCode)
          Text(
            LocaleKeys.phoneVerifyCodeLogin.tr,
            style: Get.textTheme.titleLarge,
          ),
        if (controller.type == LoginInputType.emailVerifyCode)
          Text(
            LocaleKeys.emailVerifyCodeLogin.tr,
            style: Get.textTheme.titleLarge,
          ),
        const SizedBox(height: 10),
        if (controller.type == LoginInputType.accountPassword)
          Text(
            "",
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
        if (controller.type == LoginInputType.phoneVerifyCode)
          Text(
            LocaleKeys.phoneVerifyTip.tr,
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
        if (controller.type == LoginInputType.emailVerifyCode)
          Text(
            LocaleKeys.emailVerifyTip.tr,
            style: Get.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

  // 底部按钮
  Widget _buildMainButtonRow(BuildContext context) {
    return <Widget>[
      Expanded(
        child: SizedBox(
          height: 44.h,
          child: ElevatedButton(
            onPressed: controller.mainButtonEnabled
                ? () => controller.mainButtonPressed(context)
                : null,
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            child: TextWidget.body(
              controller.mainButtonText,
              textStyle: context.textTheme.titleLarge,
            ),
          ),
        ),
      )
    ].toRow(mainAxisAlignment: MainAxisAlignment.center);
  }

  Widget _buildPasswordInputRow(BuildContext context) {
    return controller.type == LoginInputType.accountPassword
        ? <Widget>[
            SizedBox(height: 10.h),
            TextField(
              enabled: !controller.isFetching,
              textInputAction: TextInputAction.done,
              controller: controller.passwordController,
              obscureText: controller.obscurePassword,
              focusNode: controller.passwordFocusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppTheme.primary.withAlpha(10),
                filled: true,
                hintText: LocaleKeys.passwordHintText.tr,
                suffixIcon: IconButton(
                  icon: controller.obscurePassword
                      ? const Icon(Icons.visibility_off,
                          color: Colors.grey, size: 20)
                      : const Icon(Icons.visibility,
                          color: Colors.grey, size: 20),
                  onPressed: controller.switchPasswordVisible,
                ),
              ),
            ),
          ].toColumn()
        : const SizedBox.shrink();
  }

  Widget _buildSmallButtonRow(BuildContext context) {
    final style = Get.textTheme.titleSmall?.copyWith(color: Colors.grey);
    return <Widget>[
      if (controller.type == LoginInputType.accountPassword) // 密码登录
        GestureDetector(
          onTap: controller.switchLoginType,
          child: TextWidget.body(
            LocaleKeys.phoneVerifyCodeLogin.tr,
            textStyle: style,
          ),
        ),
      if (controller.type == LoginInputType.phoneVerifyCode) // 手机验证码登录
        GestureDetector(
          onTap: controller.switchLoginType,
          child: TextWidget.body(
            LocaleKeys.emailVerifyCodeLogin.tr,
            textStyle: style,
          ),
        ),
      if (controller.type == LoginInputType.emailVerifyCode) // 邮件验证码登录
        GestureDetector(
          onTap: controller.switchLoginType,
          child: TextWidget.body(
            LocaleKeys.passwordLogin.tr,
            textStyle: style,
          ),
        ),
      const Spacer(),
      GestureDetector(
        onTap: controller.jumpToForgetPassword,
        child: TextWidget.body(
          LocaleKeys.forgetPassword.tr,
          textStyle: style,
        ),
      )
    ].toRow();
  }

  // 主体部分
  Widget _buildMainBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: <Widget>[
          Expanded(
            child: <Widget>[
              _buildTitleRow(context),
              const SizedBox(height: 20),
              _buildAccountInputRow(context),
              const SizedBox(height: 20),
              _buildPasswordInputRow(context),
              const SizedBox(height: 20),
              _buildMainButtonRow(context),
              const SizedBox(height: 20),
              _buildSmallButtonRow(context),
              const Spacer(),
              _extraLoginButtonRow(context),
              const SizedBox(height: 20),
              _buildFooterRow(context),
            ].toColumn().padding(horizontal: 20),
          ),
        ].toColumn().marginOnly(bottom: 20),
      ),
    );
  }

  // 主视图
  Widget _buildView(BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: _buildMainBody(context),
    ).onTap(controller.resignFocus);
  }

  // 第三方登录按钮
  Widget _buildCircleImageLoginButton(
      BuildContext context, String image, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Get.context!.theme.colorScheme.surface.withValues(alpha: 0.5),
        ),
        child: Center(
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
            child: ImageWidget.img(image, width: 25.w),
          ),
        ),
      ),
    );
  }

  // 第三方登录按钮以及实现
  Widget _extraLoginButtonRow(BuildContext context) {
    return <Widget>[
      _buildCircleImageLoginButton(context, AssetsImages.wechat, () {}),
      _buildCircleImageLoginButton(context, AssetsImages.qq, () {}),
      _buildCircleImageLoginButton(context, AssetsImages.weibo, () {}),
      if (Platform.isIOS || Platform.isMacOS)
        _buildCircleImageLoginButton(context, AssetsImages.apple, () {}),
      if (Platform.isAndroid)
        _buildCircleImageLoginButton(context, AssetsImages.google, () {}),
    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly);
  }

  // 协议
  Widget _buildFooterRow(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final normalStyle = Get.textTheme.titleSmall?.copyWith(color: Colors.grey);
    final linkStyle = Get.textTheme.titleSmall?.copyWith(color: primary);

    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
      child: <Widget>[
        DotRadioButtonWidget(
          radius: 7,
          strokeColor: Colors.grey,
          strokeWidth: 1,
          dotColor: primary,
          onChanged: controller.agreeDealChanged,
          value: controller.agreeDeal,
          enabled: !controller.isFetching,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: ProtocolTipText(
            startText: LocaleKeys.loginFooterText1.tr,
            normalStyle: normalStyle,
            linkStyle: linkStyle,
          ),
        ),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      id: "login",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.login.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
