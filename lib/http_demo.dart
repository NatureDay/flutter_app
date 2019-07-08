import 'package:flutter/material.dart';

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
  void _doGet() {
    print("-------_doGet-----------");
  }

  void _doPost() {
    print("-------_doPost-----------");
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
//          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(16),
              child: new GestureDetector(
                child: new Text(
                  'GET',
                  style: new TextStyle(color: Colors.black, fontSize: 20),
                ),
                onTap: _doGet,
              ),
            ),
            new Container(
                width: double.infinity,
                constraints: new BoxConstraints(minWidth: 200),
                decoration: new BoxDecoration(color: Colors.black),
                padding: const EdgeInsets.all(16),
                child: new Align(
                  alignment: Alignment.centerRight,
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
