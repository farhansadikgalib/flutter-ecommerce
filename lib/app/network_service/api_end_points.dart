
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





}
