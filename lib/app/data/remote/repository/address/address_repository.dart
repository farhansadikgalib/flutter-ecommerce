import 'package:ousadbazar/app/data/remote/model/address/create_address_response.dart';
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

  Future<CreateAddressResponse> createAddress(
    String title,
    String address,
    String countryId,
    String cityId,
    String areaId,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.addCustomerAddress,
      {
        "title": title,
        "address": address,
        "country_id": countryId,
        "city_id": cityId,
        "area_id": areaId,
      },
      createAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return createAddressResponseFromJson(response.toString());
  }

  Future<CreateAddressResponse> updateAddress(
    String id,
    String title,
    String address,
    String countryId,
    String cityId,
    String areaId,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.updateCustomerAddress(id: id),
      {
        "title": title,
        "address": address,
        "country_id": countryId,
        "city_id": cityId,
        "area_id": areaId,
      },
      createAddress,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return createAddressResponseFromJson(response.toString());
  }
}
