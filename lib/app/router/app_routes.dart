import 'package:flutter/material.dart';

import 'package:flutter_app/app/page/logo.dart';

class AppRoutes {
  static final String logo = "/logo";
  static final String login = "/login";
  static final String home = "/home";

  static Map<String, WidgetBuilder> initRoutes() {
    return <String, WidgetBuilder>{
      "/logo": (BuildContext context) => new LogoPage(),
    };
  }
}
