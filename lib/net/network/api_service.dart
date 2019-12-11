import 'package:flutter_mvp/app/application.dart';
import 'package:rxdart/rxdart.dart';
import 'dio_request.dart';

class ApiService {

  DioRequest _dioRequest = Application.getIt.get<DioRequest>();

  /// 登录
  Observable login(String account, String password){
    return _dioRequest.handlerFormPost('/api/auth/login', params: {
      'grant_type':'mch',
      'mch_seller_number':account,
      'password':password
    });
  }
}
