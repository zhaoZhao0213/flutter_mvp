import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_mvp/net/netresponse/net_response.dart';
import 'package:flutter_mvp/constants/constants.dart';

import 'interceptor.dart';

class DioFactory {
  /// global dio object
  Dio dio;

  /// default options
  static const int CONNECT_TIMEOUT = 15000;
  static const int RECEIVE_TIMEOUT = 15000;

  /// http request methods
  static const String GET = 'GET';
  static const String POST = 'POST';
  static const String PUT = 'PUT';
  static const String PATCH = 'PATCH';
  static const String DELETE = 'DELETE';

  factory DioFactory() => _getInstance();

  static DioFactory get instance => _getInstance();
  static DioFactory _instance;
  BaseOptions options;

  ///是否开启代理
  bool isProxy = false;

  DioFactory._internal() {
    dio = Dio()
      ..options = BaseOptions(
        baseUrl: Constants.BASE_URL,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      )
      ..interceptors.add(LogHttpInterceptor());
    if (isProxy) {
      //Fiddler 抓包设置代理
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return "PROXY 192.168.0.122:8888";
        };
        //抓Https包设置
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  static DioFactory _getInstance() {
    if (_instance == null) {
      _instance = DioFactory._internal();
    }
    return _instance;
  }
}
