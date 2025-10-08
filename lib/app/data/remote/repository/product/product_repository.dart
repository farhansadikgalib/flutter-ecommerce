import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:ousadbazar/app/data/remote/model/product/product_details_response.dart';
import 'package:ousadbazar/app/data/remote/model/product/product_review_response.dart';
import 'package:ousadbazar/app/data/remote/model/product/related_product_response.dart';

import '../../../../services/network_service/api_client.dart';
import '../../../../services/network_service/api_end_points.dart';

class ProductRepository {
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

  Future<BestSellingProductResponse> getRelatedProduct(String genericId) async {
    var response = await ApiClient().get(
      ApiEndPoints.relatedProduct(genericId: genericId),
      getRelatedProduct,
      isHeaderRequired: false,
      isLoaderRequired: false,
    );

    return bestSellingProductResponseFromJson(response.toString());
  }
}
