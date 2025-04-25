import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';

class WelcomeController extends GetxController {
  WelcomeController();

  /// 轮播图
  List<WelcomeModel>? items;

  /// 当前位置
  int currentIndex = 0;

  /// 是否显示start
  bool isShowStart = false;

  /// slider 控制器
  CarouselSliderController carouselController = CarouselSliderController();

  /// 当前位置发生改变
  void onPageChanged(int index) {
    currentIndex = index;
    isShowStart = currentIndex == 2;
    update(['slider', 'bar']);
  }

  /// 跳转首页
  void onToMain() {
    Get.offAllNamed(RouteNames.systemMain);
  }

  /// 跳转下一页
  void onNext() {
    carouselController.nextPage();
  }

  _initData() {
    items = <WelcomeModel>[
      WelcomeModel(
        title: LocaleKeys.welcomeOneTitle.tr,
        desc: LocaleKeys.welcomeOneDesc.tr,
        image: AssetsImages.welcome_1Png,
      ),
      WelcomeModel(
        title: LocaleKeys.welcomeTwoTitle.tr,
        desc: LocaleKeys.welcomeTwoDesc.tr,
        image: AssetsImages.welcome_2Png,
      ),
      WelcomeModel(
        title: LocaleKeys.welcomeThreeTitle.tr,
        desc: LocaleKeys.welcomeThreeDesc.tr,
        image: AssetsImages.welcome_3Png,
      ),
    ];

    update(["slider", 'bar']);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();

    ConfigService.to.setAlreadyOpen();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
