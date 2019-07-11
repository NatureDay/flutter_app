import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
