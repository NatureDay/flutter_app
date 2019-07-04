import 'package:flutter/material.dart';

/**
 *  hello world demo
 */
void main() {
  runApp(
    new Container(
      decoration: new BoxDecoration(
        color: Colors.blue,
      ),
      child: new Center(
        child: new Text(
          'Hello World!',
          textDirection: TextDirection.ltr,
        ),
      ),
    ),
  );
}
