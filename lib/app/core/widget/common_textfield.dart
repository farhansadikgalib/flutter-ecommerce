import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turi/app/core/style/app_colors.dart';

Widget commonTextField({
  required String labelText,
  required IconData icon,
  TextInputType keyboardType = TextInputType.text,
}) {
  return SizedBox(
    height: 40.h,
    child: TextFormField(
      keyboardType: keyboardType,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIconColor: AppColors.primaryColor,
        floatingLabelStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14.sp,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width:2,color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width:1,color: AppColors.primaryColor),
        ),
        prefixIcon: Icon(icon),
      ),
    ),
  );
}