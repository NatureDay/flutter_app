import 'package:flutter/material.dart';

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
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(50),
              child: Image.asset('assets/images/ic_login_logo.png',
                  fit: BoxFit.fill),
            ),
            new Form(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: new TextFormField(
                    controller: _controllerAccount,
                    decoration: new InputDecoration(
                      hintText: '输入账号',
                    ),
                    validator: (value) {
                      return value.trim().length > 0 ? null : '用户名不能为空';
                    },
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                  child: new TextFormField(
                    decoration: new InputDecoration(
                      hintText: '输入密码',
                    ),
                    validator: (value) {
                      return value.trim().length > 0 ? null : '密码不能为空';
                    },
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  onPressed: _onLoginPressed,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(0.0),
                    child: const Text('登 录', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  void _onLoginPressed() {}

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
