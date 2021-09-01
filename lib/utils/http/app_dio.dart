
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/adapter_browser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'app_exceptions.dart';
import 'app_response.dart';
import 'dio_config.dart';
import 'http_transformer.dart';

class AppDio with DioMixin implements Dio {
  AppDio({BaseOptions? options, HttpConfig? dioConfig}) {
    options ??= BaseOptions(
      baseUrl: dioConfig?.baseUrl ?? "",
      contentType: 'application/json',
      connectTimeout: dioConfig?.connectTimeout,
      sendTimeout: dioConfig?.sendTimeout,
      receiveTimeout: dioConfig?.receiveTimeout,
    );
    this.options = options;

    // // DioCacheManager
    // final cacheOptions = CacheOptions(
    //   // A default store is required for interceptor.
    //   store: MemCacheStore(),
    //   // Optional. Returns a cached response on error but for statuses 401 & 403.
    //   hitCacheOnErrorExcept: [401, 403],
    //   // Optional. Overrides any HTTP directive to delete entry past this duration.
    //   maxStale: const Duration(days: 7),
    // );
    // interceptors.add(DioCacheInterceptor(options: cacheOptions));
    // // Cookie管理
    // if (dioConfig?.cookiesPath?.isNotEmpty ?? false) {
    //   interceptors.add(CookieManager(
    //       PersistCookieJar(storage: FileStorage(dioConfig!.cookiesPath))));
    // }

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    if (dioConfig?.interceptors?.isNotEmpty ?? false) {
      interceptors.addAll(interceptors);
    }
    if(kIsWeb){
      httpClientAdapter = BrowserHttpClientAdapter();
    }else {
      httpClientAdapter = DefaultHttpClientAdapter();
      if (dioConfig?.proxy?.isNotEmpty ?? false) {
        setProxy(dioConfig!.proxy!);
      }
    }
  }

  setProxy(String proxy) {
    (httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      // config the http client
      client.findProxy = (uri) {
        // proxy all request to localhost:8888
        return "PROXY $proxy";
      };
      // you can also create a HttpClient to dio
      // return HttpClient();
    };
  }
}
HttpResponse handleResponse(Response? response,
    {HttpTransformer? httpTransformer}) {
  httpTransformer ??= DefaultHttpTransformer.getInstance();

  // 返回值异常
  if (response == null) {
    return HttpResponse.failureFromError();
  }

  // token失效
  if (_isTokenTimeout(response.statusCode)) {
    return HttpResponse.failureFromError(
        UnauthorisedException(message: "没有权限", code: response.statusCode));
  }
  // 接口调用成功
  if (_isRequestSuccess(response.statusCode)) {
    return httpTransformer.parse(response);
  } else {
    // 接口调用失败
    return HttpResponse.failure(
        errorMsg: response.statusMessage, errorCode: response.statusCode);
  }
}

HttpResponse handleException(Exception exception) {
  var parseException = _parseException(exception);
  return HttpResponse.failureFromError(parseException);
}

/// 鉴权失败
bool _isTokenTimeout(int? code) {
  return code == 401;
}

/// 请求成功
bool _isRequestSuccess(int? statusCode) {
  return (statusCode != null && statusCode >= 200 && statusCode < 300);
}

HttpException _parseException(Exception error) {
  if (error is DioError) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        return NetworkException(message: error.error.message);
      case DioErrorType.cancel:
        return CancelException(error.error.message);
      case DioErrorType.response:
        try {
          int? errCode = error.response?.statusCode;
          switch (errCode) {
            case 400:
              return BadRequestException(message: "请求语法错误", code: errCode);
            case 401:
              return UnauthorisedException(message: "没有权限", code: errCode);
            case 403:
              return BadRequestException(message: "服务器拒绝执行", code: errCode);
            case 404:
              return BadRequestException(message: "无法连接服务器", code: errCode);
            case 405:
              return BadRequestException(message: "请求方法被禁止", code: errCode);
            case 500:
              return BadServiceException(message: "服务器内部错误", code: errCode);
            case 502:
              return BadServiceException(message: "无效的请求", code: errCode);
            case 503:
              return BadServiceException(message: "服务器挂了", code: errCode);
            case 505:
              return UnauthorisedException(
                  message: "不支持HTTP协议请求", code: errCode);
            default:
              return UnknownException(error.error.message);
          }
        } on Exception catch (_) {
          return UnknownException(error.error.message);
        }

      case DioErrorType.other:
        if (error.error is SocketException) {
          return NetworkException(message: error.message);
        } else {
          return UnknownException(error.message);
        }
      default:
        return UnknownException(error.message);
    }
  } else {
    return UnknownException(error.toString());
  }
}
