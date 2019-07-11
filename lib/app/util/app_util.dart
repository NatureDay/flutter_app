import 'package:flutter/material.dart';

import 'package:flutter_app/app/util/shared_preferences.dart';

class AppUtil {
  /// 判断应用是否已登录
  static bool isAppLogin() {
    return false;
  }
}

class CommonUtil {
  /// 判断应用是否已登录
  static void startPage(BuildContext context, String routeName,
      {Object arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }
}
