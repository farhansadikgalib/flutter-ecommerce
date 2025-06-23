import 'package:turi/app/data/remote/model/auth/forget_password_response.dart';
import 'package:turi/app/data/remote/model/auth/otp_verify_response.dart';
import 'package:turi/app/data/remote/model/auth/sign_up_response.dart';
import 'package:turi/app/data/remote/model/auth/update_password_response.dart';

import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';
import '../../model/auth/login_response.dart';
import '../../model/auth/logout_response.dart';

class AuthRepository {
  Future<LoginResponse> login(String email, String password) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {"email": email, "password": password},
      login,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return loginResponseFromJson(response.toString());
  }

  Future<SignUpResponse> signup(
    String name,
    String email,
    String password,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.signup,
      {"name": name, "email": email, "password": password},
      signup,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return signUpResponseFromJson(response.toString());
  }

  Future<OtpVerifyResponse> verifyOTP(
      String email,
      String code,
      ) async {
    var response = await ApiClient().post(
      ApiEndPoints.verifyOtp,
      { "email": email, "code": code},
      verifyOTP,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return otpVerifyResponseFromJson(response.toString());
  }



  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    var response = await ApiClient().post(
      ApiEndPoints.forgetPassword,
      {"email": email},
      forgetPassword,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return forgetPasswordResponseFromJson(response.toString());
  }

  Future<UpdatePasswordResponse> updatePassword(
      String code,
      String email,
      String password,
      ) async {
    var response = await ApiClient().post(
      ApiEndPoints.updatePassword,
      {"code": code, "email": email, "password": password},
      updatePassword,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return updatePasswordResponseFromJson(response.toString());
  }


  Future<LogoutResponse> getUserLogOut() async {
    var response = await ApiClient().get(
      ApiEndPoints.logout,
      getUserLogOut,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return logoutResponseFromJson(response.toString());
  }
}
