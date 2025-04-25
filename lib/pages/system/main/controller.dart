import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class MainController extends GetxController {
  MainController();

  // 分页管理
  final PageController pageController = PageController();
  // 当前的tab index
  int currentIndex = 0;
  // 退出请求时间
  DateTime? currentBackPressTime;

  // 返回键退出
  bool closeOnConfirm(BuildContext context) {
    DateTime now = DateTime.now();
    // 物理键，两次间隔大于4秒, 退出请求无效
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 4)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Center(child: Text('Press again to exit the application.')),
          duration: Duration(seconds: 4),
        ),
      );
      return false;
    }

    // 退出请求有效
    currentBackPressTime = null;
    return true;
  }

  // 导航栏切换
  void onIndexChanged(int index) {
    currentIndex = index;
    update(["navigation"]);
  }

  // 切换页面
  void onJumpToPage(int index) {
    // 除了首页，其它页面都需要登录
    if ((index == 2 || index == 3) && !UserService.to.isLogin) {
      Get.toNamed(RouteNames.systemLogin);
    } else {
      pageController.jumpToPage(index);
    }
  }

  _initData() async {
    update(["main"]);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  @override
  void onClose() {
    super.onClose();
    // 释放页面控制器
    pageController.dispose();
  }
}
