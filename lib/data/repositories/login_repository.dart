import 'package:blog_author/data/api/login_api.dart';
import 'package:blog_author/data/models/log_bean.dart';
import 'package:get/get.dart';

class LoginRepository {
  final LoginApi api = Get.find<LoginApi>();

  Future<LoginBean> login(String username, String password) {
    return api.login(username, password);
  }

  Future<LoginBean> register(
      String username, String password, String repassword) {
    return api.register(username, password, repassword);
  }
}