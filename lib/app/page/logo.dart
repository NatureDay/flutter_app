import 'package:flutter/material.dart';

class LogoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LogoPageState();
  }
}

class _LogoPageState extends State<LogoPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
  void initState() {}

  @override
  void dispose() {}
}