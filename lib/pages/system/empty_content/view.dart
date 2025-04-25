import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

import 'index.dart';

class EmptyContentPage extends GetView<EmptyContentController> {
  const EmptyContentPage({super.key});

  // 主视图
  Widget _buildView(BuildContext context) {
    Widget ws = Container();
    final id = Get.arguments['id'] ?? -500;

    // 无token
    if (id == -1) {
      ws = Center(
          child: Text("Unauthorized",
              style: Theme.of(context).textTheme.headlineMedium));
    } else if (id == -500) {
      ws = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("loading failed",
              style: Theme.of(context).textTheme.headlineMedium),
          ImageWidget.img(AssetsImages.loadingFailed),
        ],
      );
    } else if (id == -1000) {
      ws = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("no content", style: Theme.of(context).textTheme.headlineMedium),
          ImageWidget.img(AssetsImages.noContent),
        ],
      );
    }
    return ws;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmptyContentController>(
      init: EmptyContentController(),
      id: "empty_content",
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  if (Get.arguments["id"] == -1) {
                    Get.offAndToNamed(RouteNames.systemLogin);
                  } else if (Get.arguments["id"] == -500) {
                    Get.offAndToNamed(RouteNames.myMyIndex);
                  }
                },
                child: Icon(Icons.arrow_back_ios),
              ),
              title: Text(LocaleKeys.profileTitle.tr)),
          body: SafeArea(
            child: _buildView(context),
          ),
        );
      },
    );
  }
}
