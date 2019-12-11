import 'package:flutter_mvp/base/base_model.dart';
import 'package:rxdart/src/observables/observable.dart';

import 'login_contract.dart';

class LoginModel extends BaseModel implements ILoginModel {

  @override
  Observable login(String account, String password) {
    // TODO: implement login
    return apiService.login(account, password);
  }
}
