import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {

  AppSharedPreference._();

  static AppSharedPreference instance = AppSharedPreference._();

  /// 문제점1: preference 값이 증가할 경우, key값이 중복될 여지가 존재한다.
  /// → 상수를 선언하여 활용한다.
  /// 문제점2: 매번 값이 preference가 생성될 때마다 setter와 getter를 생성하여 불필요한 코드가 중복 생성된다.
  /// → app_preferences.dart를 참고하여, prefs.dart에 선언하면, 활용하기 편리해진다.
  static const keyCount = 'keyCount';
  static const keyLaunchCount = 'keyLaunchCount';

  late SharedPreferences _preferences;

  static init() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  static void setCount(int count) {
    instance._preferences.setInt(keyCount, count);
  }

  /// null일 경우에는 0 디폴트값 반환
  static int getCount(){
    return instance._preferences.getInt(keyCount) ?? 0;
  }

  static void setLaunchCount(int count) {
    instance._preferences.setInt(keyCount, count);
  }

  /// null일 경우에는 0 디폴트값 반환
  static int getLaunchCount(){
    return instance._preferences.getInt(keyCount) ?? 0;
  }
}