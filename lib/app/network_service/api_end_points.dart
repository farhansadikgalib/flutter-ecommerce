
import 'dart:ffi';

class ApiEndPoints {

  //Authentication
  static String login = "user-login";
  static String signup = "user-register";
  static String verifyOtp = "user/verify";
  static String forgetPassword = "user/forgot-password";
  static String updatePassword = "user/update-password";
  static String logout = "user/logout";
  //Authentication

  //Home
  static String home = "home";
  static String categories = "category_all";
  static String supplier = "all-supplier";
  static String bestSellingProduct = "best-selling-product";

  //Home


  //Product
  static String productDetails({
    required String productId,
  }) =>
      "product-show/$productId";


  static String productReview({
    required String productId,
  }) =>
      "reviews/$productId?order_by=created_at&type=desc";





  //Checkout
  static String setShippingAddress = "user/address/action";
  static String placeOrder = "order/action";
  static String shippingRules = "shipping-rule/all-shipping-rules";

  //Checkout

  //Category
  static String categoryProductList({
    required int categoryId,
  }) =>
      "product-category-wise/$categoryId";

  static String supplierProductList({
    required int categoryId,
  }) =>
      "product-supplier-wise/$categoryId";

  //Category


// Search

  static String searchProduct({
    required String query,
  }) =>
      "products/search?term=$query";

// Search


//order
static String allOrders = "order/by-user";
  static String trackOrder({
    required String orderId,
  }) =>
      "track-order?tracking_id=$orderId";
//order

//wishlist

static String wishlistItems = "user/wishlist/all?order_by=created_at&type=desc";
static String addToWishlist = "user/wishlist/action";

//wishlist

//cart

static String addToCart = "cart/action";
static String allCartItems = "cart/by-user";
static String deleteCartItems ({
    required String productId,
  }) =>
      "cart/delete/$productId";

//



}
