import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/route/navigator_util.dart';
import 'package:flutter_mvp/utils/util_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  _navigateNextPage(BuildContext context) {
    NavigatorUtil.goLoginPage(context, replace: true);
  }
//  int _count = 5;

  //定义变量
  Timer _timer;
  //倒计时数值
  int _countdownTime = 5;

  //倒计时方法
  _startCountdown() {
    final call = (timer) {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
          NavigatorUtil.goLoginPage(context, replace: true);
        } else {
          _countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  _goToNextPage(){
    _timer.cancel();
    NavigatorUtil.goLoginPage(context, replace: true);
  }

  @override
  void initState() {
    // TODO: implement initState
    _startCountdown();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Application.initScreenUtil(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Image.asset('assets/images/luncher.png'),
            Positioned(
              top: ScreenUtil().setHeight(50),
              right: 0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: _goToNextPage,
                  child: Text(
                    '跳过 $_countdownTime',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0x66000000),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  border: Border.all(width: 0.33, color: Colors.lightBlue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
