import 'package:flutter/material.dart';
import 'package:flutter_app/app/util/alert_util.dart';
import 'package:flutter_app/app/util/log_util.dart';

import 'info.dart';

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
  ScrollController _controller = new ScrollController();

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
        : RefreshIndicator(
            onRefresh: _doRefresh,
            child: ListView(
              children: widget.data.map((Map<String, dynamic> item) {
                return _DataListItem(
                  item: item,
                  itemCallback: _handleCallBack,
                );
              }).toList(),
              controller: _controller,
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      LogUtil.i("--------maxScrollExtent---======" +
          _controller.position.maxScrollExtent.toString());
      LogUtil.i("--------maxScrollExtent--pixels-======" +
          _controller.position.pixels.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Future<void> _doRefresh() async {
    LogUtil.i("-------doRefresh--------");
  }

  void _handleCallBack(Map<String, dynamic> item) {
//    AlertUtil.showToast(item.toString());
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new InfoPage(
          data: item,
        ),
      ),
    );
  }
}

typedef void ItemCallback(Map<String, dynamic> item);

class _DataListItem extends StatelessWidget {
  const _DataListItem({
    Key key,
    this.item,
    this.itemCallback,
  }) : super(key: key);

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
