import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {

  initializeApp() async {
    await Future.delayed(2500.milliseconds).then((value) async {
          Get.offNamed(
            Routes.HOME,
          );

    });
  }
}
