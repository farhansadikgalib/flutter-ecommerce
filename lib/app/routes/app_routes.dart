part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const CART = _Paths.CART;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const PRODUCT_DETAILS = _Paths.PRODUCT_DETAILS;
  static const PRODUCT_CATEGORY = _Paths.PRODUCT_CATEGORY;
  static const SPLASH = _Paths.SPLASH;
  static const LOGIN = _Paths.LOGIN;
  static const ORDER = _Paths.ORDER;
  static const PROFILE = _Paths.PROFILE;
  static const WISHLIST = _Paths.WISHLIST;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const DASHBOARD = '/dashboard';
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const PRODUCT_DETAILS = '/product-details';
  static const PRODUCT_CATEGORY = '/product-category';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const ORDER = '/order';
  static const PROFILE = '/profile';
  static const WISHLIST = '/wishlist';
}
