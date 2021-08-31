import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'lang/localization_service.dart';
import 'routes.dart';

void main(){
  runApp(BlogAuthorApp());
}
class BlogAuthorApp  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.login,
      getPages: RouteConfig.getPages,
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }

}