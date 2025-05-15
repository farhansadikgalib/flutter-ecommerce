import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:turi/app/core/style/app_colors.dart';

Widget commonTextField({
  required String labelText,
  required IconData icon,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
}) {
  return SizedBox(
    height: 40.h,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.primaryColor,
      cursorHeight: 15.h,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h), // Adjust padding
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