import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'dart:convert';
import 'package:flutter_app/model/user.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'http demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'http demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  void _doGet() async {
    print("-------_doGet-----------");
    Dio dio = new Dio();
    Response response = await dio.get("https://www.baidu.com/");
    print("----_doGet-----response--: " + response.toString());
  }

  void _doPost() {
    print("-------_doPost-----------");
    Object user = new User("张三", "66666666666");
    String sss = json.encode(user);
    print("-------_doPost-------111===" + sss);

    dynamic sssss = json.decode(sss);
    print("-------_doPost-------222===" + sssss.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(color: Colors.grey),
              padding: const EdgeInsets.all(16),
              child: new FittedBox(
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                child: new GestureDetector(
                  child: new Text(
                    'GET',
                    style: new TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onTap: _doGet,
                ),
              ),
            ),
            new Container(
                width: double.infinity,
                constraints: new BoxConstraints(minWidth: 200),
                decoration: new BoxDecoration(color: Colors.grey),
                padding: const EdgeInsets.all(16),
                child: new Align(
                  alignment: Alignment.center,
                  child: new GestureDetector(
                    child: new Text(
                      'POST',
                      style: new TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    onTap: _doPost,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
