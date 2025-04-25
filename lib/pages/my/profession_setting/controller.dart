import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class ProfessionSettingController extends GetxController {
  ProfessionSettingController();

  List<ProfessionModel>? professions;
  bool loading = false;
  bool error = false;

  bool get isProfessionsEmpty => professions?.isEmpty ?? true;

  // 当前选中项
  String? currentProfessionName;

  late final _cancelToken = CancelToken();

  _initData() {
    update(["profession_setting"]);
  }

  void onTap() {}

  @override
  void onInit() {
    super.onInit();
    currentProfessionName = UserService.to.profile.profession;

    Future.delayed(Duration.zero, () {
      loadAllProfessions();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  void okAction() {
    updateProfession().then((success) {
      if (success) {
        Get.back(result: currentProfessionName);
      }
    });
  }

  void selectProfession(int index) {
    if (professions == null) {
      return;
    }
    if (index < 0 || index >= professions!.length) {
      return;
    }
    final profession = professions![index];
    currentProfessionName = profession.title;
    update(["profession_setting"]);
  }

  Future<bool> updateProfession() async {
    if (currentProfessionName == UserService.to.profile.profession) {
      return true;
    }

    final targetProfession = professions
        ?.firstWhere((profession) => profession.title == currentProfessionName);
    final targetId = targetProfession?.id;
    if (targetId == null) {
      return false;
    }

    try {
      Loading.show();
      final response = await UserApi.updateUserProfession(targetId);
      Loading.dismiss();
      if (response.code == 0 && response.result?.field == 'profession') {
        Loading.success(LocaleKeys.updateSuccess);
        UserService.to.updateProfession(response.result?.value);
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

  // 载入职业列表
  void loadAllProfessions() async {
    try {
      Loading.show();
      loading = true;
      error = false;

      final response =
          await UserApi.getAllProfessions(cancelToken: _cancelToken);
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.professions != null) {
        professions = response.professions;
        update(["profession_setting"]);
      } else if (response.code != 0) {
        error = true;
        Loading.error(response.message ?? 'Unknown error');
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
}
