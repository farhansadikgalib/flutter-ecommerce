import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/data/remote/model/order/order_response.dart';
import 'package:turi/app/data/remote/model/order/track_order_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class OrderRepository{
  Future<OrderResponse> customerOrder() async {
    var response = await ApiClient().get(
      ApiEndPoints.allOrders,
      customerOrder,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return orderResponseFromJson(response.toString());
  }


  Future<TrackOrderData> trackOrder(String orderId) async {
    var response = await ApiClient().get(
      ApiEndPoints.trackOrder(orderId: orderId),
      trackOrder,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return trackOrderDataFromJson(response.toString());
  }





}