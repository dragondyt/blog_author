import 'package:blog_author/pages/home/home_view.dart';
import 'package:blog_author/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'login_state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login() {
    Get.offNamed(RouteConfig.home);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
