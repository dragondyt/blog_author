import 'package:blog_author/data/api/login_api.dart';
import 'package:blog_author/data/repositories/login_repository.dart';
import 'package:get/get.dart';

import 'login_logic.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginLogic());
    Get.lazyPut(() => LoginRepository());
    Get.lazyPut(() => LoginApi());
  }
}
