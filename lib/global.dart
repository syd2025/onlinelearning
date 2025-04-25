import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:media_kit/media_kit.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    // 插件初始化
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();

    // 工具类
    await Storage().init();

    // 初始化服务
    Get.put<ConfigService>(ConfigService());
    Get.put<UserService>(UserService());
    Get.put<WPHttpService>(WPHttpService());
    Get.put<DataBaseService>(DataBaseService());

    // 初始化配置
    await ConfigService.to.init();
  }
}
