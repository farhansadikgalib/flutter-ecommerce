import 'package:ousadbazar/app/data/remote/model/address/default_response.dart';
import 'package:ousadbazar/app/data/remote/model/address/shipping_address_response.dart';
import '../../../../services/network_service/api_client.dart';
import '../../../../services/network_service/api_end_points.dart';

class AddressRepository {
  Future<List<AddressResponse>> getShippingAddress() async {
    var response = await ApiClient().get(
      ApiEndPoints.customerAddress,
      getShippingAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return addressResponseFromJson(response.toString());
  }

  Future<DefaultResponse> deleteAddress(String id) async {
    var response = await ApiClient().delete(
      ApiEndPoints.deleteCustomerAddress(id: id),
      {},
      deleteAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return defaultResponseFromJson(response.toString());
  }

  Future<DefaultResponse> defaultAddress(String id) async {
    var response = await ApiClient().post(
      ApiEndPoints.defaultCustomerAddress(id: id),
      {},
      defaultAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return defaultResponseFromJson(response.toString());
  }

  Future<DefaultResponse> createAddress(body) async {
    var response = await ApiClient().post(
      ApiEndPoints.addCustomerAddress,
      body,
      createAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return defaultResponseFromJson(response.toString());
  }
}
