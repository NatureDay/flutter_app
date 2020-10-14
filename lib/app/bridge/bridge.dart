import 'package:flutter/services.dart';

/// 全局通用method channel
class BridgeMethodChannel {
  static final String _BRIDGE_METHOD_CHANNEL_DEFAULT =
      "_BRIDGE_METHOD_CHANNEL_DEFAULT";

  static BridgeMethodChannel _instance;

  MethodChannel _methodChannel;

  static BridgeMethodChannel _getInstance() {
    if (_instance == null) {
      _instance = new BridgeMethodChannel._();
      _instance._init();
    }
    return _instance;
  }

  static BridgeMethodChannel get instance {
    return _getInstance();
  }

  BridgeMethodChannel._();

  void _init() {
    _methodChannel = new MethodChannel(_BRIDGE_METHOD_CHANNEL_DEFAULT);
  }

  MethodChannel getChannel() {
    return _methodChannel;
  }
}
