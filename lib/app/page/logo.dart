import 'package:flutter/material.dart';
import 'package:flutter_app/app/page/home.dart';

import 'dart:async';
import 'package:flutter_app/app/util/app_util.dart';
import 'package:flutter_app/app/router/app_routes.dart';

class LogoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LogoPageState();
  }
}

class _LogoPageState extends State<LogoPage> with WidgetsBindingObserver {
  AppLifecycleState _notification;

  @override
  Widget build(BuildContext context) {
    if (_notification != null) {
      print("-------AppLifecycleState-------state--===$_notification");
    }
    return new Scaffold(
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        child:
            new Image.asset('assets/images/bg_logo.png', fit: BoxFit.contain),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    print("-------initState---------");
    WidgetsBinding.instance.addObserver(this);
    goNext();
  }

  @override
  void dispose() {
    print("-------dispose---------");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("-------didChangeAppLifecycleState---------");
    setState(() {
      _notification = state;
    });
  }

  void goNext() {
    try {
      new Timer(const Duration(milliseconds: 3000), () {
        if (AppUtil.isAppLogin()) {
          print("-----------111-----------");
          // Navigator.popAndPushNamed(context, AppRoutes.home);
          _goHome();
//          Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => new HomePage()),
//            ModalRoute.withName(AppRoutes.home),
//          );

//          Navigator.pushNamedAndRemoveUntil(
//              context, AppRoutes.home, ModalRoute.withName(AppRoutes.home),
//              arguments: "666");
        } else {
          print("-----------222-----------");
          Navigator.popAndPushNamed(context, AppRoutes.login);

//          Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(
//                builder: (BuildContext context) => new LoginPage()),
//            ModalRoute.withName(AppRoutes.login),
//          );
//          Navigator.pushNamedAndRemoveUntil(
//              context, AppRoutes.login, ModalRoute.withName(AppRoutes.login),
//              arguments: "666");
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _goHome() {
    List<Map<String, dynamic>> data = new List();
    for (int i = 0; i < 50; i++) {
      Map<String, dynamic> item = new Map();
      item["name"] = "姓名啊$i";
      item["address"] = "地址是XXXXXXXXXX$i";
      item["age"] = "$i";
      data.add(item);
    }
    Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) => new HomePage(data: data)),
        ModalRoute.withName(AppRoutes.home));
  }
}
