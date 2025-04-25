import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:ducafe_ui_core/ducafe_ui_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/global.dart';

void main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: false,
      minTextAdapt: false,
      builder: (context, child) => AdaptiveTheme(
        light: AppTheme.light,
        dark: AppTheme.dark,
        initial: ConfigService.to.themeMode,
        // debugShowFloatingThemeButton: true, // 显示主题按钮
        builder: (theme, darkTheme) => GetMaterialApp(
          title: 'Online Learning',
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            widget = EasyLoading.init()(context, widget); // EasyLoading 初始化

            // 不随系统字体缩放比例
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: widget,
            );
          },

          // 路由
          initialRoute: RouteNames.systemSplash,
          navigatorObservers: [RoutePages.observer],
          getPages: RoutePages.list,

          // 主题
          theme: theme,
          darkTheme: darkTheme,

          // 多语言
          translations: Translation(), // 词典
          localizationsDelegates: Translation.localizationsDelegates, // 代理
          supportedLocales: Translation.supportedLocales, // 支持的语言种类
          locale: ConfigService.to.locale, // 当前语言种类
          fallbackLocale: Translation.fallbackLocale, // 默认语言种类
        ),
      ),
    );
  }
}
