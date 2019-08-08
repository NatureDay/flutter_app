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
  DateTime _lastPress;

  List<BottomNavigationBarItem> _navigationItems;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("首页")),
      body: createView(),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          print("-----index----: $index");
        },
      ),
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
        : WillPopScope(
            child: RefreshIndicator(
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
            ),
            onWillPop: _willPop);
  }

  Future<bool> _willPop() {
    var now = DateTime.now();
    if (_lastPress == null ||
        now.difference(_lastPress) > Duration(seconds: 2)) {
      AlertUtil.showToast("再按一次退出应用");
      _lastPress = now;
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
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

    _navigationItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        title: Text("首页"),
        icon: const Icon(
          Icons.home,
        ),
        activeIcon: const Icon(
          Icons.home,
        ),
        backgroundColor: Colors.white,
      ),
      BottomNavigationBarItem(
        title: Text("用户"),
        icon: const Icon(
          Icons.account_box,
        ),
        activeIcon: const Icon(
          Icons.account_box,
        ),
        backgroundColor: Colors.white,
      ),
    ];
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
    @required this.item,
    @required this.itemCallback,
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
