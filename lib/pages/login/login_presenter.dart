import 'package:flutter_mvp/base/base_presenter.dart';
import 'package:flutter_mvp/exception/exception.dart';
import 'package:flutter_mvp/pojo/response/login_rsp.dart';
import 'package:flutter_mvp/utils/sputil.dart';

import 'login_contract.dart';
import 'login_model.dart';

class LoginPresenter extends BasePresenter<ILoginView>
    implements ILoginPresenter {
  ILoginModel _loginModel;

  LoginPresenter() {
    _loginModel = LoginModel();
  }

  @override
  void login() {
    // TODO: implement login
    view.showLoading(msg: '登录中...');
    _loginModel.login(view.getAccount(), view.getPassword()).listen((dataMap) {
      view.closeLoading();
      print('登录响应数据：${dataMap.toString()}');
      LoginRsp loginRsp = LoginRsp.fromJson(dataMap);
      SpUtil.setToken(loginRsp.access_token);
    }, onError: (error) {
      view.closeLoading();
      if (error is CommonException) {
        print('登录错误： ${error.errorMsg}');
      } else {
        print('登录错误： ${error.toString()}');
      }
    }, onDone: () {
      //实际开发中只有登录成功才跳转
      view.navigateHome();
    });
  }
}
