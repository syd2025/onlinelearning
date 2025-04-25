import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';
import 'package:onlinelearning/pages/my/my_index/widget/profile_setting_page.dart';

class MyIndexController extends GetxController {
  MyIndexController();

  final learnedDays = 0.obs;
  late var userProfile = UserProfileModel();

  /// 中国地区数据
  late final _cancelToken = CancelToken();
  List<ChinaRegionModel>? regions;
  bool loading = false;
  bool error = false;
  final String code = '0';
  final int level = 1;
  final String title = "";

  _initData() {
    update(["my_index", "avatar", "btn_exit"]);
  }

  // 获取学习天数
  int? get getLearnedDays {
    final start = UserService.to.brief.createdAt;
    return DateTime.now().difference(start!).inDays;
  }

  // 获取学习时长
  int? get getLearnedMinutes {
    return 0;
  }

  // 获取昵称
  String? get nickName => UserService.to.brief.name;

  // 获取个人签名
  String? get introduction => UserService.to.profile.introduction;

  // 获取职业
  String? get gender => UserService.to.profile.gender;

  // 设置性别
  setGender(String? value) {
    updateGender(value!);
  }

  // 用户登出
  logout() async {
    try {
      Loading.show();
      // 清除本地存储
      UserService.to.avatarChangeIndexNotifier.value = 0;

      // 清除远程服务器记录
      final response = await UserApi.logout();
      if (response.code == 0) {
        // 清空本地存储
        await UserService.to.logout();
        update(["avatar", "btn_exit"]);
        Get.find<MainController>().onJumpToPage(0);
        Loading.success(LocaleKeys.exitSuccess.tr);
      } else {
        if (response.message != null) {
          log("logout failed with remote message: ${response.message}");
        }
        Loading.error(LocaleKeys.exitFailed.tr);
      }
    } on DioException catch (e) {
      log("Error when logout: ${e.toString()}");
    } finally {
      Loading.dismiss();
    }
  }

  /// 载入UserProfile
  void loadUserProfile() async {
    try {
      // Loading.show(LocaleKeys.gettingInfo.tr);
      userProfile = await UserService.to.getUserProfile();

      if (userProfile.id!.isNegative) {
        Loading.error(LocaleKeys.getInfoFailed.tr);
        Get.toNamed(RouteNames.systemEmptyContent, arguments: {
          "id": userProfile.id,
        });
      }

      Loading.dismiss();
    } catch (e) {
      log("获取用户信息失败: $e");
      Loading.error(LocaleKeys.getInfoFailed.tr);
    } finally {
      Loading.dismiss();
    }
  }

  // 更新头像
  Future<void> updateAvatar() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(source: ImageSource.gallery);
      if (photo != null) {
        Loading.show();
      }
      final file = File(photo!.path);
      final bytes = await file.readAsBytes();
      final image = img.decodeImage(bytes);
      if (image == null) {
        Loading.dismiss();
        Loading.error(LocaleKeys.invalidImage.tr);
        return;
      }
      final img.Image resized;
      if (image.width > image.height) {
        if (image.width > 600) {
          resized = img.copyResize(image, width: 600);
        } else {
          resized = image;
        }
      } else {
        if (image.height > 600) {
          resized = img.copyResize(image, height: 600);
        } else {
          resized = image;
        }
      }
      final jpg = img.encodeJpg(resized);
      Loading.dismiss();
      Loading.show(LocaleKeys.uploadingImage.tr); // uploading image
      final response = await UserService.to.uploadImageToServer(jpg);
      Loading.dismiss();
      if (response.code == 0 && response.result!.field == 'avatar') {
        Loading.success(LocaleKeys.uploadImageSuccess.tr);
        UserService.to.updateAvatar(response.result!.value);

        /// 更新信号通知
        UserService.to.avatarChangeIndexNotifier.value++;
        update(["profile_setting"]);
      } else {
        Loading.error(LocaleKeys.uploadImageFailed.tr);
      }
    } on PlatformException catch (e) {
      Loading.dismiss();
      if (e.code == 'photo_access_denied') {
        Loading.error(LocaleKeys.photoAccessDenied.tr);
      }
    } catch (e) {
      Loading.dismiss();
      log("error in updateAvatar: $e");
    }
  }

  // 更新性别
  void updateGender(String gender) async {
    if (gender == UserService.to.profile.gender) {
      return;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserGender(gender);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'gender') {
        Loading.success(LocaleKeys.updateSuccess.tr);
        UserService.to.updateGender(response.result?.value);
        update(["profile_setting"]);
      } else {
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
    } catch (e) {
      Loading.dismiss();
      Loading.error("error in updateGender $e.toString()");
      log('Error: $e');
    }
  }

  // 跳转到个人信息页面
  jumpToProfileSettingPage() async {
    bool islogined = await UserService.to.checkIsLogin();
    if (islogined) {
      await Get.to(() => ProfileSettingPage());
    } else {
      await Get.toNamed(RouteNames.systemLogin);
    }
  }

  // 跳转修改昵称页面
  jumpToNicknameSettingPage() async {
    bool islogined = await UserService.to.checkIsLogin();
    if (islogined) {
      final result =
          await Get.toNamed(RouteNames.myNickNameSetting, arguments: {
        "nickname": nickName,
      });
      UserService.to.updateNickname(result);
      update(["profile_setting", "my_index"]);
    } else {
      await Get.toNamed(RouteNames.systemLogin);
    }
  }

  // 跳转修改个人介绍页面
  jumpToIntroductionSettingPage() async {
    bool islogined = await UserService.to.checkIsLogin();
    if (islogined) {
      final result =
          await Get.toNamed(RouteNames.myIntroductionSetting, arguments: {
        "introduction": introduction,
      });
      UserService.to.updateIntroduction(result);
      update(["profile_setting", "my_index"]);
    } else {
      await Get.toNamed(RouteNames.systemLogin);
    }
  }

  // 跳转修改职业页面
  jumpToProfessionSettingPage() async {
    bool islogined = await UserService.to.checkIsLogin();
    if (islogined) {
      final result =
          await Get.toNamed(RouteNames.myProfessionSetting, arguments: {
        "profession": userProfile.profession,
      });
      UserService.to.updateProfession(result);
      update(["profile_setting", "my_index"]);
    } else {
      await Get.toNamed(RouteNames.systemLogin);
    }
  }

  // 跳转修改地区页面
  jumpToRegionSettingPage() async {
    loadRegions();
    bool islogined = await UserService.to.checkIsLogin();
    if (islogined) {
      // todo: 跳转修改地区页面
      await Get.toNamed(RouteNames.myRegionSetting, arguments: {
        "title": userProfile.region,
        "level": "1",
      });
    } else {
      await Get.toNamed(RouteNames.systemLogin);
    }
  }

  // 跳转个人账号安全页面
  jumpToAccountSecurityPage() {
    Get.toNamed(RouteNames.securitySecurityIndex);
  }

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();

    // 添加监听器
    UserService.to.avatarChangeIndexNotifier
        .addListener(UserService.to.updateIndex);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    // 移走监听器
    UserService.to.avatarChangeIndexNotifier
        .removeListener(UserService.to.updateIndex);
  }

  /// 加载地区数据
  String? _selectedCode;
  String? get selectedCode {
    if (_selectedCode != null) {
      return _selectedCode;
    }

    final index = level - 1;
    final areaCodeList = UserService.to.profile.regionCodeList;
    if (areaCodeList != null && areaCodeList.length > index) {
      return areaCodeList[index];
    } else {
      return null;
    }
  }

  // 载入数据
  void loadRegions() async {
    try {
      Loading.show();
      loading = true;
      error = false;

      final response = await UserApi.getChinaRegions();
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.regions != null) {
        regions = response.regions;
      } else if (response.code != 0) {
        error = true;
        Loading.error(response.message ?? LocaleKeys.unknownError.tr);
      }
    } on DioException catch (e) {
      Loading.dismiss();
      if (e.type == DioExceptionType.cancel) {
        log('Request canceled:${e.message}');
        return;
      }
      loading = false;
      error = true;
      Loading.error(e.toString());
    } catch (e) {
      log('Unknown error: $e');
    }
  }

  void selectRegion(ChinaRegionModel region) {
    _selectedCode = region.code;
  }

  Future<bool> updateRegion() async {
    final newCode = selectedCode ?? code;

    if (UserService.to.profile.regionCodeList?.last == newCode) {
      return true;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserRegion(code: newCode);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'region') {
        Loading.success(LocaleKeys.updateSuccess.tr);
        UserService.to
            .updateRegion(response.result?.value, response.result?.list);
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
}
