import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "组件可见性",
      home: new TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  bool _firstVisiable = false;
  bool _secondVisiable = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("组件可见性"),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                onPressed: _changeFirst,
                child: new Text("Offstage方式"),
              ),
              new Offstage(
                offstage: _firstVisiable,
                child: new Icon(Icons.airplanemode_active),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new RaisedButton(
                onPressed: _changeSecond,
                child: new Text("Visibility方式"),
              ),
              new Visibility(
                visible: _secondVisiable,
                maintainState: true,
                maintainSize: true,
                maintainAnimation: true,
                maintainSemantics: true,
                maintainInteractivity: true,
                child: new Icon(Icons.audiotrack),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _changeFirst() {
    setState(() {
      _firstVisiable = !_firstVisiable;
    });
  }

  void _changeSecond() {
    setState(() {
      _secondVisiable = !_secondVisiable;
    });
  }
}
