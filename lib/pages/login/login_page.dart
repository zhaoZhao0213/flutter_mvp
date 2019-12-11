import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/base/base_page.dart';
import 'package:flutter_mvp/route/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_contract.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPresenter> implements ILoginView{

  _navigateHomePage(BuildContext context) {
    NavigatorUtil.goHomePage(context, replace: true);
  }
  
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Color _btnColor = Color(0xff00A0E9);

  bool _isObscureText = true;
  void _setStatus(int status) {
    setState(() {
      switch (status) {
        case 0:
          _login();
          break;
        case 1:
          _btnColor = Color(0xff0083BF);
          break;
        case 2:
          _btnColor = Color(0xff00A0E9);
          break;
      }
    });
  }

  void _closeOrOpenEye(){
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  void initState() {
    _accountController.text = '00113582010041';
    _passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Application.initScreenUtil(context);
    super.build(context);
    _accountController.addListener((){});
    _passwordController.addListener((){});
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            /// 手机号
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50),
                  top: ScreenUtil().setHeight(580)),
              child: TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  hintText: '请输入手机号',
                ),
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
            ),

            /// 密码
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50),
                  top: ScreenUtil().setHeight(50)),
              child: Stack(
                children: <Widget>[
                  TextField(
                    obscureText: _isObscureText,
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '输入密码',
                    ),
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  ),
                  /// 小眼睛
                  Positioned(
                    child: Center(
                      child: GestureDetector(
                        child: Image.asset('assets/images/${_isObscureText ? 'icon_eye_close' : 'icon_eye_open'}.png'),
                        onTap: _closeOrOpenEye,
                      ),
                    ),
                    right: 0,
                    top: ScreenUtil().setHeight(25),
                  )
                ],
              ),
            ),

            /// 忘记密码
            Row(),
            /// 登录
            GestureDetector(
              onTapDown: (_) => _setStatus(1),
              onTapUp: (_) => _setStatus(2),
              onTap: () => _setStatus(0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(75),
                    right: ScreenUtil().setWidth(75),
                    top: ScreenUtil().setHeight(227)),
                child: Center(
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(34),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      ScreenUtil().setWidth(10),
                    ),
                  ),
                  color: _btnColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async{
    presenter.login();
  }

  @override
  void preparePage() {
    // TODO: implement preparePage
  }

  @override
  String getAccount() {
    // TODO: implement getAccount
    return _accountController.text;
  }

  @override
  String getPassword() {
    // TODO: implement getPassword
    return _passwordController.text;
  }

  @override
  void navigateHome() {
    // TODO: implement navigateHome
    NavigatorUtil.goHomePage(context,replace: true);
  }
}
