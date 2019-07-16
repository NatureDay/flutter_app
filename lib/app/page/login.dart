import 'package:flutter/material.dart';

import 'package:flutter_app/app/api/api.dart';
import 'package:flutter_app/app/http/http_util.dart';

/// 登录
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerAccount = new TextEditingController();
  final TextEditingController _controllerPwd = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(50),
              child: Image.asset('assets/images/ic_login_logo.png',
                  fit: BoxFit.fill),
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: TextFormField(
                    controller: _controllerAccount,
                    decoration: InputDecoration(
                      hintText: '输入账号',
                    ),
                    validator: (value) {
                      return value.trim().length > 0 ? null : '用户名不能为空';
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                  child: TextFormField(
                    obscureText: true,
                    controller: _controllerPwd,
                    decoration: InputDecoration(
                      hintText: '输入密码',
                    ),
                    validator: (value) {
                      return value.trim().length > 0 ? null : '密码不能为空';
                    },
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _onLoginPressed,
                  child: Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '登 录',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {
    print("---------_controllerAccount----===" + _controllerAccount.text);
    print("---------_controllerPwd-----===" + _controllerPwd.text);
    Map<String, dynamic> queryParameters = new Map();
    queryParameters['username'] = _controllerAccount.text;
    queryParameters['password'] = _controllerPwd.text;
//        "ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413";
    queryParameters['randomStr'] = new DateTime.now().millisecondsSinceEpoch;
    queryParameters['grant_type'] = "password";
    queryParameters['scope'] = "server";
    queryParameters['type'] = "5";
    HttpUtil.instance
        .post<Map<String, dynamic>>(Api.login, queryParameters: queryParameters)
        .then((value) {}, onError: (e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _controllerAccount.addListener(() {});
    _controllerPwd.addListener(() {});
  }

  @override
  void dispose() {
    _controllerAccount.dispose();
    _controllerPwd.dispose();
    super.dispose();
  }
}
