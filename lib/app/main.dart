import 'package:flutter/material.dart';

import 'package:flutter_app/app/router/app_routes.dart';
import 'package:flutter_app/app/page/logo.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new LogoPage(),
      initialRoute: AppRoutes.logo,
      routes: AppRoutes.initRoutes(),
    );
  }
}
