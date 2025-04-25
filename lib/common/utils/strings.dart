import 'package:onlinelearning/common/index.dart';

class Strings {
  // 格式化章节索引，返回形如 "第1章" 的字符串。
  static String chapterIndex(int index) => '第$index章';

  // 获取登录类型的数字表示，用于网络请求中传递登录类型参数。
  static int getLoginType(UserLoginType type) {
    const values = UserLoginType.values;
    return values.indexOf(type);
  }
}
