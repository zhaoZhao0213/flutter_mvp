import 'package:flutter_mvp/utils/sputil.dart';

import 'base_contract.dart';

abstract class BasePresenter<T extends IBaseView> implements IBasePresenter<T> {
  T view;

  @override
  void attachView(T view) {
    this.view = view;
  }

  @override
  void detachView() {
    if (null != view) {
      this.view = null;
    }
  }
}
