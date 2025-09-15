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
  static String bestSellingProduct({required int page}) =>
      "best-selling-product?page=$page&limit=30";
  static String ecomCategories = "all-ecom-categories";

  //Home

  //Product
  static String productDetails({required String productId}) =>
      "product-show/$productId";

  static String productReview({required String productId}) =>
      "reviews/$productId?order_by=created_at&type=desc";

  static String relatedProduct({required String genericId}) =>
      "product-generic-wise/$genericId?page=1";

  //Checkout
  static String setShippingAddress = "user/address/action";
  static String placeOrder = "sales";
  static String shippingRules = "shipping-rule/all-shipping-rules";

  //Checkout

  //Category
  static String categoryProductList({required int categoryId}) =>
      "product-category-wise/$categoryId";

  static String supplierProductList({required int categoryId}) =>
      "product-supplier-wise/$categoryId";

  //Category

  // Search

  static String searchProduct({required String query}) =>
      "products/search?term=$query";

  // Search

  //order
  static String allOrders = "all-order-list-paginated";

  static String trackOrder({required String orderId}) =>
      "order-tracking?sale_code=$orderId";

  static String cancelOrder({required String orderId}) =>
      "sale/request-to-suspend/$orderId";

  //order

  //wishlist

  static String wishlistItems =
      "user/wishlist/all?order_by=created_at&type=desc";
  static String addToWishlist = "user/wishlist/action";

  //wishlist

  //cart

  //Checkout

  static String paymentMethods = "all-payment-methods";
  static String country = "country/search";

  static String city({required String countryId}) =>
      "city/search?country_id=$countryId";

  static String area({required String cityId}) => "area/search?city_id=$cityId";

  //Checkout
}
