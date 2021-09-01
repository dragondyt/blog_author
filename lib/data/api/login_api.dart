/*
 * @Author: your name
 * @Date: 2020-12-08 20:57:12
 * @LastEditTime: 2020-12-13 01:21:11
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /todo/lib/data/api/login_api.dart
 */
import 'package:blog_author/data/models/log_bean.dart';
import 'package:blog_author/utils/http/app_response.dart';
import 'package:blog_author/utils/http/dio_client.dart';
import 'package:get/get.dart';

class LoginApi {
  final String _login = '/user/login';
  final String _register = '/user/register';
  final HttpClient _dio = Get.find<HttpClient>();

  Future<LoginBean> login(String username, String password) async {
    HttpResponse appResponse = await _dio.post(_login, queryParameters: {
      "username": username,
      "password": password,
    });
    if (appResponse.ok) {
      return LoginBean.fromJson(appResponse.data);
    } else {
      throw appResponse.error!;
    }
  }

  Future<LoginBean> register(
      String username, String password, String repassword) async {
    HttpResponse appResponse = await _dio.post(_register, queryParameters: {
      "username": username,
      "password": password,
      "repassword": password
    });
    if (appResponse.ok) {
      return LoginBean.fromJson(appResponse.data);
    } else {
      throw appResponse.error!;
    }
  }
}
