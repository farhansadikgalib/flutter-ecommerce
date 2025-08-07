import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/routes/app_pages.dart';
import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/cart_controller.dart';

class CartView extends BaseView<CartController> {
  CartView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return globalAppBar(context, 'Cart', showBackButton: false);
  }

  @override
  Widget? floatingActionButton() {
    return controller.cartCount.value > 0
        ? Container(
            width: Get.width,
            margin: REdgeInsets.only(left: 26),
            padding: REdgeInsets.symmetric(horizontal: 8),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Total: ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.h),
                Obx(
                  () => Text(
                    '${controller.totalPrice.value.toStringAsFixed(2)} BDT',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => Get.toNamed(
                    Routes.CHECKOUT,
                    arguments: {
                      'subTotal': controller.totalPrice.value,
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox();
  }



@override
Widget body(BuildContext context) {
  return Obx(() {
    if (controller.isLoading.value) {
      // Skeleton loader for cart items
      return Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 4,
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemBuilder: (context, index) => Card(
            elevation: 3,
            margin: REdgeInsets.only(bottom: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: REdgeInsets.all(12),
              leading: Container(width: 56, height: 56, color: Colors.grey[300]),
              title: Container(height: 16, color: Colors.grey[300]),
              subtitle: Container(height: 14, color: Colors.grey[200]),
              trailing: Container(width: 60, height: 30, color: Colors.grey[300]),
            ),
          ),
        ),
      );
    }

    if (controller.cartCount.value == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_order.png',
              height: 100,
              width: 100,
              errorBuilder: (ctx, obj, stack) => Icon(
                Icons.shopping_cart_outlined,
                size: 60,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your cart is empty',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Start adding products to your cart',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.DASHBOARD),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: Text('Start Shopping'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => {},
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: controller.allCartProducts.length,
        separatorBuilder: (_, __) => SizedBox(height: 10),
        itemBuilder: (context, index) {
          final product = controller.allCartProducts[index];
          return Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AnyImageView(
                      height: 56,
                      width: 56,
                      boxFit: BoxFit.cover,
                      imagePath: AppConfig.imageBasePath ,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.packSize!.sellingPrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${product.packSize} BDT',
                          style: TextStyle(color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: FaIcon(
                          product.quantity == 1 ? FontAwesomeIcons.trash : FontAwesomeIcons.minus,
                          color: AppColors.primaryColor,
                          size: 16,
                        ),
                        onPressed: () {
                          if (product.quantity! > 1) {
                            product.quantity = product.quantity! - 1;
                          } else {
                            // controller.deleteCartItems(product.id.toString());
                          }
                        },
                      ),
                      Text(
                        product.quantity!.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.plus, color: AppColors.primaryColor, size: 16),
                        onPressed: () {
                          product.quantity = product.quantity! + 1;
                          // controller.addToCart(
                          //   product.flashProduct!.id!.toString(),
                          //   product.quantity!.toString(),
                          //   "1",
                          // );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  });
}
}



