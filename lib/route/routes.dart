import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/pages/login/login_page.dart';
import 'package:flutter_mvp/route/route_handlers.dart';

class Routes {
  static String ROOT = "/";
  static String HOME = "/home";
  static String LOGIN = "/login";
//  static String COLLECTION = '/collection';
//  static String BILL = '/bill';
//  static String CLIENT = '/client';
//  static String SETTING = '/setting';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });
    router.define(ROOT, handler: splashHandler);
    router.define(HOME, handler: homeHandler);
    router.define(LOGIN, handler: loginHandler);
  }
}
