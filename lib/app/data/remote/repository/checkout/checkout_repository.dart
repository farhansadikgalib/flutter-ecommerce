import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:turi/app/data/remote/model/checkout/set_user_address_response.dart';
import 'package:turi/app/data/remote/model/checkout/shipping_info_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class CheckoutRepository {
  Future<ShippingInfoResponse> getShippingInfo() async {
    var response = await ApiClient().get(
      ApiEndPoints.shippingRules,
      getShippingInfo,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );
    return shippingResponseFromJson(response.toString());
  }




  Future<SetUserAddressResponse> setShippingAddress(
    String name,
    String email,
    String phone,
    String address,
    String city,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.setShippingAddress,
      {
        "name": name,
        "email": email,
        "phone": phone,
        "address_1": address,
        "address_2": null,
        "city": city,
        "country": null,
        "zip": null,
        "delivery_instruction": null,
      },
      setShippingAddress,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );
    return setUserAddressResponseFromJson(response.toString());
  }

  Future<dynamic> placeAnOrder(body) async {
    var response = await ApiClient().post(
      ApiEndPoints.placeOrder,
      body,
      placeAnOrder,
      isHeaderRequired: false,
      isLoaderRequired: true,
    );
    return response.toString();
  }
}
