import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:onlinelearning/pages/index.dart';

class RoutePages {
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];
  // 列表
  static List<GetPage> list = [
    GetPage(
      name: RouteNames.courseCourseIndex,
      page: () => const CourseIndexPage(),
    ),
    GetPage(
      name: RouteNames.courseCourseList,
      page: () => const CourseListPage(),
    ),
    GetPage(
      name: RouteNames.courseCourseSearch,
      page: () => const CourseSearchPage(),
    ),
    GetPage(
      name: RouteNames.courseCourseDetail,
      page: () => const CourseDetailPage(),
    ),
    GetPage(
      name: RouteNames.courseCourseReview,
      page: () => const CourseReviewPage(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.courseCourseReviewReply,
      page: () => const CourseReviewReplyPage(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.myMyIndex,
      page: () => const MyIndexPage(),
    ),
    GetPage(
      name: RouteNames.homeHomeIndex,
      page: () => const HomeIndexPage(),
    ),
    GetPage(
      name: RouteNames.myNickNameSetting,
      page: () => const NicknameSettingPage(),
    ),
    GetPage(
      name: RouteNames.myIntroductionSetting,
      page: () => const IntroductionSettiingPage(),
    ),
    GetPage(
      name: RouteNames.myProfessionSetting,
      page: () => const ProfessionSettingPage(),
    ),
    GetPage(
      name: RouteNames.myRegionSetting,
      page: () => const RegionSettingPage(),
    ),
    GetPage(
      name: RouteNames.securitySecurityIndex,
      page: () => const SecurityIndexPage(),
    ),
    GetPage(
      name: RouteNames.securityCredentialSetting,
      page: () => const CredentialSettingPage(),
    ),
    GetPage(
      name: RouteNames.securityThirdAuthAccount,
      page: () => const ThirdAuthAccountPage(),
    ),
    GetPage(
      name: RouteNames.securityAccountCancellation,
      page: () => const AccountCancellationPage(),
    ),
    GetPage(
      name: RouteNames.securityIdentitySetting,
      page: () => const IdentitySettingPage(),
    ),
    GetPage(
      name: RouteNames.securityForgetPassword,
      page: () => const ForgetPasswordPage(),
    ),
    GetPage(
      name: RouteNames.securityPasswordSetting,
      page: () => const PasswordSettingPage(),
    ),
    GetPage(
      name: RouteNames.studyStudyIndex,
      page: () => const StudyIndexPage(),
    ),
    GetPage(
      name: RouteNames.studyStudyCourse,
      page: () => const StudyCoursePage(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.systemLogin,
      page: () => const LoginPage(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.systemPin,
      page: () => const PinPage(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    GetPage(
      name: RouteNames.systemMain,
      page: () => const MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: RouteNames.systemRegister,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: RouteNames.systemSplash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: RouteNames.systemWelcome,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: RouteNames.systemEmptyContent,
      page: () => const EmptyContentPage(),
    ),
  ];
}
