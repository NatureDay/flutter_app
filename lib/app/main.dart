import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/app.dart';

import 'package:flutter_app/app/router/app_routes.dart';
import 'package:flutter_app/app/page/logo.dart';

void main() {
  runApp(new MyApp());

  /** 设置状态栏颜色 */
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
//        statusBarBrightness: Brightness.light,
//        statusBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ThemeData themeData = ThemeData.light().copyWith(
      primaryColor: Colors.lightBlue,
      accentColor: Colors.red,
    );
    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter'),
//        ),
//        body: new Center(
////          child: new Text('Hello World'),
////          child: new Text(wordPair.asPascalCase),
//          child: new RandomWords(),
//        ),
//      ),
      title: 'flutter app demo',
      theme: themeData,
      home: new LogoPage(),
      initialRoute: AppRoutes.logo,
      routes: AppRoutes.initRoutes(),
    );
  }

  @override
  void initState() {
    super.initState();
    AppInfoHelper.instance.initAppData();
  }
}
