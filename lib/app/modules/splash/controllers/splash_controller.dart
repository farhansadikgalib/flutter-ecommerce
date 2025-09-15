import 'package:get/get.dart';
import 'package:ousadbazar/app/core/helper/app_helper.dart';
import 'package:ousadbazar/app/core/helper/auth_helper.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  Future<void> initializeApp() async {
    AuthHelper().loadItems();
    await Future.delayed(2500.milliseconds).then((value) async {
      Get.offNamed(Routes.DASHBOARD);
    });
  }
}
