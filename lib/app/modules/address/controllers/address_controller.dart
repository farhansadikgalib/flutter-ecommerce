import 'package:get/get.dart';

import '../../../data/remote/model/address/shipping_address_response.dart';
import '../../../data/remote/repository/address/address_repository.dart';

class AddressController extends GetxController {

  final shippingAddressList = <AddressResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllShippingAddress();
  }


   Future<void> getAllShippingAddress() async{
    var response = await AddressRepository().getShippingAddress();
    if (response.isNotEmpty) {
      shippingAddressList.value = response;
    }
  }


}
