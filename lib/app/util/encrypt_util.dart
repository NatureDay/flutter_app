import 'dart:convert';

import 'package:flutter_app/app/util/log_util.dart';

/// 加密工具类
class EncryptUtil {
  static String sha512(String string) {
    return sha(string, "sha-512");
  }

  static String sha(String string, String alg) {
    LogUtil.i("-----sha---111: " + utf8.encode(string).toString());

//    try {
//      Digest digest;
//      if (alg == "sha-512") {
//        digest = new SHA512Digest();
//      }
//      LogUtil.i("-----sha---111: " + utf8.encode(string).toString());
//      LogUtil.i(
//          "-----sha---222: " + digest.process(utf8.encode(string)).toString());
//      LogUtil.i("-----sha---333: " +
//          utf8.decode(digest.process(utf8.encode(string))));
//      return utf8.decode(digest.process(utf8.encode(string)));
//    } catch (e) {
//      print(e);
//    }
    return null;
  }
}
