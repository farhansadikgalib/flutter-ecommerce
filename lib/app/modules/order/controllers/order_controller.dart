import 'package:get/get.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/order/order_response.dart';

import '../../../data/remote/model/order/track_order_response.dart';
import '../../../data/remote/repository/order/order_repository.dart';
import '../views/track_order_view.dart';

class OrderController extends GetxController {
  final isLoading = false.obs;

  final orderData = <AllOrdersData>[].obs;
  var trackOrderData = <TrackOrderData>[].obs;

  Future<void> getOrders() async {
    isLoading.value = true;
    var response = await OrderRepository().customerOrder();
    orderData.clear();
    orderData.addAll(response.data!);
    isLoading.value = false;
  }

  Future<void> trackOrder(String orderId) async {
    isLoading.value = true;
    try {
      var response = await OrderRepository().trackOrder(orderId);
      printLog(response);
      trackOrderData.clear();
      trackOrderData.add(response);
      Get.to(() => TrackOrderView());
    } catch (e) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to track order: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelOrder(String orderId) async {
    var response = await OrderRepository().cancelOrder(orderId);
    getOrders();
    printLog(response);
    AppWidgets().getSnackBar(message: 'Order cancelled successfully');
  }
}
