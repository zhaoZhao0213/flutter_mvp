
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_mvp/exception/exception.dart';

class LogHttpInterceptor extends Interceptor {


  @override
  FutureOr<dynamic> onRequest(RequestOptions options) {
    print("\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣ 请求数据 start ￣￣￣￣￣￣￣￣￣￣￣￣￣￣");
    print("url = ${options.uri.toString()}");
    print("headers = ${options.headers}");
    print("params = ${options.data}");
    print("\n______________________________ 请求数据 end ______________________________");
    return super.onRequest(options);
  }

  @override
  FutureOr<dynamic> onError(DioError err) {
    print("\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣ 错误响应数据 start ￣￣￣￣￣￣￣￣￣￣￣￣￣￣");
    print("type = ${err.type}");
    print("message = ${err.message}");
    print("stackTrace = ${err.stackTrace}");
//    print("statusCode = ${err.response.statusCode}");
    String errorMsg;
    switch(err.type){
      case DioErrorType.SEND_TIMEOUT:
        // TODO: Handle this case.
      errorMsg = '请求超时';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        // TODO: Handle this case.
        errorMsg = '接收超时';
        break;
      case DioErrorType.RESPONSE:
        // TODO: Handle this case.
        errorMsg = '响应错误';
        break;
      case DioErrorType.CANCEL:
        // TODO: Handle this case.
        errorMsg = '取消请求';
        break;
      case DioErrorType.DEFAULT:
        // TODO: Handle this case.
        errorMsg = '网络错误';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        // TODO: Handle this case.
        errorMsg = '连接超时';
        break;
    }
    throw CommonException(errorMsg: errorMsg, type: err.type);
  }

  @override
  FutureOr<dynamic> onResponse(Response response) {
    print("\n￣￣￣￣￣￣￣￣￣￣￣￣￣￣ 响应数据 start ￣￣￣￣￣￣￣￣￣￣￣￣￣￣");
    print("code = ${response.statusCode}");
    print("data = ${response.data}");
    print("\n______________________________ 响应数据 end ______________________________");
  }
}