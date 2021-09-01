import 'package:blog_author/data/models/log_bean.dart';
import 'package:blog_author/data/repositories/login_repository.dart';
import 'package:blog_author/routes.dart';
import 'package:blog_author/utils/http/app_exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:blog_author/utils/extension/get_extension.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {
  final state = LoginState();
  final LoginRepository repository = Get.find<LoginRepository>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void onUsernameChanged(String username) {
    state.username = username.trim();
  }

  void onPasswordChanged(String password) {
    state.password = password.trim();
  }

  void login() async{

    if (state.username == null || state.username!.trim.toString().isEmpty) {
      Get.snackbar('Hi'.tr, 'Your Username not be null'.tr);
      return;
    }

    if (state.password == null || state.password!.trim.toString().isEmpty) {
      Get.snackbar('Hi'.tr, 'Your Password not be null'.tr);
      return;
    }
    Get.loading();
    try {
      LoginBean bean = await repository.login(state.username!, state.password!);
      Get.dismiss();
      // LocalLoginModelRepository.saveLoginModel(bean);
      Get.offAllNamed(RouteConfig.home);
    } on HttpException catch (e) {
      Get.dismiss();
      Get.snackbar('Error', e.message);
    } on Exception catch(e) {
      Get.snackbar('Error', "登录失败");
    }
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
