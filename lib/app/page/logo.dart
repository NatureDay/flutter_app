import 'package:flutter/material.dart';

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
    new Timer(const Duration(milliseconds: 3000), () {
      if (AppUtil.isAppLogin()) {
        print("-----------111-----------");
        Navigator.pushNamed(context, AppRoutes.home);
      } else {
        print("-----------222-----------");
        Navigator.pushNamed(context, AppRoutes.login);
      }
    });
  }
}
