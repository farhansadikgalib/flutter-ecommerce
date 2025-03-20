
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';
import '../../model/auth/login_response.dart';
import '../../model/auth/logout_response.dart';

class AuthRepository {

  Future<LoginResponse> getUserLogin(
    String staffId,
    String password,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.login,
      {
        "staffid": staffId,
        "password": password,
      },
      getUserLogin,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );

    return loginResponseFromJson(response.toString());
  }


  Future<LogoutResponse> getUserLogOut() async {
    var response = await ApiClient().post(
      ApiEndPoints.logout,
      {
      },
      getUserLogin,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );

    return logoutResponseFromJson(response.toString());
  }


}
