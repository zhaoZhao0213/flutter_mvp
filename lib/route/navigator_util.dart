import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/route/routes.dart';

class NavigatorUtil {
  static _navigateTo(BuildContext context, String path,
      {bool replace = false,
      bool clearStack = false,
      Duration transitionDuration = const Duration(milliseconds: 250),
      RouteTransitionsBuilder transitionsBuilder}) {
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transitionDuration: transitionDuration,
        transitionBuilder: transitionsBuilder,
        transition: TransitionType.material);
  }

  //首页
  static void goHomePage(BuildContext context, {bool replace}) {
    _navigateTo(context, Routes.HOME, replace: replace);
  }

  //登录页
  static void goLoginPage(BuildContext context, {bool replace}) {
    _navigateTo(context, Routes.LOGIN, replace: replace);
  }
}
