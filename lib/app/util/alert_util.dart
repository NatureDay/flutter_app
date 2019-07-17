import 'package:flutter/material.dart';

import 'package:toast/toast.dart';

class AlertUtil {

  /// toast提示
  static void showToast(BuildContext context, String msg) {
    Toast.show(msg, context, duration: 2);
  }

}
