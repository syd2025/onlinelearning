import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class SecurityIndexController extends GetxController {
  SecurityIndexController();

  /// 从服务器获取用户信息中的手机号码
  String get phoneNumber =>
      UserService.to.profile.phoneNumber ?? LocaleKeys.notBind.tr;

  /// 从服务器获取用户信息中的邮箱
  String get email => UserService.to.profile.email ?? LocaleKeys.notBind.tr;

  /// 第三方账号
  String get thirdAccount => "";

  /// 登录密码
  String get password => "";

  /// 身份验证
  String get identityVerification => "";

  /// 账户注销
  String get accountCancellation => "";

  _initData() {
    update(["security_index"]);
  }

  void jumpToCredentialPhone() {
    Get.toNamed(RouteNames.securityCredentialSetting, arguments: {
      "credential_type": CredentialType.phone,
    });
  }

  void jumpToCredentialEmail() {
    Get.toNamed(RouteNames.securityCredentialSetting, arguments: {
      "credential_type": CredentialType.email,
    });
  }

  void jumpToThirdAuthAccount() {
    Get.toNamed(RouteNames.securityThirdAuthAccount);
  }

  void jumpToPasswordSetting() {
    Get.toNamed(RouteNames.securityPasswordSetting);
  }

  void jumpToAccountCancellation() {
    Get.toNamed(RouteNames.securityAccountCancellation);
  }

  void jumpToIdentityVerification() {
    Get.toNamed(RouteNames.securityIdentitySetting);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData(); // 保留原有初始化逻辑
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
