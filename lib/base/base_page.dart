import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/utils/util_toast.dart';
import 'package:flutter_mvp/widget/loading_dialog.dart';
import 'package:get_it/get_it.dart';
import 'base_presenter.dart';
import 'base_view.dart';

abstract class BasePageState<T extends BasePresenter>
    extends State<StatefulWidget> with AutomaticKeepAliveClientMixin implements BaseView {
  T presenter = Application.getIt.get<T>();

  bool _isPrepared = false;

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    _attachView();
    if (!_isPrepared) {
      Timer.run(() => preparePage());
      _isPrepared = true;
    }
    return null;
  }

  @mustCallSuper
  @override
  void dispose() {
    super.dispose();
    _detachView();
  }

  /// 初始化一次 =》 用于 presenter 请求网络数据后调用 showDialog 拿不到合适的 context 报错
  void preparePage();

  @override
  void reload() {}

  @override
  void renderPage(Object o) {}

  @override
  void showDisConnect() {}

  @override
  void showError({String errorMsg}) {
    // TODO: implement showError
    if (errorMsg != null) {
      ToastUtil.showToast(errorMsg);
    }
  }

  @override
  void showLoading({String msg}) {
    // TODO: implement showLoad
    /// 把 dialog 的 show 从 普通页面里分离
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoadingDialog(
            text: msg ?? '加载中',
          );
        });
  }

  @override
  void closeLoading() {
    // TODO: implement closeLoading
    /// 必须和 showLoading 方法配对使用 ，避免 pop 当前页面
    Navigator.pop(context);
  }

  void _attachView(){
    if(null != presenter){
      presenter.attachView(this);
    }
  }

  void _detachView(){
    if(null != presenter){
      presenter.detachView();
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
