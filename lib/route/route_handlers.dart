import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/pages/home/page_home.dart';
import 'package:flutter_mvp/pages/login/login_page.dart';
import 'package:flutter_mvp/pages/splash/page_splash.dart';

//欢迎页
var splashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return SplashPage();
    }
);

//首页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return HomePage();
    }
);

//登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        return LoginPage();
    }
);
