import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/util/alert_util.dart';
import 'package:flutter_app/app/util/log_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../app.dart';
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
      item["index"] = i;
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
//  ScrollController _controller = new ScrollController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text("首页"),
          ),
          preferredSize: Size.fromHeight(44)),
      body: createView(),
    );
  }

//  Widget createView() {
//    return widget.data == null
//        ? Container(
//            width: double.infinity,
//            height: double.infinity,
//            child: Text("暂无数据 "),
//            alignment: Alignment.center,
//          )
//        : RefreshIndicator(
//            onRefresh: _doRefresh,
//            child: ListView(
//              children: widget.data.map((Map<String, dynamic> item) {
//                return _DataListItem(
//                  item: item,
//                  itemCallback: _handleCallBack,
//                );
//              }).toList(),
////              controller: _controller,
//            ),
//          );
//  }

  Future<void> _doRefresh() async {
    LogUtil.i("-------doRefresh--------");
    AlertUtil.showToast("刷新完成了");
  }

  Widget createView() {
    return widget.data == null
        ? Container(
            width: double.infinity,
            height: double.infinity,
            child: Text("暂无数据"),
            alignment: Alignment.center,
          )
        : SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: MaterialClassicHeader(),
            footer: ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
            ),
//            footer: CustomFooter(
//              builder: (BuildContext context, LoadStatus mode) {
//                Widget body;
//                if (mode == LoadStatus.idle) {
//                  body = Text("上拉加载");
//                } else if (mode == LoadStatus.loading) {
//                  body = CupertinoActivityIndicator();
//                } else if (mode == LoadStatus.failed) {
//                  body = Text("加载失败！点击重试！");
//                } else if (mode == LoadStatus.canLoading) {
//                  body = Text("松手,加载更多!");
//                } else {
//                  body = Text("没有更多数据了!");
//                }
//                return Container(
//                  height: 55.0,
//                  child: Center(child: body),
//                );
//              },
//            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            /// ListView.builder模式
            child: new ListView.builder(
                itemCount: widget.data.length,
                itemBuilder: (BuildContext context, int position) {
                  return new _DataListItem(
                    item: widget.data[position],
                    itemCallback: _handleCallBack,
                  );
                }),

//            child: ListView(
//              children: widget.data.map((Map<String, dynamic> item) {
//                return _DataListItem(
//                  item: item,
//                  itemCallback: _handleCallBack,
//                );
//              }).toList(),
//            ),
          );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    AlertUtil.showToast("刷新完成了");
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length + 1).toString());
//    if (mounted) setState(() {});
    _refreshController.loadComplete();
    AlertUtil.showToast("加载完成了");
  }

  @override
  void initState() {
    super.initState();
//    _controller.addListener(() {
//      LogUtil.i("--------maxScrollExtent---======" +
//          _controller.position.maxScrollExtent.toString());
//      LogUtil.i("--------maxScrollExtent--pixels-======" +
//          _controller.position.pixels.toString());
//    });
  }

  @override
  void dispose() {
    super.dispose();
//    _controller.dispose();
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

class _DataListItem extends StatefulWidget {
  _DataListItem({
    Key key,
    @required this.item,
    @required this.itemCallback,
  }) : super(key: key);

  final Map<String, dynamic> item;
  final ItemCallback itemCallback;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _DataListItemState();
  }
}

class _DataListItemState extends State<_DataListItem> {
  bool _isSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool isSingle = widget.item["index"] % 2 == 0;
    _isSelected = widget.item["isSelected"] ?? false;
    var iconData = _isSelected
        ? const Icon(
            Icons.favorite,
            color: Colors.lightBlue,
          )
        : const Icon(
            Icons.favorite_border,
            color: Colors.grey,
          );
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(widget.item["name"]),
          subtitle: Text(widget.item["address"]),
          trailing: !isSingle ? iconData : null,
          onTap: () {
            if (isSingle) {
              widget.itemCallback(widget.item);
            } else {
              setState(() {
                widget.item["isSelected"] = !_isSelected;
              });
            }
          },
        ),
        Divider(height: 1),
      ],
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
//      appBar: AppBar(
//        title: Text("个人中心"),
//      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 25),
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            decoration: BoxDecoration(color: Colors.lightBlue),
            child: Align(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/ic_default_head.png",
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "张三啊",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.message),
            title: Text("个人信息"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              AlertUtil.showToast("个人信息");
            },
          ),
          Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text("消费记录"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              AlertUtil.showToast("消费记录");
            },
          ),
          Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.backup),
            title: Text("版本更新"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              AlertUtil.showToast("版本更新");
            },
          ),
          Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text("设置"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              AlertUtil.showToast("设置");
            },
          ),
          Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text("退出登录"),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              _showExit();
            },
          ),
        ],
      ),
    );
  }

  void _showExit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
//            title: Text("退出登录"),
//            content: SingleChildScrollView(
//              child: ListBody(
//                children: <Widget>[Text("确定要退出登录吗？")],
//              ),
//            ),
            content: Text("确定要退出登录吗？"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("取消"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  AppInfoHelper.instance.clearAppData().then((value) {
                    exit(0);
                  });
                },
                child: Text("确定"),
              ),
            ],
          );
        });
  }
}
