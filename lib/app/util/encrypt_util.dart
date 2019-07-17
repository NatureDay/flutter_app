import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_app/app/util/log_util.dart';
import 'package:pointycastle/export.dart';

/// 加密工具类
class EncryptUtil {
  static String sha512(String string) {
    return sha(string, "sha-512");
  }

  static String sha(String string, String alg) {
    try {
      Digest digest;
      if (alg == "sha-512") {
        digest = new SHA512Digest();
      }
      List<int> utf8List = utf8.encode(string);
      Uint8List result = digest.process(Uint8List.fromList(utf8List));
      LogUtil.i(result);
      return utf8.decode(result, allowMalformed: true);
    } catch (e) {
      print(e);
    }
  }
}
