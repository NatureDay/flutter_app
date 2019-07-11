import 'package:flutter/material.dart';

import 'package:flutter_app/app/util/shared_preferences.dart';

class AppUtil {
  /// 判断应用是否已登录
  static bool isAppLogin() {
    return false;
  }
}

class CommonUtil {

  /// 页面跳转
  static Future<T> push<T>(BuildContext context, Route<T> route) {
    return Navigator.push(context, route);
  }

  /// 页面跳转
  static Future<T> pushNamed<T>(BuildContext context, String routeName,
      {Object arguments}) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// 页面返回
  static bool pop<T>(BuildContext context, [T result]) {
    return Navigator.pop(context, {result: result});
  }
}
