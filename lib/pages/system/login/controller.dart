import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:rxdart/rxdart.dart';

class LoginController extends GetxController {
  LoginController();

  late final _cancelToken = CancelToken();
  late final acountFocusNode = FocusNode();
  late final passwordFocusNode = FocusNode();
  bool isFetching = false;
  bool obscurePassword = true;
  bool agreeDeal = false;
  bool _isEmailText = false;
  bool _isPhoneText = false;
  bool _isPasswdValid = false;
  // 对用户输入框进行监听
  late final accountSubject = PublishSubject<String>();
  late final passwordSubject = PublishSubject<String>();
  late final StreamSubscription<String> _accountSubscription;
  late final StreamSubscription<String> _passwordSubscription;

  late final _emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  late final _phoneRegex = RegExp(r'^1[3-9]\d{9}$');

  /// 用户名
  TextEditingController accountController =
      TextEditingController(text: "admin@qq.com");

  /// 密码
  TextEditingController passwordController =
      TextEditingController(text: "123456789");

  /// 表单 key
  GlobalKey accountKey = GlobalKey<FormState>();

  /// 登录类型
  LoginInputType type = LoginInputType.accountPassword;

  TextInputType get keyboardType {
    switch (type) {
      case LoginInputType.accountPassword:
        return TextInputType.text;
      case LoginInputType.phoneVerifyCode:
        return TextInputType.phone;
      case LoginInputType.emailVerifyCode:
        return TextInputType.emailAddress;
    }
  }

  String? get inputHitText {
    switch (type) {
      case LoginInputType.accountPassword:
        return LocaleKeys.accountHintText.tr;
      case LoginInputType.phoneVerifyCode:
        return LocaleKeys.phoneHintText.tr;
      case LoginInputType.emailVerifyCode:
        return LocaleKeys.emailHintText.tr;
    }
  }

  // 对话布局
  Widget _buildAlertTipRow(BuildContext context) {
    final primary = context.theme.colorScheme.primary;
    final normalStyle =
        context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    final linkStyle = context.textTheme.titleMedium?.copyWith(color: primary);
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 40),
      child: <Widget>[
        Expanded(
          child: ProtocolTipText(
            startText: LocaleKeys.alertTipStartText.tr,
            normalStyle: normalStyle?.copyWith(height: 1.5),
            linkStyle: linkStyle,
          ),
        ),
      ].toRow(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Future<bool> _submit() async {
    if (agreeDeal == false) {
      agreeDeal = true;
      update(["login"]);
    }

    if (isFetching) {
      return false;
    }

    switch (type) {
      case LoginInputType.accountPassword:
        return _loginWithPassword();
      case LoginInputType.phoneVerifyCode:
      case LoginInputType.emailVerifyCode:
        return _loginWithVerifyCode();
      default:
        return false;
    }
  }

  // 验证码登录，包括手机号和邮箱
  Future<bool> _loginWithVerifyCode() async {
    final String type;
    if (_isEmailText) {
      type = 'email';
    } else if (_isPhoneText) {
      type = 'phone_number';
    } else {
      return false;
    }
    try {
      Loading.show();

      isFetching = true;
      update(["login"]);

      final account = accountController.text;
      final response = await UserApi.verifyCodeForLogin(
        type: type,
        account: account,
        cancelToken: _cancelToken,
      );
      isFetching = false;
      update(["login"]);
      Loading.dismiss();
      if (response.code == 0) {
        final message = type == 'email'
            ? LocaleKeys.emailVerifyCodeSended.tr
            : LocaleKeys.phoneNumberVerifyCodeSended.tr;
        Loading.success(message);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } on DioException catch (e) {
      isFetching = false;
      update(["login"]);
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return false;
      }
      Loading.error(e.toString());
      return false;
    } catch (e) {
      isFetching = false;
      update(["login"]);
      log('Error: $e');
      return false;
    }
  }

  // 登录按钮
  void _mainButtonAction(BuildContext context) {
    _submit().then((value) {
      if (!value) {
        return;
      }

      if (type == LoginInputType.accountPassword) {
        Get.back();
      } else {
        Get.toNamed(RouteNames.systemPin, arguments: {
          'submit_type': ActionType.kLoginVerifyCode,
          'hold_value': accountController.text,
          'prev_route': RouteNames.systemMain,
        });
      }
    });
  }

  // 协议意向对话
  void _showMyDialog(BuildContext context) async {
    await Get.dialog(
      AlertDialog(
        title: Text(LocaleKeys.userProtocol.tr),
        content: _buildAlertTipRow(context),
        actions: [
          <Widget>[
            // 不同意
            TextButton(
              child: TextWidget.body(LocaleKeys.disagreeProtocol.tr,
                  textStyle: Get.textTheme.titleMedium, color: Colors.grey),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // 同意
            TextButton(
              child: TextWidget.body(
                LocaleKeys.agreeProtocol.tr,
                textStyle: Get.textTheme.titleMedium,
                color: context.theme.colorScheme.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _mainButtonAction(context);
              },
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceEvenly),
        ],
      ),
    );
  }

  // 初始化数据
  initData() {
    accountController.addListener(() {
      accountSubject.add(accountController.text);
      update(["login"]);
    });
    passwordController.addListener(() {
      passwordSubject.add(passwordController.text);
      update(["login"]);
    });

    // 用户名监听
    _accountSubscription = accountSubject.stream
        .sampleTime(const Duration(milliseconds: 1000))
        .listen((text) {
      if (_emailRegex.hasMatch(text)) {
        _isEmailText = true;
      } else {
        _isEmailText = false;
      }
      if (_phoneRegex.hasMatch(text)) {
        _isPhoneText = true;
      } else {
        _isPhoneText = false;
      }
      update(["login"]);
    });

    // 密码监听
    _passwordSubscription = passwordSubject.stream
        .sampleTime(const Duration(milliseconds: 1000))
        .listen((text) {
      if (text.length >= 8) {
        _isPasswdValid = true;
      } else {
        _isPasswdValid = false;
      }
      update(["login"]);
    });
  }

  // 密码明文和密文切换
  void switchPasswordVisible() {
    obscurePassword = !obscurePassword;
    update(["login"]);
  }

  // 登录按钮是否可用,判断按钮的状态
  bool get mainButtonEnabled {
    if (isFetching) return false;
    switch (type) {
      case LoginInputType.accountPassword:
        return (_isEmailText || _isPhoneText) && _isPasswdValid;
      case LoginInputType.phoneVerifyCode:
        return _isPhoneText;
      case LoginInputType.emailVerifyCode:
        return _isEmailText;
    }
  }

  // 按钮文字显示
  String get mainButtonText {
    switch (type) {
      case LoginInputType.accountPassword:
        return LocaleKeys.login.tr;
      case LoginInputType.phoneVerifyCode:
        return LocaleKeys.getCapcha.tr;
      case LoginInputType.emailVerifyCode:
        return LocaleKeys.getCapcha.tr;
    }
  }

  // 失去焦点
  void resignFocus() {
    acountFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  // 登录按钮
  mainButtonPressed(BuildContext context) {
    resignFocus();
    if (agreeDeal) {
      _mainButtonAction(context);
    } else {
      _showMyDialog(context);
    }
  }

  // 登录类型切换
  void switchLoginType() {
    if (isFetching) {
      return;
    }

    const types = LoginInputType.values;
    final index = types.indexOf(type);
    final newIndex = (index + 1) % types.length;
    type = types[newIndex];
    acountFocusNode.unfocus();
    passwordFocusNode.unfocus();
    passwordController.clear();
    update(["login"]);
  }

  void clearAccountText() {
    accountController.clear();
  }

  // 勾选协议
  void agreeDealChanged(bool value) {
    agreeDeal = value;
    update(["login"]);
  }

  // 用户名和密码登录
  Future<bool> _loginWithPassword() async {
    try {
      final UserLoginType type;
      if (_isEmailText) {
        type = UserLoginType.emailPassword;
      } else if (_isPhoneText) {
        type = UserLoginType.phonePassword;
      } else {
        return false;
      }

      Loading.show();
      isFetching = true;
      update(["login"]);

      final response = await UserApi.login(
          account: accountController.text,
          code: passwordController.text,
          type: Strings.getLoginType(type));
      isFetching = false;
      update(["login"]);
      Loading.dismiss();
      if (response.code == 0 &&
          response.token != null &&
          response.brief != null) {
        await UserService.to.setToken(response.token!);
        UserService.to.setUserBrief(response.brief!);
        // 登录成功后跳转到课程列表页
        // Get.find<MainController>().onJumpToPage(1);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError);
        return false;
      }
    } on DioException catch (e) {
      isFetching = false;
      update(["login"]);
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        return false;
      }
      Loading.error(e.toString());
      return false;
    } catch (e) {
      isFetching = false;
      update(["login"]);
      log('Error: $e');
      return false;
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   initData();
  // }

  void jumpToForgetPassword() {
    Get.toNamed(RouteNames.securityForgetPassword, arguments: {
      "prev_route": RouteNames.systemLogin,
    });
  }

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    accountController.dispose();
    acountFocusNode.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    accountSubject.close();
    passwordSubject.close();
    _accountSubscription.cancel();
    _passwordSubscription.cancel();
    _cancelToken.cancel();
  }
}
