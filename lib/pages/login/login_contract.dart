import 'package:flutter_mvp/base/base_contract.dart';
import 'package:rxdart/rxdart.dart';

abstract class ILoginView extends IBaseView {

  /// 跳转到首页
  void navigateHome();

  /// 显示加载提示
  void showLoading({String msg});

  /// 关闭加载提示
  void closeLoading();

  /// 获取用户输入账号
  String getAccount();

  /// 获取用户输入密码
  String getPassword();
}

abstract class ILoginPresenter extends IBasePresenter<ILoginView> {

  /// 登录操作
  void login();
}

abstract class ILoginModel extends IBaseModel{

  /// 登录请求
  Observable login(String account, String password);
}