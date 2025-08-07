/*
import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/data/remote/model/cart/cart_items_response.dart';
import 'package:turi/app/data/remote/model/cart/delete_cart_items_response.dart';
import 'package:turi/app/data/remote/model/wishlist/wishlist_action_response.dart';
import '../../../../network_service/api_client.dart';
import '../../../../network_service/api_end_points.dart';

class CartRepository {
  Future<WishlistActionResponse> addToCart(
    String productId,
    String inventoryId,
    String quantity,
  ) async {
    var response = await ApiClient().post(
      ApiEndPoints.addToCart,
      {
        "product_id": productId,
        "inventory_id": inventoryId,
        "quantity": quantity,
        "user_id": userId.$,
      },
      addToCart,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );

    return wishlistActionResponseFromJson(response.toString());
  }

  Future<CartItemsReponse> getCartItems() async {
    var response = await ApiClient().get(
      ApiEndPoints.allCartItems,
      getCartItems,
      isHeaderRequired: true,
      isLoaderRequired: false,
    );
    return cartItemsReponseFromJson(response.toString());
  }


  Future<DeleteCartResponse> deleteCartItems(String productId) async {
    var response = await ApiClient().delete(
      ApiEndPoints.deleteCartItems(productId: productId),
      {},
      deleteCartItems,
      isHeaderRequired: true,
      isLoaderRequired: true,
    );
    return deleteCartResponseFromJson(response.toString());
  }
}
*/
