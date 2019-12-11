import 'package:event_bus/event_bus.dart';

/**
 * 统一响应
 */

class ApiResult<T> {
  static const ERROR_CODE = 100;
  static const OK_CODE = 0;

  int code;

  String message;

  var data;

  ApiResult({this.code, this.message, this.data});

//  ApiResult.fromJson(Map<String, dynamic> json){
//    code = json['code'];
//    msg = json['msg'];
//    data = Account.fromJson(json['data']);
//  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map['code'] = this.code;
    map['msg'] = this.message;
    map['data'] = this.data;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

///网络请求错误编码
class Code {
  ///网络错误
  static const NETWORK_ERROR = 300;
  static const NETWORK_ERROR_DATA = '网络错误';

  ///网络超时
  static const NETWORK_TIMEOUT = NETWORK_ERROR + 1;
  static const NETWORK_TIMEOUT_DATA = '网络超时';

  ///网络返回数据格式化异常
  static const NETWORK_JSON_EXCEPTION = NETWORK_ERROR + 2;
  static const NETWORK_JSON_EXCEPTION_DATA = '网络返回数据格式化异常';

  ///网络请求错误
  static const NETWORK_REQUEST_ERROR = NETWORK_ERROR + 3;
  static const NETWORK_REQUEST_ERROR_DATA = '网络请求错误';

  static final EventBus eventBus = new EventBus();

//  static errorHandleFunction(code, message, noTip) {
//    if(noTip) {
//      return message;
//    }
//    eventBus.fire(new HttpErrorEvent(code, message));
//    return message;
//  }
}

class LoginInfo {
  Map<String, dynamic> userClass;
  String token;

  LoginInfo({this.userClass, this.token});

  factory LoginInfo.fromJson(Map<String, dynamic> json) {
    return LoginInfo(
      userClass: json['userClass'] != null ? json['userClass'] : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userClass != null) {
      data['userClass'] = this.userClass;
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Child{
  int childId;

  String childName;

  String childAvatar;

  String childPhone;

  Child({this.childId, this.childName, this.childAvatar, this.childPhone});

  factory Child.fromJson(Map<String, dynamic> json){
    return Child(
      childId: json['childId'] != null ? json['childId'] : null,
      childName: json['childName'] != null ? json['childName'] : null,
      childAvatar: json['childAvatar'] != null ? json['childAvatar'] : null,
      childPhone: json['childPhone'] != null ? json['childPhone'] : null,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = Map();
    map['childId'] = this.childId;
    map['childName'] = this.childName;
    map['childAvatar'] = this.childAvatar;
    map['childPhone'] = this.childPhone;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Older {
  int olderId;

  String olderName;

  String olderPhone;

  String olderAvatar;

  int olderAge;

  int olderGender;

  String olderRegtime;

  String ocRelation;

  List<Signs> signsList;


  Older({this.olderId, this.olderName, this.olderPhone, this.olderAvatar,
      this.olderAge, this.olderGender, this.olderRegtime, this.ocRelation, this.signsList});



  factory Older.fromJson(Map<String,dynamic> json){

    var signsListJson = json['signsList'] as List;
    List<Signs> signsArr = signsListJson.map((i) => Signs.fromJson(i)).toList();


    return Older(
      olderId: json['olderId'],
      olderName: json['olderName'],
      olderPhone: json['olderPhone'],
      olderAvatar: json['olderAvatar'],
      olderAge: json['olderAge'],
      olderGender: json['olderGender'],
      olderRegtime: json['olderRegtime'],
      ocRelation: json['ocRelation'],
      signsList: signsArr,
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> map = Map();
    map['olderId'] = this.olderId;
    map['olderName'] = this.olderName;
    map['olderPhone'] = this.olderPhone;
    map['olderAvatar'] = this.olderAvatar;
    map['olderAge'] = this.olderAge;
    map['olderGender'] = this.olderGender;
    map['olderRegtime'] = this.olderRegtime;
    map['ocRelation'] = this.ocRelation;
    return map;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Signs {
    String signGentime;
    int signId;
    String signOlderPhone;
    int signType;
    int signValue;

    Signs({this.signGentime, this.signId, this.signOlderPhone, this.signType, this.signValue});

    factory Signs.fromJson(Map<String, dynamic> json) {
        return Signs(
            signGentime: json['signGentime'],
            signId: json['signId'],
            signOlderPhone: json['signOlderPhone'],
            signType: json['signType'],
            signValue: json['signValue'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['signGentime'] = this.signGentime;
        data['signId'] = this.signId;
        data['signOlderPhone'] = this.signOlderPhone;
        data['signType'] = this.signType;
        data['signValue'] = this.signValue;
        return data;
    }
}

class Message {
    String msgChildPhone;
    String msgContent;
    int msgId;
    int msgIsRead;
    String msgSendTime;
    String msgTitle;
    int msgType;

    Message({this.msgChildPhone, this.msgContent, this.msgId, this.msgIsRead, this.msgSendTime, this.msgTitle, this.msgType});

    factory Message.fromJson(Map<String, dynamic> json) {
        return Message(
            msgChildPhone: json['msgChildPhone'],
            msgContent: json['msgContent'],
            msgId: json['msgId'],
            msgIsRead: json['msgIsRead'],
            msgSendTime: json['msgSendTime'],
            msgTitle: json['msgTitle'],
            msgType: json['msgType'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['msgChildPhone'] = this.msgChildPhone;
        data['msgContent'] = this.msgContent;
        data['msgId'] = this.msgId;
        data['msgIsRead'] = this.msgIsRead;
        data['msgSendTime'] = this.msgSendTime;
        data['msgTitle'] = this.msgTitle;
        data['msgType'] = this.msgType;
        return data;
    }
}
