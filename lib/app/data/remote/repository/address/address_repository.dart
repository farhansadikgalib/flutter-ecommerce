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


}
