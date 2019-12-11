import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mvp/constants/constants.dart';

class SpUtil {
  static Future<SharedPreferences> getSpInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static setToken(String token) {
    getSpInstance().then((sharedPreferences) {
      setString(SPKey.TOKEN, token);
    });
  }

  static Future<String> getToken(){
    return getSpInstance().then((sharedPreferences) => getString(SPKey.TOKEN));
  }

  static removeToken(){
    return remove(SPKey.TOKEN);
  }

  /**
   * 根据 key 移除
   */
  static Future remove(String key){
    return getSpInstance().then((sharedPreferences) => sharedPreferences.remove(key));
  }

  /**
   * 清除所有
   */
  static Future clear(){
    return getSpInstance().then((sharedPreferences) => sharedPreferences.clear());
  }

  /**
   * 是否包含
   */
  static Future<bool> contain(String key){
    return getSpInstance().then((sharedPreferences) => sharedPreferences.containsKey(key));
  }

  static setString(String key, String value) {
    getSpInstance().then((sharedPreferences) {
      sharedPreferences.setString(key, value);
    });
  }

  static Future<String> getString(String key){
    return getSpInstance().then((sharedPreferences) => sharedPreferences.getString(key));
  }



  static setInt(String key, int value) {
    getSpInstance().then((sharedPreferences) {
      sharedPreferences.setInt(key, value);
    });
  }

  static Future<int> getInt(String key){
    return getSpInstance().then((sharedPreferences) => sharedPreferences.getInt(key));
  }
}
