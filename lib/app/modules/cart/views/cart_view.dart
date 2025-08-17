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
import '../controllers/cart_controller.dart';

class CartView extends BaseView<CartController> {
  CartView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return globalAppBar(context, 'Cart', showBackButton: false);
  }

  @override
  Widget? floatingActionButton() {
    return Obx(
      () =>
          controller.cartCount.value > 0
              ? Container(
                width: Get.width,
                margin: REdgeInsets.only(left: 26),
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 2),
                          Obx(
                            () => Text(
                              '৳${controller.totalPrice.value.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed:
                          () => Get.toNamed(
                            Routes.CHECKOUT,
                            arguments: {
                              'cartProducts': controller.allCartProducts,
                              'subTotal': controller.totalPrice.value,
                            },
                          ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.payment, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'Checkout',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : SizedBox(),
    );
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
            itemBuilder:
                (context, index) => Card(
                  elevation: 3,
                  margin: REdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: REdgeInsets.all(12),
                    leading: Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey[300],
                    ),
                    title: Container(height: 16, color: Colors.grey[300]),
                    subtitle: Container(height: 14, color: Colors.grey[200]),
                    trailing: Container(
                      width: 60,
                      height: 30,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
          ),
        );
      }

      if (controller.cartCount.value == 0) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 60,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Your cart is empty',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Looks like you haven\'t added\nanything to your cart yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(Routes.DASHBOARD),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Start Shopping',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async => {},
        child: Column(
          children: [
            // Cart items list
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(left: 16,right: 16, top: 4,bottom:
                Get.height/3),
                itemCount: controller.allCartProducts.length,
                separatorBuilder: (_, __) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = controller.allCartProducts[index];
                  return Dismissible(
                    key: Key('cart_item_${product.id}'),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Remove',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      return await _showRemoveConfirmationDialog(
                        context,
                        product.name ?? 'this item',
                      );
                    },
                    onDismissed: (direction) {
                      // Remove the item from cart
                      controller.removeFromCart(product.id!);

                      // Show snackbar with undo option
                      Get.snackbar(
                        'Item Removed',
                        '${product.name ?? 'Item'} has been removed from cart',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black87,
                        colorText: Colors.white,
                        duration: Duration(seconds: 3),
                        margin: EdgeInsets.all(16),
                        borderRadius: 8,
                        icon: Icon(Icons.check_circle, color: Colors.green),
                        mainButton: TextButton(
                          onPressed: () {
                            // Undo functionality - add item back to cart
                            controller.addToCart(
                              product,
                              quantity:
                                  controller.getProductQuantity(product.id!) > 0
                                      ? controller.getProductQuantity(
                                        product.id!,
                                      )
                                      : 1,
                            );
                            Get.closeCurrentSnackbar();
                          },
                          child: Text(
                            'UNDO',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Product Image with better styling
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  width: 0.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AnyImageView(
                                  height: 64,
                                  width: 64,
                                  fit: BoxFit.cover,
                                  imagePath:
                                      product.productImages != null &&
                                              product.productImages!.isNotEmpty
                                          ? '${AppConfig
                                          .imageBasePath}${product.productImages![0].path}'
                                          : '${AppConfig.imageBasePath}default.png',
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name ?? 'Product Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        '৳${product.productPrices?.sellingPrice ?? product.packSize?.sellingPrice ?? 0}',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'each',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  // Total price for this item
                                  Obx(
                                    () => Text(
                                      'Total: ৳${((double.parse((product.productPrices?.sellingPrice ?? product.packSize?.sellingPrice ?? 0).toString())) * controller.getProductQuantity(product.id!)).toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12),
                            // Enhanced quantity selector with proper cart integration
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: FaIcon(
                                      controller.getProductQuantity(
                                                product.id!,
                                              ) ==
                                              1
                                          ? FontAwesomeIcons.trash
                                          : FontAwesomeIcons.minus,
                                      color: AppColors.primaryColor,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      controller.decreaseQuantity(product.id!);
                                    },
                                    constraints: BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Obx(
                                      () => Text(
                                        controller
                                            .getProductQuantity(product.id!)
                                            .toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: AppColors.primaryColor,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      controller.increaseQuantity(product.id!);
                                    },
                                    constraints: BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  // Confirmation dialog for swipe to remove
  Future<bool?> _showRemoveConfirmationDialog(
    BuildContext context,
    String productName,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 28),
              SizedBox(width: 12),
              Text(
                'Remove Item',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to remove "$productName" from your cart?',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                'Remove',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
