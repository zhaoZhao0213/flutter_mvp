

# Flutter MVP 快速开发

练习做的项目，来做一些学习笔记，具体框架的使用方法就不做记录，网上很多，这里只做 MVP 框架搭建，框架借鉴了其他大佬写的一些代码，然后按照自己又做了些调整

### 基础配置

先来看下依赖的库都有哪些，也不一定全部都用到了 ，看自己项目需要吧  

```yaml
dependencies:
  flutter:
    sdk: flutter
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2
  # 路由
  fluro: ^1.5.1
  # 简单数据存储
  shared_preferences: ^0.5.3+4
  # 依赖注入
  get_it: ^3.0.1
  # 吐司
  fluttertoast: ^3.1.3
  # 尺寸适配
  flutter_screenutil: ^0.6.0
  # 二维码条形码扫描
  flutter_qr_reader: ^1.0.3
  # 权限申请
  permission_handler: ^3.0.0
  # 网络请求
  dio: ^2.0.1
  #	手机网络状态监听
  connectivity: ^0.4.3+7
  #	消息总线
  event_bus: ^1.1.0
  # 刷新 加载
  pull_to_refresh: ^1.5.4
  # Rx
  rxdart: ^0.21.0

```

**在入口函数 main() 中进行部分框架的初始化：** 

```dart
void main() {
 Router router = Router();
 Routes.configureRoutes(router);
 Application.router = router;
 Application.setupLocator();
 runApp(MyApp());
}
```

1. 1、2、3 行是用来配置项目中路由的（**fluro**  框架）
2. **Application.setupLocator()**  初始化 **get_it** 依赖注入框架，相当于 Android 中 **dagger2**
3. 其中在 Application 中还做了屏幕适配配置

> 看下 Application 中的代码吧：

```dart
class Application {
  static Router router;
  static GlobalKey<NavigatorState> globalKey = GlobalKey();
  static SharedPreferences sp;
  static double screenWidth;
  static double screenHeight;
  static double statusBarHeight;
  static GetIt getIt = GetIt.instance;

  static initSp() async {
    sp = await SharedPreferences.getInstance();
  }

  static initScreenUtil(BuildContext context){
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334) ..init(context);
    final size = MediaQuery.of(context).size;
    Application.screenWidth = size.width;
    Application.screenHeight = size.height;
    Application.statusBarHeight = MediaQuery.of(context).padding.top;
  }

  static setupLocator(){
    getIt.registerSingleton(NavigateService());
    getIt.registerSingleton(DioRequest());
    getIt.registerSingleton(ApiService());
    getIt.registerSingleton(SettingPresenter());
    getIt.registerSingleton(LoginPresenter());
    getIt.registerSingleton(CollectionPresenter());
    getIt.registerSingleton(BillPresenter());
  }
}
```

> 看一下 main.dart 中的全部代码，基础框架初始化完成直接打开登录页面

```dart
void main() {
 Router router = Router();
 Routes.configureRoutes(router);
 Application.router = router;
 Application.setupLocator();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Application.getIt<NavigateService>().globalKey,
      theme: ThemeData(///项目主题设置
        brightness: Brightness.light,
        primaryColor: Color(0xFF00A0E9),
        splashColor: Colors.transparent,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      home: LoginPage(),
      onGenerateRoute: Application.router.generator,///路由生成
      debugShowCheckedModeBanner: true,
    );
  }
}
```

### 开始搭建 MVP

> base_contract.dart

```dart
abstract class IBaseView {
}

abstract class IBasePresenter<T extends IBaseView> {

  /// 绑定 view
  void attachView(T view);

  /// 分离 view
  void detachView();
}

abstract class IBaseModel {

}
```

> base_view.dart（继承 base_contract.dart 中的 IBaseView）

```dart
import 'base_contract.dart';

class BaseView extends IBaseView {
  void showLoading({String msg}) {
  }

  void closeLoading() {

  }

  void renderPage(Object object) {

  }

  void reload() {

  }

  void showError({String errorMsg}) {

  }

  void showDisConnect() {

  }
}
```



**接下来创建三个基础抽象类**  

> base_page.dart（实现 base_contract.dart 中的 IBaseView）

```dart
abstract class BasePageState<T extends BasePresenter>
    extends State<StatefulWidget> with AutomaticKeepAliveClientMixin implements BaseView {
  T presenter = Application.getIt.get<T>();

  bool _isPrepared = false;

  @mustCallSuper///注意看这个注解，贼鸡儿重要，必须在子类中调用父类的这个方法，不然子类的 					///presenter 中会报 view 空指针
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
```



> base_presenter.dart （实现 base_contract.dart 中的 IBasePresenter）

```dart
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
```

> base_model.dart（实现 base_contract.dart 中的 IBaseModel）

```dart
class BaseModel implements IBaseModel {
  ApiService apiService = Application.getIt.get<ApiService>();
}
```

### 应用（登录）

> login_contract.dart

```dart
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
```



> login_page.dart

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/app/application.dart';
import 'package:flutter_mvp/base/base_page.dart';
import 'package:flutter_mvp/route/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_contract.dart';
import 'login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPresenter> implements ILoginView{

  _navigateHomePage(BuildContext context) {
    NavigatorUtil.goHomePage(context, replace: true);
  }
  
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Color _btnColor = Color(0xff00A0E9);

  bool _isObscureText = true;
  void _setStatus(int status) {
    setState(() {
      switch (status) {
        case 0:
          _login();
          break;
        case 1:
          _btnColor = Color(0xff0083BF);
          break;
        case 2:
          _btnColor = Color(0xff00A0E9);
          break;
      }
    });
  }

  void _closeOrOpenEye(){
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  void initState() {
    _accountController.text = '00113582010041';
    _passwordController.text = '123456';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Application.initScreenUtil(context);
    super.build(context);
    _accountController.addListener((){});
    _passwordController.addListener((){});
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            /// 手机号
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50),
                  top: ScreenUtil().setHeight(580)),
              child: TextField(
                controller: _accountController,
                decoration: InputDecoration(
                  hintText: '请输入手机号',
                ),
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
            ),

            /// 密码
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(50),
                  right: ScreenUtil().setWidth(50),
                  top: ScreenUtil().setHeight(50)),
              child: Stack(
                children: <Widget>[
                  TextField(
                    obscureText: _isObscureText,
                    textInputAction: TextInputAction.done,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: '输入密码',
                    ),
                    style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                  ),
                  /// 小眼睛
                  Positioned(
                    child: Center(
                      child: GestureDetector(
                        child: Image.asset('assets/images/${_isObscureText ? 'icon_eye_close' : 'icon_eye_open'}.png'),
                        onTap: _closeOrOpenEye,
                      ),
                    ),
                    right: 0,
                    top: ScreenUtil().setHeight(25),
                  )
                ],
              ),
            ),

            /// 忘记密码
            Row(),
            /// 登录
            GestureDetector(
              onTapDown: (_) => _setStatus(1),
              onTapUp: (_) => _setStatus(2),
              onTap: () => _setStatus(0),
              child: Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(75),
                    right: ScreenUtil().setWidth(75),
                    top: ScreenUtil().setHeight(227)),
                child: Center(
                  child: Text(
                    '登录',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(34),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      ScreenUtil().setWidth(10),
                    ),
                  ),
                  color: _btnColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async{
    presenter.login();
  }

  @override
  void preparePage() {
    // TODO: implement preparePage
  }

  @override
  String getAccount() {
    // TODO: implement getAccount
    return _accountController.text;
  }

  @override
  String getPassword() {
    // TODO: implement getPassword
    return _passwordController.text;
  }

  @override
  void navigateHome() {
    // TODO: implement navigateHome
    NavigatorUtil.goHomePage(context,replace: true);
  }
}
```



> login_presenter.dart

```dart
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
```



> login_model.dart

```dart
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
```



### 其他配置

1. 图片适配：项目根目录下创建 assets/images/2.0x  &  assets/images/3.0x 路径，将不同倍图以同一命名分别放入 /images/、/images/2.0x/、/images/3.0x/ 路径下，然后在 pubspec.yaml 中 flutter: assets: 添加  - assets/images/
2. Android 启动页：放置启动页图片到Android 路径 res 中相对应的 drawable 文件夹下，在 res/drawable/launch_background.xml 中，bitmap 标签的 src 修改为启动页图片名

### 附上地址 [flutter_mvp](https://github.com/zhaoZhao0213/flutter_mvp.git)