

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

      // userName.$ = loginResponse.name!;
      // userName.save();
      //
      // staffID.$ = loginResponse.staffid!;
      // staffID.save();
      //
      // designation.$ = loginResponse.designation!;
      // designation.save();
      //
      // userRole.$ = loginResponse.role!;
      // userRole.save();
      //
      // if (loginResponse.role?.toLowerCase() == "Manager".toLowerCase()) {
      //   isManager.$ = true;
      //   isSupervisor.$ = false;
      //   isOperator.$ = false;
      // } else if (loginResponse.role?.toLowerCase() == "Supervisor".toLowerCase()) {
      //   isManager.$ = false;
      //   isSupervisor.$ = true;
      //   isOperator.$ = false;
      // } else if (loginResponse.role?.toLowerCase() == "Operator".toLowerCase()) {
      //   isManager.$ = false;
      //   isSupervisor.$ = false;
      //   isOperator.$ = true;
      // } else {
      //   isManager.$ = true;
      //   isSupervisor.$ = false;
      //   isOperator.$ = false;
      // }
      // isManager.save();
      // isSupervisor.save();
      // isOperator.save();
    }
  }

  void clearUserData() {
    isLoggedIn.$ = false;
    isLoggedIn.save();

    accessToken.$ = "";
    accessToken.save();


    staffID.$ = "";
    staffID.save();

    userName.$ = "";
    userName.save();

    userRole.$ = "";
    userRole.save();

    designation.$ = "";
    designation.save();

    isManager.$ = false;
    isManager.save();

    isSupervisor.$ = false;
    isSupervisor.save();

    isOperator.$ = false;
    isOperator.save();
  }

  loadItems() {
    isLoggedIn.load();
    accessToken.load();
    userName.load();
    staffID.load();
    isManager.load();
    isSupervisor.load();
    isOperator.load();
    designation.load();
    userRole.load();
  }
}
