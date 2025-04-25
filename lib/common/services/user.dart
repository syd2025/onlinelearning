import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class UserService extends GetxService {
  static UserService get to => Get.find();

  /// 是否登录
  final _isLogin = false.obs;

  /// 用户令牌
  String token = '';

  /// 用户的资料 brief
  final _brief = UserBriefModel().obs;

  /// 用户信息profile
  final _profile = UserProfileModel().obs;

  /// 是否登录
  bool get isLogin => _isLogin.value;

  /// 用户 brief
  UserBriefModel get brief => _brief.value;

  /// 用户 profile
  UserProfileModel get profile => _profile.value;

  /// 是否有令牌 token
  bool get hasToken => token.isNotEmpty;

  /// 头像改变的索引
  final avatarChangeIndexNotifier = ValueNotifier<int>(0);

  /// 头像改变的索引
  int index = 0;

  /// 用户id
  int? get accountId => brief.id;

  /// 已购买的课程
  List<int> get purchasedCourses => brief.purchasedCourses ?? [];

  /// 正在购买的课程
  List<int> get purchasingCourses => brief.purchasingCourses ?? [];

  /// 更新头像改变的索引
  updateIndex() {
    index = avatarChangeIndexNotifier.value;
  }

  /// 设置令牌
  Future<void> setToken(String value) async {
    await Storage().setString(Constants.storageUserToken, value);
    token = value;
    log(token);
  }

  /// 获取用户 brief
  Future<void> getUserBrief() async {
    if (token.isEmpty) return;
    UserBriefResponse result = await UserApi.getUserBrief();
    _brief(result.brief);

    // Storage().setString(Constants.storageUserBrief, jsonEncode(result));
  }

  /// 获取用户的profile
  Future<UserProfileModel> getUserProfile() async {
    // 如果没有token，直接返回
    if (token.isEmpty) return UserProfileModel(id: -1);
    try {
      // 获取用户的profile成功
      UserProfileResponse result = await UserApi.getUserProfile();
      if (result.code == 0 && result.profile != null) {
        return _profile(result.profile);
      } else {
        // 获取用户的profile失败
        return UserProfileModel(id: -500);
      }
    } catch (e) {
      log("error in getUserProfile: $e");
      return UserProfileModel(id: -1000);
    }
  }

  /// 设置用户 brief
  void setUserBrief(UserBriefModel brief) {
    if (token.isEmpty) return;
    _isLogin.value = true;
    _brief(brief);
    // Storage().setString(Constants.storageUserBrief, jsonEncode(brief));
  }

  /// 添加到购物车
  void addCourseToShoppingCarts(int courseId) {
    if (purchasedCourses.contains(courseId)) {
      return;
    }

    final purchasings = _brief.value.purchasingCourses ?? [];
    final newBrief = brief.copyWith(
      purchasingCourses: [...purchasings, courseId],
    );
    _brief.value = newBrief;
  }

  /// 课程购买成功后，更新用户的信息
  void coursePurchased(List<int> courseIds) {
    final purchasings = _brief.value.purchasingCourses ?? [];
    final newPurchasings =
        purchasings.where((element) => !courseIds.contains(element)).toList();
    final newBrief = brief.copyWith(
      purchasingCourses: newPurchasings,
      purchasedCourses: [...purchasedCourses, ...courseIds],
    );
    _brief.value = newBrief;

    final newProfile = _profile.value.copyWith(
      purchasingCourses: newPurchasings,
      purchasedCourses: [...purchasedCourses, ...courseIds],
    );
    _profile.value = newProfile;
  }

  /// 设置用户 profile
  void setUserProfile(UserProfileModel profile) {
    if (token.isEmpty) return;
    _profile(profile);
    // Storage().setString(Constants.storageUserProfile, jsonEncode(profile));
  }

  /// 更新用户头像
  Future<void> updateAvatar(String? avatar) async {
    // 清空CachedNetworkImage的缓存
    Images.clearSingleImageCache();
    final newBrief = brief.copyWith(avatar: avatar);
    setUserBrief(newBrief);
    final newProfile = profile.copyWith(avatar: avatar);
    setUserProfile(newProfile);
  }

  /// 更新昵称
  void updateNickname(String? nickname) async {
    final newBrief = brief.copyWith(name: nickname);
    setUserBrief(newBrief);
    final newProfile = profile.copyWith(name: nickname);
    setUserProfile(newProfile);

    avatarChangeIndexNotifier.value++;
  }

  /// 更新职业
  void updateProfession(String? profession) {
    final newProfile = profile.copyWith(profession: profession);
    setUserProfile(newProfile);
  }

  /// 更新性别
  void updateGender(String? gender) {
    final newBrief = brief.copyWith(gender: gender);
    setUserBrief(newBrief);

    final newProfile = profile.copyWith(gender: gender);
    setUserProfile(newProfile);
  }

  /// 更新地址
  void updateRegion(String? region, List<String>? regionCodeList) {
    final newProfile =
        profile.copyWith(region: region, regionCodeList: regionCodeList);
    setUserProfile(newProfile);
  }

  /// 更新个人介绍
  void updateIntroduction(String? introduction) {
    final newProfile = profile.copyWith(introduction: introduction);
    setUserProfile(newProfile);
  }

  /// 图片上传服务器
  Future<UserProfileFieldResponse> uploadImageToServer(Uint8List image) async {
    final response = await UserApi.updateUserAvatar(image);
    return response;
  }

  /// 载入UserProfile
  Future<UserProfileModel> loadUserProfile() async {
    try {
      final userProfile = await getUserProfile();
      setUserProfile(userProfile);
      return userProfile;
    } catch (e) {
      log(e.toString());
      return UserProfileModel();
    }
  }

  /// 更新邮箱
  void updateEmail(String? email) {
    final newProfile = profile.copyWith(email: email);
    setUserProfile(newProfile);
  }

  /// 更新手机号
  void updatePhoneNumber(String? phoneNumber) {
    final newProfile = profile.copyWith(phoneNumber: phoneNumber);
    setUserProfile(newProfile);
  }

  /// 初始化
  @override
  void onInit() {
    super.onInit();
    // 读 token
    token = Storage().getString(Constants.storageUserToken);

    // 读 profile
    // var briefOffline = Storage().getString(Constants.storageUserBrief);
    // if (briefOffline.isNotEmpty) {
    //   _brief(UserBriefModel.fromJson(jsonDecode(briefOffline)));
    // }
  }

  /// 用户登出
  Future<void> logout() async {
    // if (_isLogin.value) await UserAPIs.logout();
    await Storage().remove(Constants.storageUserToken);
    _brief(UserBriefModel());
    _isLogin.value = false;
    await setToken('');
  }

  /// 检查是否登录
  Future<bool> checkIsLogin() async {
    return _isLogin.value;
  }
}
