import 'package:turi/app/data/remote/model/product/product_details_response.dart';
import 'package:turi/app/data/remote/model/product/product_review_response.dart';

import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class ProductRepository{
  Future<ProductDetailsResponse> getProductDetails(String productId) async {
    var response = await ApiClient().get(
      ApiEndPoints.productDetails(productId: productId),
      getProductDetails,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return productDetailsResponseFromJson(response.toString());
  }

  Future<ProductReviewResponse> getProductReview(String productId) async {
    var response = await ApiClient().get(
      ApiEndPoints.productReview(productId: productId),
      getProductReview,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return productReviewResponseFromJson(response.toString());
  }
}