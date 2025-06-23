import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../style/app_colors.dart';

AppBar globalAppBar(
  BuildContext context,
  String appbarTitle, {
  bool showBackButton = true,
}) {
  return AppBar(
    elevation: 0.5,
    titleSpacing: showBackButton? -10:10,
    backgroundColor: AppColors.white,
    leading:
        showBackButton
            ? InkWell(
              onTap: () => Get.back(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryColor,
              ),
            )
            : null,
    title: InkWell(
      onTap: showBackButton ? () => Get.back() : null,
      child: Text(
        appbarTitle,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColor,
        ),
      ),
    ),
    centerTitle: false,
  );
}
