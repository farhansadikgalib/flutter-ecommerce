import 'package:get/get.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';

import '../../../data/remote/model/home/best_selling_product_response.dart';

class WishlistController extends GetxController {
  final wishlistItems = <ProductData>[].obs;
  final isLoading = false.obs;


  void addToWishlist(ProductData product, ) {
    try {
      int existingIndex = wishlistItems.indexWhere(
            (item) => item.id == product.id,
      );

      if (existingIndex != -1) {
        removeFromWishlist(product.id!);
      } else {
        // New product, add to cart
        ProductData item = ProductData(
          id: product.id,
          name: product.name,
          quantity: 0,
          addToCart: false,
          addToWishlist: true,
          packSize: product.packSize,
          productImages: product.productImages,
          categoryId: product.categoryId,
          genericId: product.genericId,
          supplierId: product.supplierId,
          totalSoldQuantity: product.totalSoldQuantity,
          generic: product.generic,
          category: product.category,
          supplier: product.supplier,
          productVariationAttributes: product.productVariationAttributes,
          productVariations: product.productVariations,
          productPrices: product.productPrices,
          productInventories: product.productInventories,
          productLocations: product.productLocations,
          stockBatches: product.stockBatches,
        );
        wishlistItems.add(item);
      }


      AppWidgets().getSnackBar(
        title: 'Success',
        message: 'Product added to wishlist successfully!',
      );

      printLog('Product added to wishlist: ${product.name}, Quantity: '
          );
    } catch (e) {
      printLog('Error adding to wishlist: $e');
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to add product to wishlist',
      );
    }
  }


  void removeFromWishlist(int productId) {
    try {
      wishlistItems.removeWhere((item) => item.id == productId);
      AppWidgets().getSnackBar(
        title: 'Success',
        message: 'Item removed from cart',
      );

      printLog('Product removed from cart: ID $productId');
    } catch (e) {
      printLog('Error removing from cart: $e');
    }
  }

}
