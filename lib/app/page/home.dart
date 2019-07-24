import 'package:flutter/material.dart';
import 'package:flutter_app/app/util/alert_util.dart';

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
              return _DataListItem(
                item: item,
                itemCallback: _handleCallBack,
              );
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

  void _handleCallBack(Map<String, dynamic> item) {
    AlertUtil.showToast(item.toString());
  }
}

typedef void ItemCallback(Map<String, dynamic> item);

class _DataListItem extends StatelessWidget {
  _DataListItem({Map<String, dynamic> item, this.itemCallback})
      : this.item = item,
        super(key: UniqueKey());

  final Map<String, dynamic> item;
  final ItemCallback itemCallback;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(item["name"]),
      subtitle: Text(item["address"]),
      onTap: () {
        itemCallback(item);
      },
    );
  }
}
