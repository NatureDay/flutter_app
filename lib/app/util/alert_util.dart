import 'package:fluttertoast/fluttertoast.dart';

class AlertUtil {

  /// toast提示
  static void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT);
  }

}
