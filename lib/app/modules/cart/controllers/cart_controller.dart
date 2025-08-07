import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';

class CartController extends BaseController {
  final totalPrice = 0.0.obs;
  final cartCount = 0.obs;
  final isLoading = false.obs;

  final allCartProducts = <ProductData>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Calculate initial values
    _updateCartSummary();
  }

  /// Add product to cart or update quantity if already exists
  void addToCart(ProductData product, {int quantity = 1}) {
    try {
      // Check if product already exists in cart
      int existingIndex = allCartProducts.indexWhere(
        (item) => item.id == product.id,
      );

      if (existingIndex != -1) {
        // Product exists, update quantity
        allCartProducts[existingIndex].quantity =
            (allCartProducts[existingIndex].quantity ?? 0) + quantity;
      } else {
        // New product, add to cart
        ProductData cartProduct = ProductData(
          id: product.id,
          name: product.name,
          quantity: quantity,
          addToCart: true,
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
        allCartProducts.add(cartProduct);
      }

      _updateCartSummary();

      AppWidgets().getSnackBar(
        title: 'Success',
        message: 'Product added to cart successfully!',
      );

      printLog('Product added to cart: ${product.name}, Quantity: $quantity');
    } catch (e) {
      printLog('Error adding to cart: $e');
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to add product to cart',
      );
    }
  }

  /// Update quantity of existing cart item
  void updateQuantity(int productId, int newQuantity) {
    try {
      if (newQuantity <= 0) {
        removeFromCart(productId);
        return;
      }

      int index = allCartProducts.indexWhere((item) => item.id == productId);
      if (index != -1) {
        allCartProducts[index].quantity = newQuantity;
        _updateCartSummary();
        printLog('Updated quantity for product ID $productId to $newQuantity');
      }
    } catch (e) {
      printLog('Error updating quantity: $e');
    }
  }

  /// Increase quantity by 1
  void increaseQuantity(int productId) {
    int index = allCartProducts.indexWhere((item) => item.id == productId);
    if (index != -1) {
      int currentQuantity = allCartProducts[index].quantity ?? 0;
      updateQuantity(productId, currentQuantity + 1);
      allCartProducts.refresh();
    }
  }

  /// Decrease quantity by 1
  void decreaseQuantity(int productId) {
    int index = allCartProducts.indexWhere((item) => item.id == productId);
    if (index != -1) {
      int currentQuantity = allCartProducts[index].quantity ?? 0;
      if (currentQuantity > 1) {
        updateQuantity(productId, currentQuantity - 1);
      } else {
        removeFromCart(productId);
      }
      allCartProducts.refresh();
    }
  }

  /// Remove product from cart
  void removeFromCart(int productId) {
    try {
      allCartProducts.removeWhere((item) => item.id == productId);
      _updateCartSummary();

      AppWidgets().getSnackBar(
        title: 'Success',
        message: 'Item removed from cart',
      );

      printLog('Product removed from cart: ID $productId');
    } catch (e) {
      printLog('Error removing from cart: $e');
    }
  }

  /// Get quantity of specific product in cart
  int getProductQuantity(int productId) {
    int index = allCartProducts.indexWhere((item) => item.id == productId);
    return index != -1 ? (allCartProducts[index].quantity ?? 0) : 0;
  }

  /// Check if product is in cart
  bool isProductInCart(int productId) {
    return allCartProducts.any((item) => item.id == productId);
  }

  /// Calculate total price based on selling prices and quantities
  void _updateCartSummary() {
    // Update cart count
    cartCount.value = allCartProducts.length;

    // Calculate total price
    double total = 0.0;

    for (var product in allCartProducts) {
      if (product.quantity != null && product.quantity! > 0) {
        double productPrice = _getProductPrice(product);
        total += (productPrice * product.quantity!);
      }
    }

    totalPrice.value = total;

    printLog(
      'Cart updated - Items: ${cartCount.value}, Total: ${totalPrice.value.toStringAsFixed(2)} BDT',
    );
  }

  /// Clear all cart items
  void clearCart() {
    allCartProducts.clear();
    _updateCartSummary();

    AppWidgets().getSnackBar(title: 'Success', message: 'Cart cleared');

    printLog('Cart cleared');
  }

  /// Get cart items for checkout
  List<Map<String, dynamic>> getCartItemsForCheckout() {
    return allCartProducts
        .map(
          (product) => {
            'id': product.id,
            'name': product.name,
            'quantity': product.quantity,
            'price': _getProductPrice(product),
            'total': _getProductPrice(product) * (product.quantity ?? 0),
          },
        )
        .toList();
  }

  /// Helper method to get product price from available sources
  double _getProductPrice(ProductData product) {
    // Try to get price from packSize selling price first
    if (product.packSize?.sellingPrice != null) {
      try {
        return double.parse(product.packSize!.sellingPrice.toString());
      } catch (e) {
        printLog('Error parsing packSize selling price: $e');
      }
    }

    // Try to get price from productPrices selling price
    if (product.productPrices?.sellingPrice != null) {
      try {
        return double.parse(product.productPrices!.sellingPrice.toString());
      } catch (e) {
        printLog('Error parsing productPrices selling price: $e');
      }
    }

    // Fallback to 0 if no price found
    printLog('No price found for product: ${product.name}');
    return 0.0;
  }
}
