import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  // 主视图
  Widget _buildView() {
    return const ImageWidget.img(
      AssetsImages.splashJpg,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      id: "splash",
      builder: (_) {
        return _buildView();
      },
    );
  }
}
