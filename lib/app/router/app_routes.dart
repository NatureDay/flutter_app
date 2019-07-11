import 'package:flutter/material.dart';

import 'package:flutter_app/app/page/logo.dart';
import 'package:flutter_app/app/page/login.dart';
import 'package:flutter_app/app/page/home.dart';

/// 应用相关页面配置，用于页面跳转
class AppRoutes {
  static final String logo = "/logo";
  static final String login = "/login";
  static final String home = "/home";

  static Map<String, WidgetBuilder> initRoutes() {
    return <String, WidgetBuilder>{
      "/logo": (BuildContext context) => new LogoPage(),
      "/login": (BuildContext context) => new LoginPage(),
      "/home": (BuildContext context) => new HomePage(),
    };
  }
}
