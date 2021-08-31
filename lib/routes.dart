
import 'package:blog_author/pages/login/login_binding.dart';
import 'package:blog_author/pages/login/login_view.dart';
import 'package:get/get.dart';

import 'pages/home/home_binding.dart';
import 'pages/home/home_view.dart';

class RouteConfig {
  static const String login = "/login";
  static const String home = "/home";

  static final List<GetPage> getPages = [
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}
