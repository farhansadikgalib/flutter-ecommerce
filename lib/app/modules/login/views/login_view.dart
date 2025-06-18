import 'package:flutter/material.dart';
          import 'package:get/get.dart';
          import 'package:flutter_screenutil/flutter_screenutil.dart';
          import '../../../core/style/app_colors.dart';
          import '../controllers/login_controller.dart';

          class LoginView extends GetView<LoginController> {
            const LoginView({super.key});

            @override
            Widget build(BuildContext context) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.h),

                          // Logo or App Name
                          Center(
                            child: Text(
                              "Turi",
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),

                          SizedBox(height: 50.h),

                          // Welcome Text
                          Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 8.h),

                          Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),

                          SizedBox(height: 40.h),

                          // Email Field
                          Obx(() => TextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "Enter your email",
                              prefixIcon: const Icon(Icons.email_outlined),
                              errorText: controller.emailError.value.isEmpty
                                  ? null
                                  : controller.emailError.value,
                            ),
                            onChanged: (value) => controller.validateEmail(value),
                          )),

                          SizedBox(height: 20.h),

                          // Password Field
                          Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: controller.isPasswordHidden.value,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordHidden.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () => controller.togglePasswordVisibility(),
                              ),
                              errorText: controller.passwordError.value.isEmpty
                                  ? null
                                  : controller.passwordError.value,
                            ),
                            onChanged: (value) => controller.validatePassword(value),
                          )),

                          SizedBox(height: 16.h),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => controller.forgotPassword(),
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 30.h),

                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: () => controller.login(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                              child: Obx(() => controller.isLoading.value
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : Text(
                                      "Login",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                            ),
                          ),

                          SizedBox(height: 30.h),

                          // Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                onPressed: () => controller.goToSignUp(),
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }