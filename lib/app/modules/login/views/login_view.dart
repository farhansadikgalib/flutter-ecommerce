import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../../generated/assets.dart';
import '../../../core/style/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.h),

                    // Logo with animation
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: controller.isSignUpMode.value ? 100.h : 120.h,
                        child: Image.asset(Assets.pngLogo),
                      ),
                    ),

                    // Title with animation
                    SizedBox(height: 10.h),

                    // Verification message
                    Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: controller.isVerificationMode.value ? 50.h : 0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity:
                              controller.isVerificationMode.value ? 1.0 : 0.0,
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "Enter the verification code sent to\n",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(
                                    text: controller.emailController.text,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // PIN Input - only in verification mode
                    Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: controller.isVerificationMode.value
                            ?!controller.isForgotPasswordMode
                            .value?65.h: 125.h : 0,
                        child: AnimatedOpacity(
                          opacity:
                              controller.isVerificationMode.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              Center(
                                child: Pinput(
                                  length: 4,
                                  controller: controller.pinController,
                                  defaultPinTheme: controller.defaultPinTheme,
                                  hapticFeedbackType:
                                  HapticFeedbackType.lightImpact,
                                  cursor: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 9),
                                        width: 22,
                                        height: 1,
                                        color: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                controller.isForgotPasswordMode.value
                                    ? 60.h
                                    :0,
                                child: AnimatedOpacity(
                                  opacity:controller.isForgotPasswordMode
                                      .value?1:0,
                                  duration: const Duration(milliseconds: 500),
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                    controller.isPasswordHidden.value,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Enter your new password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed:
                                            () =>
                                            controller
                                                .togglePasswordVisibility(),
                                      ),
                                      errorText:
                                      controller.passwordError.value.isEmpty
                                          ? null
                                          : controller.passwordError.value,
                                    ),
                                    onChanged:
                                        (value) =>
                                        controller.validatePassword(value),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    ),

                    // Form fields - hidden in verification mode
                    Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height:
                            controller.isVerificationMode.value
                                ? 0
                                : controller.isForgotPasswordMode.value
                                ? 80.h
                                : (controller.isSignUpMode.value
                                    ? 240.h
                                    : 175.h),
                        child: AnimatedOpacity(
                          opacity:
                              controller.isVerificationMode.value ? 0.0 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Column(
                            children: [
                              // Name Field with animation - only in signup mode
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    controller.isSignUpMode.value &&
                                            !controller
                                                .isForgotPasswordMode
                                                .value
                                        ? 60.h
                                        : 0,
                                child: AnimatedOpacity(
                                  opacity:
                                      controller.isSignUpMode.value &&
                                              !controller
                                                  .isForgotPasswordMode
                                                  .value
                                          ? 1.0
                                          : 0.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: TextField(
                                    controller: controller.nameController,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      hintText: "Enter your name",
                                      prefixIcon: const Icon(
                                        Icons.person_outline,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorText:
                                          controller.nameError.value.isEmpty
                                              ? null
                                              : controller.nameError.value,
                                    ),
                                    onChanged:
                                        (value) =>
                                            controller.validateName(value),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height:
                                    controller.isSignUpMode.value &&
                                            !controller
                                                .isForgotPasswordMode
                                                .value
                                        ? 16.h
                                        : 0,
                              ),

                              // Email Field - always visible except in verification mode
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height: 60.h,
                                child: TextField(
                                  controller: controller.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "Enter your email",
                                    prefixIcon: const Icon(
                                      Icons.email_outlined,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorText:
                                        controller.emailError.value.isEmpty
                                            ? null
                                            : controller.emailError.value,
                                  ),
                                  onChanged:
                                      (value) =>
                                          controller.validateEmail(value),
                                ),
                              ),

                              SizedBox(
                                height:
                                    controller.isForgotPasswordMode.value
                                        ? 0.h
                                        : 16.h,
                              ),

                              // Password Field - not visible in forgot password mode
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    controller.isVerificationMode.value
                                        ? 60.h
                                        : controller.isForgotPasswordMode.value
                                        ? 0
                                        : 60.h,
                                child: AnimatedOpacity(
                                  opacity:
                                      controller.isForgotPasswordMode.value
                                          ? 0.0
                                          : 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: TextField(
                                    controller: controller.passwordController,
                                    obscureText:
                                        controller.isPasswordHidden.value,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      hintText: "Enter your password",
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onPressed:
                                            () =>
                                                controller
                                                    .togglePasswordVisibility(),
                                      ),
                                      errorText:
                                          controller.passwordError.value.isEmpty
                                              ? null
                                              : controller.passwordError.value,
                                    ),
                                    onChanged:
                                        (value) =>
                                            controller.validatePassword(value),
                                  ),
                                ),
                              ),

                              // Forgot Password link (only in login mode)
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                height:
                                    (!controller.isSignUpMode.value &&
                                            !controller
                                                .isForgotPasswordMode
                                                .value)
                                        ? 35.h
                                        : 0,
                                child: AnimatedOpacity(
                                  opacity:
                                      (!controller.isSignUpMode.value &&
                                              !controller
                                                  .isForgotPasswordMode
                                                  .value)
                                          ? 1.0
                                          : 0.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed:
                                          () =>
                                              controller
                                                  .toggleForgotPasswordMode(),
                                      child: Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Action Button with animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor,
                            AppColors.primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.isVerificationMode.value) {
                            controller.verifyCode();
                          } else if (controller.isForgotPasswordMode.value) {
                            controller.resetPassword();
                          } else if (controller.isSignUpMode.value) {
                            controller.signUp();
                          } else {
                            controller.login();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          controller.isVerificationMode.value
                              ? "Verify"
                              : controller.isForgotPasswordMode.value
                              ? "Reset Password"
                              : controller.isSignUpMode.value
                              ? "Sign Up"
                              : "Login",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Toggle between Login/SignUp/Back/Resend with animation
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child:
                            controller.isVerificationMode.value
                                ? Column(
                                  children: [
                                    Text(
                                      "Didn't receive the code?",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => controller.resendCode(),
                                      child: Text(
                                        "Resend Code",
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : controller.isForgotPasswordMode.value
                                ? TextButton(
                                  onPressed:
                                      () =>
                                          controller.toggleForgotPasswordMode(),
                                  child: Text(
                                    "Back to Login",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.isSignUpMode.value
                                          ? "Already have an account? "
                                          : "Don't have an account? ",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => controller.toggleAuthMode(),
                                      child: Text(
                                        controller.isSignUpMode.value
                                            ? "Login"
                                            : "Sign Up",
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

    );
  }
}
