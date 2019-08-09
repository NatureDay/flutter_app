import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({
    Key key,
    this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("详细信息")),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(data["name"]),
          ),
          ListTile(
            title: Text(data["address"]),
          ),
          ListTile(
            title: Text(data["age"]),
          ),
        ],
      ),
    );
  }
}
