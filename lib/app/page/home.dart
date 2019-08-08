import 'package:flutter/material.dart';
import 'package:flutter_app/app/util/alert_util.dart';
import 'package:flutter_app/app/util/log_util.dart';

import 'info.dart';

/// 主页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Widget> _pages;
  List<BottomNavigationBarItem> _navigationItems;

  DateTime _lastPress;

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _navigationItems,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          print("-----index----: $index");
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: createView(),
    );
  }

  Widget createView() {
    return WillPopScope(
      onWillPop: _willPop,
      child: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
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
    List<Map<String, dynamic>> data = new List();
    for (int i = 0; i < 50; i++) {
      Map<String, dynamic> item = new Map();
      item["name"] = "姓名啊$i";
      item["address"] = "地址是XXXXXXXXXX$i";
      item["age"] = "$i";
      data.add(item);
    }
    _pages = <Widget>[
      FirstPage(data: data),
      SecondPage(),
    ];
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
}

/// 第一个页面
class FirstPage extends StatefulWidget {
  List<Map<String, dynamic>> data;

  FirstPage({List<Map<String, dynamic>> data}) : this.data = data;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirstPageState();
  }
}

class _FirstPageState extends State<FirstPage> {
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

  Future<void> _doRefresh() async {
    LogUtil.i("-------doRefresh--------");
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
//      LogUtil.i("--------maxScrollExtent---======" +
//          _controller.position.maxScrollExtent.toString());
//      LogUtil.i("--------maxScrollExtent--pixels-======" +
//          _controller.position.pixels.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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

/// 第一个页面
class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondPageState();
  }
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("个人中心"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            child: const Icon(
              Icons.accessibility,
            ),
          ),
          SizedBox(height: 20),
          Text("个人信息"),
        ],
      ),
    );
  }
}
