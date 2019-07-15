import 'package:dio/dio.dart';
import 'package:flutter_app/app/config.dart';

import 'package:flutter_app/app/app.dart';

class ApiResponse<T> {
  int code;
  T data;
  String message;

  ApiResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];

  @override
  String toString() {
    return 'code: $code ,message: $message,data:$data';
  }
}

/**
 * http请求封装类
 */
class HttpUtil {
  static final int _TIMEOUT_CONNECT = 30 * 1000;
  static final int _TIMEOUT_RECEIVE = 60 * 1000;

  static final String GET = "get";
  static final String POST = "post";

  static HttpUtil _httpUtil;

  Dio _dio;

  static HttpUtil get instance {
    return getInstance();
  }

  static HttpUtil getInstance() {
    if (_httpUtil == null) {
      _httpUtil = new HttpUtil();
    }
    return _httpUtil;
  }

  HttpUtil() {
    _dio = new Dio(_initOpions());
    _dio.interceptors.add(new TokenInterceptor());
  }

  BaseOptions _initOpions() {
    return new BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: _TIMEOUT_CONNECT,
      receiveTimeout: _TIMEOUT_RECEIVE,
    );
  }

  Future<Response<ApiResponse<T>>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
  }) async {
    return _request(
      path,
      method: GET,
      queryParameters: queryParameters,
    );
  }

  Future<Response<ApiResponse<T>>> post<T>(
    String path, {
    data,
    Map<String, dynamic> queryParameters,
  }) async {
    return _request(
      path,
      method: POST,
      data: data,
      queryParameters: queryParameters,
    );
  }

  Future<Response<ApiResponse<T>>> _request<T>(
    String path, {
    String method,
    data,
    Map<String, dynamic> queryParameters,
  }) async {
    method = method ?? GET;
    Options options = new Options(method: method);
    Response<ApiResponse<T>> response = await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    return response;
  }
}

/*
 TokenInterceptor 拦截请求，添加token
 */
class TokenInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    print('----------options.uri==========' + options.uri.toString());
    if (options.uri.toString().contains("auth/oauth/token"))
      return super.onRequest(options);
    Map<String, dynamic> newHeaders = options.headers ?? new Map();
    newHeaders['token'] = AppInfoHelper.instance.getAppToken();
    options.headers = newHeaders;
    return super.onRequest(options);
  }

  @override
  onError(DioError err) {
    return super.onError(err);
  }

  @override
  onResponse(Response response) {
    return super.onResponse(response);
  }
}
