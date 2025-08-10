import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:turi/app/data/remote/model/checkout/city_response.dart';
import 'package:turi/app/data/remote/model/checkout/country_response.dart';
import 'package:turi/app/data/remote/model/checkout/payment_method_response.dart';
import 'package:turi/app/data/remote/model/checkout/set_user_address_response.dart';
import 'package:turi/app/data/remote/model/checkout/shipping_info_response.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';
import '../../model/checkout/oder_place_response.dart';

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

  Future<OrderPlaceResponse> placeAnOrder(body) async {
    var response = await ApiClient().post(
      ApiEndPoints.placeOrder,
      body,
      placeAnOrder,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return orderPlaceResponseFromJson(response.toString());
  }



  Future<List<CountryResponse>> getCountry() async {
    var response = await ApiClient().get(
      ApiEndPoints.country,
      getCountry,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );
    return countryResponseFromJson(response.toString());
  }

  Future<List<CityResponse>> getCity(String countryId) async {
    var response = await ApiClient().get(
      ApiEndPoints.city(countryId: countryId),
      getCountry,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );
    return cityResponseFromJson(response.toString());
  }

  Future<List<PaymentMethodResponse>> paymentMethods() async {
    var response = await ApiClient().get(
      ApiEndPoints.paymentMethods,
      paymentMethods,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );
    return paymentMethodResponseFromJson(response.toString());
  }




}
