import 'package:dio/dio.dart';
import 'package:flutter_mvp/exception/exception.dart';
import 'package:rxdart/rxdart.dart';

import 'dio_factory.dart';

class DioRequest {
  Future _get(String url, {Map<String, dynamic> params}) async {
    var response =
        await DioFactory.instance.dio.get(url, queryParameters: params);
    return response.data;
  }

  Future _formPost(String url, Map<String, dynamic> params) async {
    var formData = params != null ? FormData.from(params) : null;
    var response = await DioFactory.instance.dio.post(url, data: formData);
    if (response.data['code'] != 0) {
      throw CommonException(errorMsg: response.data['message']);
    }
    return response.data['data'];
  }

  Observable get(String url, {Map<String, dynamic> params}) =>
      Observable.fromFuture(_get(url, params: params)).asBroadcastStream();

  Observable formPost(String url, Map<String, dynamic> params) =>
      Observable.fromFuture(_formPost(url, params)).asBroadcastStream();

  Observable handlerGet(String requestUrl, {Map params}) {
    return get(requestUrl);
  }

  Observable handlerFormPost(String requestUrl, {Map<String, dynamic> params}) {
    return formPost(requestUrl, params);
  }
}
