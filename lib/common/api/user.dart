import 'package:dio/dio.dart';
import 'package:onlinelearning/common/index.dart';

class UserApi {
  /// 登录
  static Future<UserBriefResponse> login(
      {required String account,
      required String code,
      required int type,
      CancelToken? cancelToken}) async {
    final res = await WPHttpService.to.post(
      "/v1/user/login",
      data: {
        'account': account,
        'code': code,
        'type': type,
      },
      cancelToken: cancelToken,
    );
    return UserBriefResponse.fromJson(res.data);
  }

  /// 验证码登录
  static Future<SimpleResponse> verifyCodeForLogin({
    required String account,
    required String type,
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.post(
      "/v1/user/login/verify_code",
      data: {
        'account': account,
        'type': type,
      },
      cancelToken: cancelToken,
    );
    return SimpleResponse.fromJson(res.data);
  }

  /// 获取用户信息 brief
  static Future<UserBriefResponse> getUserBrief() async {
    var res = await WPHttpService.to.get(
      '/v1/user/brief',
    );
    return UserBriefResponse.fromJson(res.data);
  }

  /// 获取用户的profile
  static Future<UserProfileResponse> getUserProfile() async {
    var res = await WPHttpService.to.get(
      '/v1/user/profile',
    );
    return UserProfileResponse.fromJson(res.data);
  }

  /// 退出登录
  static Future<SimpleResponse> logout() async {
    var res = await WPHttpService.to.post(
      '/v1/user/logout',
    );
    return SimpleResponse.fromJson(res.data);
  }

  /*
   * 获取用户自定义图像
   */
  static Future<UserProfileFieldResponse> updateUserAvatar(
      List<int> imageBytes) async {
    var formData = FormData.fromMap({
      'avatar': MultipartFile.fromBytes(
        imageBytes,
        filename: 'avatar.jpg',
      ),
    });

    var res = await WPHttpService.to.patch('/v1/user/avatar', data: formData);
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 更新用户生日信息
   * birthday: 生日
   * */
  static Future<UserProfileFieldResponse> updateUserNickName(
      String nickname) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/nickname",
      data: {
        'nickname': nickname,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 更新用户生日信息
   * birthday: 生日
   *
   * */
  static Future<ProfessionResponse> getAllProfessions({
    CancelToken? cancelToken,
  }) async {
    final res = await WPHttpService.to.get(
      "/v1/user/professions",
      cancelToken: cancelToken,
    );
    return ProfessionResponse.fromJson(res.data);
  }

  /*
   * 更新用户生日信息
   * birthday: 生日
   * 
   */
  static Future<UserProfileFieldResponse> updateUserProfession(
      int professionId) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/profession",
      data: {
        'profession_id': professionId,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 更新用户生日信息
   * birthday: 生日
   * */
  static Future<UserProfileFieldResponse> updateUserGender(
      String gender) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/gender",
      data: {
        'gender': gender,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 获取中国地区信息
   * code: 地区code
   * 
   */
  static Future<ChinaRegionResponse> getChinaRegions({String? code}) async {
    final res = await WPHttpService.to.get(
      "/v1/user/chinaregions",
      params: {"code": code},
    );
    return ChinaRegionResponse.fromJson(res.data);
  }

  /*
   * 更新用户地区信息
   * code: 地区code
   * 
   */
  static Future<UserProfileFieldResponse> updateUserRegion({
    String? code,
  }) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/region",
      data: {
        'code': code,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 更新个人介绍 
   * introduction: 个人介绍
   */
  static Future<UserProfileFieldResponse> updateUserIntroduction(
      String introduction) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/introduction",
      data: {
        'introduction': introduction,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 发送验证码到用户邮箱/手机号
   * 用于修改邮箱/手机号
   * type: 邮箱/手机号
   * account: 邮箱/手机号
   * */
  static Future<VerifyCodeStatusResponse> changeUserEmail(String email) async {
    final res = await WPHttpService.to.post(
      "/v1/user/email/change",
      data: {
        'email': email,
      },
    );
    return VerifyCodeStatusResponse.fromJson(res.data);
  }

  /*
   * 更新用户邮箱
   * email: 邮箱
   * verifyCode: 验证码
   * */
  static Future<UserProfileFieldResponse> updateUserEmail(
      String email, String verifyCode) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/email",
      data: {
        'email': email,
        'verify_code': verifyCode,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /*
   * 更新用户手机号
   * phoneNumber: 手机号
   * verifyCode: 验证码
   *  
   */
  static Future<VerifyCodeStatusResponse> changeUserPhoneNumber(
      String phoneNumber) async {
    final res = await WPHttpService.to.post(
      "/v1/user/phone_number/change",
      data: {
        'phone_number': phoneNumber,
      },
    );

    return VerifyCodeStatusResponse.fromJson(res.data);
  }

  /*
  * 更新用户手机号
  * phoneNumber: 手机号
  * verifyCode: 验证码
  * 更新用户手机号
  * phoneNumber: 手机号
  * verifyCode: 验证码
  * */
  static Future<UserProfileFieldResponse> updateUserPhoneNumber(
      String phoneNumber, String verifyCode) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/phone_number",
      data: {
        'phone_number': phoneNumber,
        'verify_code': verifyCode,
      },
    );
    return UserProfileFieldResponse.fromJson(res.data);
  }

  /* 
  * 修改用户密码
  * 发送验证码到用户邮箱/手机号
  * 用于修改密码
  * type: 邮箱/手机号
  * account: 邮箱/手机号
  * */
  static Future<VerifyCodeStatusResponse> changeUserPassword(
      String type, String account) async {
    final res = await WPHttpService.to.post(
      "/v1/user/password/change",
      data: {
        'type': type,
        'account': account,
      },
    );
    return VerifyCodeStatusResponse.fromJson(res.data);
  }

  /*
  * 更新用户密码
  * type: 邮箱/手机号
  * account: 邮箱/手机号
  * code: 验证码
  * password: 新密码
  * *
  * */
  static Future<SimpleResponse> updateUserPassword(
      {required String type,
      String? account,
      required String code,
      required String password}) async {
    final res = await WPHttpService.to.patch(
      "/v1/user/password",
      data: {
        'type': type,
        'account': account,
        'password': password,
        'code': code,
      },
    );
    return SimpleResponse.fromJson(res.data);
  }
}
