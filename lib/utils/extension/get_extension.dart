import 'package:get/get.dart';
import 'package:blog_author/widgets/loading_dialog.dart';

extension GetExtension on GetInterface {
  dismiss() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  loading() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
    Get.dialog(LoadingDialog());
  }
}
