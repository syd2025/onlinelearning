import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class RegionSettingController extends GetxController {
  RegionSettingController();

  List<ChinaRegionModel>? regions;
  bool loading = false;
  bool error = false;
  String code = "0";
  int level = 1;
  String title = LocaleKeys.region.tr;

  late final _cancelToken = CancelToken();

  String? _selectedCode;

  String? get selectedCode {
    if (_selectedCode != null) {
      return _selectedCode;
    }

    final index = level - 1;
    final areaCodeList = UserService.to.profile.regionCodeList;
    if (areaCodeList != null && areaCodeList.length > index && index >= 0) {
      return areaCodeList[index];
    } else {
      return null;
    }
  }

  void regionRowTapped(ChinaRegionModel region) {
    selectRegion(region);
    if (level < 5 && region.category != 10000) {
      Get.toNamed(RouteNames.myRegionSetting, arguments: {
        "code": region.code,
        "level": level + 1,
        "title": "Region",
      });
    }
  }

  void selectRegion(ChinaRegionModel region) {
    _selectedCode = region.code;
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    Loading.dismiss();
    super.dispose();
  }

  // 载入数据
  void loadRegions() async {
    try {
      loading = true;
      error = false;
      update(["region_setting"]); // 立即更新状态
      Loading.show();

      final response = await UserApi.getChinaRegions(code: code);
      loading = false;
      Loading.dismiss();
      if (response.code == 0 && response.regions != null) {
        regions = response.regions;
        update(["region_setting"]);
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
      update(["region_setting"]); // 添加状态更新
      Loading.error(e.toString());
    } catch (e) {
      log('Unknown error: $e');
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getSelectedCode();
  // }

  @override
  void onReady() {
    super.onReady();
    code = Get.arguments["code"]?.toString() ?? "0";
    level = int.tryParse(Get.arguments["level"]) ?? 1;
    title = Get.arguments["title"] ?? LocaleKeys.region.tr;
    loadRegions();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
