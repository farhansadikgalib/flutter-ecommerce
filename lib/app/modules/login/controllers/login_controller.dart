import 'package:flutter/material.dart';
    import 'package:get/get.dart';

    class LoginController extends GetxController {
      final emailController = TextEditingController();
      final passwordController = TextEditingController();

      final isPasswordHidden = true.obs;
      final isLoading = false.obs;

      final emailError = ''.obs;
      final passwordError = ''.obs;

      @override
      void onClose() {
        emailController.dispose();
        passwordController.dispose();
        super.onClose();
      }

      void togglePasswordVisibility() {
        isPasswordHidden.value = !isPasswordHidden.value;
      }

      void validateEmail(String value) {
        if (value.isEmpty) {
          emailError.value = 'Email is required';
        } else if (!GetUtils.isEmail(value)) {
          emailError.value = 'Enter a valid email';
        } else {
          emailError.value = '';
        }
      }

      void validatePassword(String value) {
        if (value.isEmpty) {
          passwordError.value = 'Password is required';
        } else if (value.length < 6) {
          passwordError.value = 'Password must be at least 6 characters';
        } else {
          passwordError.value = '';
        }
      }

      void login() {
        validateEmail(emailController.text);
        validatePassword(passwordController.text);

        if (emailError.value.isEmpty && passwordError.value.isEmpty) {
          isLoading.value = true;

          // TODO: Implement your login logic here
          // Example: Call your authentication service

          Future.delayed(const Duration(seconds: 2), () {
            isLoading.value = false;
            // Navigate to home or show error
          });
        }
      }

      void forgotPassword() {
        // TODO: Navigate to forgot password screen
        // Get.toNamed(Routes.FORGOT_PASSWORD);
      }

      void goToSignUp() {
        // TODO: Navigate to sign up screen
        // Get.toNamed(Routes.SIGNUP);
      }
    }