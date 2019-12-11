import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/pages/home/page_home.dart';
import 'package:flutter_mvp/pages/login/login_page.dart';
import 'package:flutter_mvp/pages/splash/page_splash.dart';
import 'package:flutter_mvp/route/navigate_service.dart';
import 'package:flutter_mvp/route/routes.dart';
import 'package:flutter_mvp/widget/tab_navigator.dart';

void main() {
 Router router = Router();
 Routes.configureRoutes(router);
 Application.router = router;
 Application.setupLocator();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Application.getIt<NavigateService>().globalKey,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF00A0E9),
        splashColor: Colors.transparent,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      home: LoginPage(),
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: true,
    );
  }
}

