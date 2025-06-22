import 'package:get/get.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/data/remote/model/order/order_response.dart';

import '../../../data/remote/model/order/track_order_response.dart';
import '../../../data/remote/repository/order/order_repository.dart';
import '../views/track_order_view.dart';

class OrderController extends GetxController {
  final isLoading = false.obs;

  final orderData = <AllOrdersData>[].obs;
  final trackOrderData = <TrackOrderData>[].obs;



  Future<void> getOrders() async {

    isLoading.value = true; // Set loading state to true
    var response =  await OrderRepository().customerOrder();

    if (response.status == 200) {
      if(response.data!.data!.isNotEmpty){
        orderData.clear();
        orderData.addAll(response.data!.data!);
      } else {

        AppWidgets().getSnackBar(message: response.message);
      }

    } else {
      // Handle error response
      AppWidgets().getSnackBar(message: response.message);
    }

    isLoading.value = false;


  }



  Future<void> trackOrder(String orderId) async {
    isLoading.value = true;
    var response = await OrderRepository().trackOrder(orderId);
    if (response.status == 200) {
      trackOrderData.clear();
      trackOrderData.add(response.data!);
      Get.to(
        () => TrackOrderView(),
      );
      AppWidgets().getSnackBar(message: 'Order tracked successfully');
    } else {
      // Handle error response
      AppWidgets().getSnackBar(message: response.message);
    }

    isLoading.value = false;
  }




}
