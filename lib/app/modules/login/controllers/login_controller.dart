import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:turi/app/routes/app_pages.dart';

import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/auth_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/remote/repository/auth/auth_repository.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;
  final RxBool isSignUpMode = false.obs;
  final RxBool isForgotPasswordMode = false.obs;
  final RxBool isVerificationMode = false.obs;

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString nameError = ''.obs;
  final RxString pinCode = ''.obs;

  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.primaryColor,
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(232, 235, 241, 0.37),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.primaryColor),
    ),
  );

  @override
  void onInit() {
    super.onInit();
    if (kDebugMode) {
      nameController.text = 'coheraw';
      emailController.text = 'rifat@gmail.com';
      passwordController.text = '12345678';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    pinController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void goToSignUp() {
    isSignUpMode.value = true;
  }

  void toggleAuthMode() {
    isSignUpMode.value = !isSignUpMode.value;
    emailError.value = '';
    passwordError.value = '';
    nameError.value = '';
  }

  void enterVerificationMode() {
    isVerificationMode.value = true;
    pinController.clear();
    pinCode.value = '';
  }

  void backFromVerification() {
    isVerificationMode.value = false;
    pinController.clear();
    pinCode.value = '';
  }

  void toggleForgotPasswordMode() {
    isForgotPasswordMode.value = !isForgotPasswordMode.value;
    if (isForgotPasswordMode.value) {
      // Clear fields when entering forgot password mode
      passwordController.clear();
      nameController.clear();
      passwordError.value = '';
      nameError.value = '';
    }
    emailError.value = '';
  }

  void validateEmail(String value) {
    // Email validation logic
    emailError.value = '';
    if (value.isEmpty) {
      emailError.value = 'Email is required';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Enter a valid email';
    }
  }

  void validatePassword(String value) {
    // Password validation logic
    passwordError.value = '';
    if (value.isEmpty) {
      passwordError.value = 'Password is required';
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    }
  }

  void validateName(String value) {
    // Name validation logic
    nameError.value = '';
    if (value.isEmpty) {
      nameError.value = 'Name is required';
    }
  }

  void login() async {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (emailError.value.isEmpty && passwordError.value.isEmpty) {
      final response = await AuthRepository().login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.status == 'success') {
        AuthHelper().setUserData(response);
        AuthHelper().loadItems();
        Get.offAllNamed(Routes.DASHBOARD);
        AppWidgets().getSnackBar(message: response.message);
      } else {
        AppWidgets().getSnackBar(message: response.message);
      }
    }
  }

  void signUp() async {
    validateName(nameController.text);
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if (nameError.value.isEmpty &&
        emailError.value.isEmpty &&
        passwordError.value.isEmpty) {
      final response = await AuthRepository().signup(
        nameController.text,
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (response.status == 200) {
        enterVerificationMode();
        AppWidgets().getSnackBar(message: response.message);
      } else {
        AppWidgets().getSnackBar(message: response.message);
      }
    }
  }

  void resetPassword() async {
    validateEmail(emailController.text);

    if (emailError.value.isEmpty) {
      final response = await AuthRepository().forgetPassword(
        emailController.text.trim(),
      );

      if (response.status == 200) {
        enterVerificationMode();
        AppWidgets().getSnackBar(message: response.message);
      } else {
        AppWidgets().getSnackBar(message: response.message);
      }
    }
  }

  void verifyCode() async {
    if (isForgotPasswordMode.value) {
      var response = await AuthRepository().updatePassword(
        pinController.value.text,
        emailController.value.text,
        passwordController.value.text,
      );

      if (response.status == 200) {
        AppWidgets().getSnackBar(message: response.message);
        isForgotPasswordMode.value = false;
        isVerificationMode.value = false;
      } else {
        AppWidgets().getSnackBar(message: response.message);
      }

      // Reset states and go back to login
    } else {
      // Sign up verification

      var response = await AuthRepository().verifyOTP(
        emailController.value.text,
        pinController.value.text,
      );

      if (response.status == 200) {
        AppWidgets().getSnackBar(message: response.message);
        isSignUpMode.value = false;
        isVerificationMode.value = false;
      } else {
        AppWidgets().getSnackBar(message: response.message);
      }

      // Reset states and go back to login
    }
  }

  void resendCode() {
    if (isForgotPasswordMode.value) {
      resetPassword();
    } else {
      signUp();
    }
  }
}
