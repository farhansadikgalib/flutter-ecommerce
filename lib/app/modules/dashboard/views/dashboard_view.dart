import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/core/style/app_colors.dart';
import 'package:turi/app/modules/cart/controllers/cart_controller.dart';
import 'package:turi/app/modules/home/controllers/home_controller.dart';
import 'package:turi/app/modules/home/views/home_view.dart';
import 'package:turi/app/modules/login/views/login_view.dart';
import 'package:turi/app/modules/order/controllers/order_controller.dart';
import 'package:turi/app/modules/order/views/order_view.dart';
import 'package:turi/app/modules/profile/views/profile_view.dart';
import 'package:turi/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:turi/app/modules/wishlist/views/wishlist_view.dart';
import 'package:turi/app/routes/app_pages.dart';
import '../../cart/views/cart_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  List<Widget> _buildScreens() {
    return [
      HomeView(),
      if (isLoggedIn.$) WishlistView() else LoginView(),
      if (isLoggedIn.$) CartView() else LoginView(),
      if (isLoggedIn.$) OrderView() else LoginView(),
      if (isLoggedIn.$) ProfileView() else LoginView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: ("Wishlist"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: badges.Badge(
          badgeAnimation: badges.BadgeAnimation.rotation(
            animationDuration: 1.seconds,
            colorChangeAnimationDuration: 1.seconds,
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.bounceIn,
          ),
          badgeContent: Obx(
            () =>
                Get.find<CartController>().cartCount.value == 0
                    ? SizedBox()
                    : Text(
                      Get.find<CartController>().cartCount.value.toString(),
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
          ),

          badgeStyle: badges.BadgeStyle(
            badgeColor:
                Get.find<CartController>().cartCount.value == 0
                    ? Colors.transparent
                    : AppColors.white,
          ),

          child: Center(
            child: Icon(Icons.shopping_cart, color: AppColors.secondaryColor),
          ),
        ),
        title: ("Cart"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Orders"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PersistentTabView(
        context,
        controller: PersistentTabController(initialIndex: 0),
        screens: _buildScreens(),
        items: _navBarsItems(),
        onItemSelected: (int index) {
          if (index == 3 && isLoggedIn.$) {
            Get.find<OrderController>().getOrders();
          }
          if (index == 1 && isLoggedIn.$) {
            Get.find<WishlistController>().getWishlist();
          }
          if (index == 2 && isLoggedIn.$) {

            printLog('Cart Count: ${Get.find<CartController>().allCartProducts.length}');

          }
        },
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        padding: EdgeInsets.zero,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style15,
      );
    });
  }

}
