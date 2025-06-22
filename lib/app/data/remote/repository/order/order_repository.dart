import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/data/remote/model/order/order_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class OrderRepository{
  Future<OrderResponse> customerOrder() async {
    var response = await ApiClient().post(
      ApiEndPoints.allOrders,
      {
        "order_by": userId.$,
      },
      customerOrder,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return orderResponseFromJson(response.toString());
  }


}