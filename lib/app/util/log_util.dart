import 'package:flutter_app/app/config.dart';

class LogUtil {
  static final bool debug = AppConfig.DEBUG;

  static i(Object object) {
    print(object);
  }

  static e(Object object) {
    print(object);
  }
}
