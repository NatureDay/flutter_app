import 'package:flutter/material.dart';

/// 主页
class HomePage extends StatefulWidget {
  List<Map<String, dynamic>> data;

  HomePage({List<Map<String, dynamic>> data}) : this.data = data;

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
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: createView(),
    );
  }

  Widget createView() {
    return widget.data == null
        ? Container(
            width: double.infinity,
            height: double.infinity,
            child: Text("暂无数据 "),
            alignment: Alignment.center,
          )
        : ListView(
            children: widget.data.map((Map<String, dynamic> item) {
              return _DataListItem(item: item);
            }).toList(),
          );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _DataListItem extends StatelessWidget {
  const _DataListItem({Key key, Map<String, dynamic> item})
      : this.item = item,
        super(key: key);

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(item["name"]),
      subtitle: Text(item["address"]),
    );
  }
}
