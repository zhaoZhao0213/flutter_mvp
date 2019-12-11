import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_mvp/net/network/api_service.dart';
import 'package:flutter_mvp/net/network/dio_request.dart';
import 'package:flutter_mvp/pages/login/login_presenter.dart';
import 'package:flutter_mvp/route/navigate_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';

class Application {
  static Router router;
  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static SharedPreferences sp;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static GetIt getIt = GetIt.instance;

  static initSp() async {
    sp = await SharedPreferences.getInstance();
  }

  static initScreenUtil(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334) ..init(context);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
  }

  static setupLocator(){
    getIt.registerSingleton(NavigateService());
    getIt.registerSingleton(DioRequest());
    getIt.registerSingleton(ApiService());
    getIt.registerSingleton(LoginPresenter());
  }
}