import 'package:ousadbazar/app/data/remote/model/wishlist/wishlist_action_response.dart';
import 'package:ousadbazar/app/data/remote/model/wishlist/wishlist_response.dart';

import '../../../../services/network_service/api_client.dart';
import '../../../../services/network_service/api_end_points.dart';

class WishlistRepository {
  Future<WishlistActionResponse> addToWishlist(String productId) async {
    var response = await ApiClient().post(
      ApiEndPoints.addToWishlist,
      {"product_id": productId},
      addToWishlist,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return wishlistActionResponseFromJson(response.toString());
  }

  Future<WishlistItemResponse> getWishlist() async {
    var response = await ApiClient().get(
      ApiEndPoints.wishlistItems,
      getWishlist,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return wishlistItemResponseFromJson(response.toString());
  }
}
