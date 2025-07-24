

import 'package:turi/app/core/helper/shared_value_helper.dart';

import '../../data/remote/model/auth/login_response.dart';


class AuthHelper {
  void setUserData(
      LoginResponse loginResponse) {
    if (loginResponse.token != null) {
      isLoggedIn.$ = true;
      isLoggedIn.save();

      accessToken.$ = "Bearer ${loginResponse.token}";
      accessToken.save();

      userName.$ = loginResponse.user!.name!;
      userName.save();

      userId.$ = loginResponse.user!.id!.toString();
      userId.save();

      userEmail.$ = loginResponse.user!.email!;
      userEmail.save();


    }
  }

  void clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    accessToken.$ = "";
    accessToken.save();


    userId.$ = "";
    userId.save();

    userName.$ = "";
    userName.save();


    userEmail.$ = "";
    userEmail.save();

  }

  void loadItems() {
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    userId.load();
    userEmail.load();
    userRole.load();
  }
}
