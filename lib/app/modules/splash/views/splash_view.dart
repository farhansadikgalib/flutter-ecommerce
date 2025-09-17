import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:ousadbazar/generated/assets.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.initializeApp();
    return Scaffold(
      body: Center(
        child: AnimationConfiguration.synchronized(
          duration: const Duration(milliseconds: 2100),
          child: FadeInAnimation(
            child: ScaleAnimation(
              child: AnyImageView(
                imagePath: Assets.pngLogo,
                height: 125,
                width: Get.width * 0.6,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
