import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class PinController extends GetxController {
  PinController();

  final String submitType = Get.arguments["submit_type"];
  final String holdValue = Get.arguments["hold_value"];
  final String? prevRoute = Get.arguments["prev_route"];
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  final phoneRegex = RegExp(r'^1[3-9]\d{9}$');

  late final textController = TextEditingController();
  late final focusNode = FocusNode();

  bool? password1Ready;
  bool? password2Ready;
  late final passwordController1 = TextEditingController();
  late final passwordController2 = TextEditingController();
  late final focusNode1 = FocusNode();
  late final focusNode2 = FocusNode();
  bool _password1Used = false;
  bool _password2Used = false;

  bool get canSubmit => textController.text.length >= 6;

  String get title {
    switch (submitType) {
      case ActionType.kResetEmail:
        return LocaleKeys.changeEmail.tr;
      case ActionType.kResetPhoneNumber:
        return LocaleKeys.changePhone.tr;
      case ActionType.kResetPassword:
        return LocaleKeys.resetPassword.tr;
      case ActionType.kLoginVerifyCode:
        return LocaleKeys.verifyCodeLogin.tr;
      default:
        return '';
    }
  }

  Future<bool> _loginWithVeiryCode() async {
    final account = holdValue;
    final UserLoginType type;
    if (emailRegex.hasMatch(account)) {
      type = UserLoginType.emailVerifyCode;
    } else if (phoneRegex.hasMatch(account)) {
      type = UserLoginType.phoneVerifyCode;
    } else {
      return false;
    }

    try {
      Loading.show();
      final code = textController.text;
      final response = await UserApi.login(
        type: Strings.getLoginType(type),
        account: account,
        code: code,
      );
      Loading.dismiss();
      if (response.code == 0 &&
          response.token != null &&
          response.brief != null) {
        await UserService.to.setToken(response.token!);
        UserService.to.setUserBrief(response.brief!);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return false;
    }
  }

  Future<bool> _resetEmail() async {
    final code = textController.text;
    if (holdValue == UserService.to.profile.email) {
      return false;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserEmail(holdValue, code);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'email') {
        Loading.success(LocaleKeys.updateSuccess.tr);
        UserService.to.updateEmail(response.result?.value);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return false;
    }
  }

  Future<bool> _resetPhoneNumber() async {
    final code = textController.text;
    if (holdValue == UserService.to.profile.phoneNumber) {
      return false;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserPhoneNumber(holdValue, code);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'phone_number') {
        Loading.success(LocaleKeys.updateSuccess.tr);
        UserService.to.updatePhoneNumber(response.result?.value);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return false;
    }
  }

  Future<bool> _resetPassword() async {
    try {
      Loading.show();
      final password = passwordController1.text;
      final code = textController.text;
      late final emailRegex =
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
      late final phoneRegex = RegExp(r'^1[3-9]\d{9}$');
      final type = emailRegex.hasMatch(holdValue)
          ? 'email_code'
          : phoneRegex.hasMatch(holdValue)
              ? 'phone_code'
              : '';
      final response = await UserApi.updateUserPassword(
        type: type,
        account: holdValue,
        password: password,
        code: code,
      );
      Loading.dismiss();
      if (response.code == 0) {
        Loading.success(LocaleKeys.updateSuccess.tr);
        return true;
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log('Error: $e');
      return false;
    }
  }

  Future<bool> submit() async {
    focusNode.unfocus();
    focusNode1.unfocus();
    focusNode2.unfocus();

    if (submitType == ActionType.kLoginVerifyCode) {
      return _loginWithVeiryCode();
    } else if (submitType == ActionType.kResetEmail) {
      return _resetEmail();
    } else if (submitType == ActionType.kResetPhoneNumber) {
      return _resetPhoneNumber();
    } else if (submitType == ActionType.kResetPassword) {
      return _resetPassword();
    } else {
      return false;
    }
  }

  void mainButtonPressed() {
    submit().then((value) {
      if (value) {
        if (prevRoute != null) {
          Get.until(
            (route) => route.settings.name == prevRoute,
          );
        } else {
          Get.back();
        }
      }
    });
  }

  _initData() {
    textController.addListener(() {
      update(["pin"]);
    });

    passwordController1.addListener(() {
      final text1 = passwordController1.text;
      if (text1.isNotEmpty) {
        _password1Used = true;
      } else {
        _password1Used = false;
      }

      if (_password1Used) {
        password1Ready = text1.length >= 8;
      }

      if (_password2Used) {
        final text2 = passwordController2.text;
        password2Ready = text2.length >= 8 && text1 == text2;
      }
      update(["pin"]);
    });

    passwordController2.addListener(() {
      final text = passwordController2.text;
      if (text.isNotEmpty) {
        _password2Used = true;
      }
      if (_password2Used) {
        password2Ready = text.length >= 8 && text == passwordController1.text;
      }
      update(["pin"]);
    });
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }
}
