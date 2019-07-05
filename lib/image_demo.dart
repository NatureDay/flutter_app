import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Web Images';
    return new MaterialApp(
      title: title,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: new Image.network(
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562302770554&di=091b492a02a1aab6e3e351da8f0cb9e2&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201801%2F12%2F20180112195924_R42Ew.thumb.700_0.jpeg"),
      ),
    );
  }
}
