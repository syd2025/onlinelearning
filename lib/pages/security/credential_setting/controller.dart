import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class CredentialSettingController extends GetxController {
  CredentialSettingController();

  // 从路由参数中获取 credential_type
  String get credentialType => Get.arguments["credential_type"];
  late final textController = TextEditingController();
  late final focusNode = FocusNode();

  late final _emailRegex =
      RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  late final _phoneRegex = RegExp(r'^1[3-9]\d{9}$');

  // 验证是否是有效的邮箱或手机号
  bool validCredential = false;

  String get title {
    switch (credentialType) {
      case CredentialType.phone:
        return LocaleKeys.phone.tr;
      case CredentialType.email:
        return LocaleKeys.email.tr;
      default:
        return "";
    }
  }

  String get inputPreText {
    switch (credentialType) {
      case CredentialType.email:
        return LocaleKeys.email.tr;
      case CredentialType.phone:
        return LocaleKeys.phone.tr;
      default:
        return '';
    }
  }

  TextInputType get inputType {
    switch (credentialType) {
      case CredentialType.phone:
        return TextInputType.phone;
      case CredentialType.email:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  String get inputHintText {
    switch (credentialType) {
      case CredentialType.phone:
        return LocaleKeys.phoneHintText.tr;
      case CredentialType.email:
        return LocaleKeys.emailHintText.tr;
      default:
        return "";
    }
  }

  bool get _isCredentialEmpty {
    switch (credentialType) {
      case CredentialType.phone:
        return UserService.to.profile.phoneNumber?.isEmpty ?? true;
      case CredentialType.email:
        return UserService.to.profile.email?.isEmpty ?? true;
      default:
        return true;
    }
  }

  String get buttonTitle {
    switch (credentialType) {
      case CredentialType.email:
        return _isCredentialEmpty
            ? LocaleKeys.bindEmail.tr
            : LocaleKeys.changeEmail.tr;
      case CredentialType.phone:
        return _isCredentialEmpty
            ? LocaleKeys.bindPhone.tr
            : LocaleKeys.changePhone.tr;
      default:
        return '';
    }
  }

  // 初始化数据
  _initData() {
    if (credentialType == CredentialType.phone) {
      textController.text = UserService.to.profile.phoneNumber ?? "";
    } else if (credentialType == CredentialType.email) {
      textController.text = UserService.to.profile.email ?? "";
    }

    validCredential = false;

    textController.addListener(() {
      final credential = textController.text;
      final previousValid = validCredential;
      validCredential = (credentialType == CredentialType.phone
              ? _phoneRegex.hasMatch(credential) &&
                  (credential != UserService.to.profile.phoneNumber)
              : _emailRegex.hasMatch(credential)) &&
          (credential != UserService.to.profile.email);
      if (validCredential != previousValid) {
        update(["credential_setting"]);
      }
    });
  }

  Future<bool> changeUserEmail() async {
    final email = textController.text;
    if (_emailRegex.hasMatch(email) == false) {
      return false;
    }

    focusNode.unfocus();

    try {
      Loading.show();

      final response = await UserApi.changeUserEmail(email);
      Loading.dismiss();
      if (response.code == 0 && response.status != null) {
        final status = response.status!;
        if (status.status == 1) {
          Loading.error(LocaleKeys.emailAlreadyUsed.tr);
          return false;
        } else if (status.status == 0) {
          Loading.success(LocaleKeys.emailVerifyCodeSended.tr);
          return true;
        } else {
          Loading.error(LocaleKeys.unknownError.tr);
          return false;
        }
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log("error in changeUserEmail: $e");
      return false;
    }
  }

  Future<bool> changeUserPhoneNumber() async {
    final phoneNumber = textController.text;
    if (_phoneRegex.hasMatch(phoneNumber) == false) {
      return false;
    }

    focusNode.unfocus();

    try {
      Loading.show();
      final response = await UserApi.changeUserPhoneNumber(phoneNumber);
      if (response.code == 0 && response.status != null) {
        final status = response.status!;
        if (status.status == 1) {
          Loading.error(LocaleKeys.phoneNumberAlreadyUsed.tr);
          return false;
        } else if (status.status == 0) {
          Loading.success(LocaleKeys.phoneVerifyCodeSended.tr);
          return true;
        } else {
          Loading.error(LocaleKeys.unknownError.tr);
          return false;
        }
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
        return false;
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error(e.toString());
      log("error in changeUserPhoneNumber: $e");
      return false;
    }
  }

  void mainButtonPressed() {
    if (credentialType == CredentialType.email) {
      changeUserEmail().then((value) {
        if (value) {
          Get.toNamed(RouteNames.systemPin, arguments: {
            'submit_type': ActionType.kResetEmail,
            'hold_value': textController.text,
            'prev_route': RouteNames.securitySecurityIndex,
          });
        }
      });
    } else if (credentialType == CredentialType.phone) {
      changeUserPhoneNumber().then((value) {
        if (value) {
          Get.toNamed(RouteNames.systemPin, arguments: {
            'submit_type': ActionType.kResetPhoneNumber,
            'hold_value': textController.text,
            'prev_route': RouteNames.securitySecurityIndex,
          });
        }
      });
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
