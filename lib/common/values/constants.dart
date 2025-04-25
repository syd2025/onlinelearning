/// 常量
class Constants {
  // 服务 api
  static const wpApiBaseUrl = 'https://192.168.8.16:10005';
  // video服务 api
  static const wpVideoApiBaseUrl = 'http://192.168.8.16:10006';
  // 本地存储key
  static const storageLanguageCode = 'language_code'; // 语言
  // 本地存储key
  static const storageAlreadyOpen = 'already_open'; // 首次打开
  // 本地存储key
  static const storageUserToken = 'user_token'; // 用户token
}

// 页面登录交互类型
enum LoginInputType {
  accountPassword,
  phoneVerifyCode,
  emailVerifyCode,
}

// 登录类型
enum UserLoginType {
  emailPassword,
  emailVerifyCode,
  phonePassword,
  phoneVerifyCode,
}

// 凭证类型
class CredentialType {
  static const email = 'email';
  static const phone = 'phone';
  static const thirdAccount = 'third_account';
}

// 操作类型
class ActionType {
  static const kResetEmail = 'reset_email';
  static const kResetPhoneNumber = 'reset_phone_number';
  static const kResetPassword = 'reset_password';
  static const kLoginVerifyCode = 'login_verify_code';
  static const kupdatePassword = 'old_password';
}
