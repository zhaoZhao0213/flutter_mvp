class IBaseView {
}

abstract class IBasePresenter<T extends IBaseView> {

  /// 绑定 view
  void attachView(T view);

  /// 分离 view
  void detachView();
}

abstract class IBaseModel {

}

