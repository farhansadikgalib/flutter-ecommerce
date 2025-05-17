
class ApiEndPoints {

  //Authentication
  static String login = "login";
  static String logout = "logout";
  //Authentication

  //Home
  static String home = "home";
  static String categories = "categories";
  static String brands = "brands";
  //Home


  //Product
  static String productDetails({
    required String productId,
  }) =>
      "product/$productId";


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
  static String categoryList({
    required String productCategory,required String brandId, required String shippingId
  }) =>
      "all?category=&sub_category=$productCategory&sortby=&shipping=$shippingId&brand"
          "=$brandId"
          "&collection"
          "=&rating=&max=&min=&page=1&sidebar_data=true";

  //Category
}
