import 'package:flutter/material.dart';

/**
 * 在Flutter中，这两种类型的对象具有不同的生命周期： Widget是临时对象，用于构建当前状态下的应用程序，
 * 而State对象在多次调用build()之间保持不变，允许它们记住信息(状态)。上面的例子接受用户点击，
 * 并在点击时使_counter自增，然后直接在其build方法中使用_counter值。在更复杂的应用程序中，
 * widget结构层次的不同部分可能有不同的职责； 例如，一个widget可能呈现一个复杂的用户界面，
 * 其目标是收集特定信息（如日期或位置），而另一个widget可能会使用该信息来更改整体的显示。
 * 在Flutter中，事件流是“向上”传递的，而状态流是“向下”传递的（译者语：这类似于React/Vue中父子组件通信的方式：
 * 子widget到父widget是通过事件通信，而父到子是通过状态），重定向这一流程的共同父元素是State。
 */
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "State Widget Demo",
      home: new Counter(),
    );
  }
}

/**
 * 包含状态的Widget demo
 */
class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new CounterIncrementor(onPressed: _increment),
      new CounterDisplay(count: _counter),
    ]);
  }
}
