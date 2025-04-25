import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeIndexPage extends GetView<HomeIndexController> {
  const HomeIndexPage({super.key});

  // 主视图
  Widget _buildView() {
    return const Center(
      child: Text("HomeIndexPage"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeIndexController>(
      init: HomeIndexController(),
      id: "home_index",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: _buildView(),
          ),
        );
      },
    );
  }
}
