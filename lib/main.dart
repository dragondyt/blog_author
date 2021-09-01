import 'package:blog_author/themes/theme_service.dart';
import 'package:blog_author/utils/http/dio_client.dart';
import 'package:blog_author/utils/http/dio_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'lang/localization_service.dart';
import 'pages/unknown/unknown_view.dart';
import 'routes.dart';
import 'themes/theme_data.dart';

void main() async {
  HttpConfig dioConfig =
  HttpConfig(baseUrl: "https://gank.io/", proxy: "192.168.2.249:8888");
  HttpClient client = HttpClient(dioConfig: dioConfig);
  Get.put<HttpClient>(client);
  await GetStorage.init(); // add this
  runApp(BlogAuthorApp());
}

class BlogAuthorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        unknownRoute: GetPage(name: '/notfound', page: () => UnknownPage()),
        initialRoute: RouteConfig.login,
        getPages: RouteConfig.getPages,
        locale: LocalizationService.locale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        theme: Themes.lightThemeData,
        darkTheme: Themes.darkThemeData,
        themeMode: ThemeService().theme);
  }
}
