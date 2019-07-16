import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/app/config.dart';
import 'package:flutter_app/app/app.dart';
import 'package:flutter_app/app/util/log_util.dart';

class ApiResponse<T> {
  int code;
  T data;
  String message;

  ApiResponse(this.code, this.data, this.message);

  ApiResponse.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        data = json['data'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = new Map();
    result['code'] = this.code;
    result['message'] = this.message;
    result['data'] = this.data;
    return result;
  }

  @override
  String toString() {
    return 'code: $code ,message: $message,data:$data';
  }
}

/**
 * http请求封装类
 */
class HttpUtil {
  static final ContentType _FORM =
      ContentType.parse("application/x-www-form-urlencoded");

  static final String _AUTHORIZATION = "Authorization";

  static final String _PATH = "auth/oauth/token";
  static final String _INIT_TOKEN = "Basic cWlhbm1vOnFpYW5tbw==";

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
    _dio.interceptors.add(new LogInterceptor());
  }

  BaseOptions _initOpions() {
    return new BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: _TIMEOUT_CONNECT,
      receiveTimeout: _TIMEOUT_RECEIVE,
    );
  }

  Future<T> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
  }) async {
    return _request(
      path,
      method: GET,
      queryParameters: queryParameters,
    );
  }

  Future<T> post<T>(
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

  Future<T> _request<T>(
    String path, {
    String method,
    data,
    Map<String, dynamic> queryParameters,
  }) async {
    method = method ?? GET;
    Options options = new Options(
        method: method,
        contentType: method == GET ? _FORM : ContentType.json,
        responseType: ResponseType.plain);
    Response response = await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
    LogUtil.i("------http result: $response");
    if (response.statusCode == 200) {
      ApiResponse<T> apiResponse =
          ApiResponse.fromJson(json.decode(response.data));
      if (apiResponse.code == 0) {
        return apiResponse.data;
      } else {
        throw ResultErrorException(apiResponse.message);
      }
    }
    return null;
  }
}

/*
 TokenInterceptor 拦截请求，添加token
 */
class TokenInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) {
    if (options.uri.toString().contains(HttpUtil._PATH)) {
      Map<String, dynamic> newHeaders = options.headers ?? new Map();
      newHeaders[HttpUtil._AUTHORIZATION] = HttpUtil._INIT_TOKEN;
      options.headers = newHeaders;
      return super.onRequest(options);
    }
    Map<String, dynamic> newHeaders = options.headers ?? new Map();
    newHeaders[HttpUtil._AUTHORIZATION] = AppInfoHelper.instance.getAppToken();
    options.headers = newHeaders;
    return super.onRequest(options);
  }
}

/// 请求结果异常 exception
class ResultErrorException implements Exception {
  final String message;

  ResultErrorException(this.message);

  @override
  String toString() {
    return 'ResultErrorException{message: $message}';
  }
}
