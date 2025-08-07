import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/modules/cart/controllers/cart_controller.dart';
import 'package:turi/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:turi/app/modules/wishlist/controllers/wishlist_controller.dart';

import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';

class ProductDetailsView extends BaseView<ProductDetailsController> {
  ProductDetailsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // appBar: globalAppBar(context, 'Product Details'),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 80.h),
              children: [
                // Product Image Carousel with improved styling
                Container(
                  height: 350.h,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      // Main image carousel
                      PageView.builder(
                        controller: controller.pageController,
                        itemCount: 1,
                        onPageChanged: (index) {
                          controller.currentPage.value = index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          String imagePath =
                              'https://api.prabashibd'
                              '.com/uploads/product-1737989871-7.jpg';
                          /*                              controller.product.productImages != null &&
                                      controller
                                          .product
                                          .productImages!
                                          .isNotEmpty
                                  ? '${AppConfig.imageBasePath}${controller.product.productImages![index]}'
                                  : 'https://via.placeholder.com/350x350?text=No+Image';*/

                          return GestureDetector(
                            onTap: () {
                              // Image viewer/zoomer functionality
                            },
                            child: Hero(
                              tag: 'product-${controller.product.id}',
                              child: AnyImageView(
                                imagePath: imagePath,
                                width: double.infinity,
                                height: 350.h,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),

                      Positioned(
                        bottom: 10.h,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 60.h,
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.product.productImages?.length ?? 1,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      controller.pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    child: Container(
                                      width: 50.h,
                                      height: 50.h,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              controller.currentPage.value ==
                                                      index
                                                  ? AppColors.primaryColor
                                                  : Colors.grey[300]!,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          2.r,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          1.r,
                                        ),
                                        child: AnyImageView(
                                          imagePath:
                                              controller
                                                              .product
                                                              .productImages !=
                                                          null &&
                                                      controller
                                                          .product
                                                          .productImages!
                                                          .isNotEmpty
                                                  ? '${AppConfig.imageBasePath}${controller.product.productImages![index]}'
                                                  : 'https://via.placeholder.com/46x46?text=No+Image',
                                          width: 46.w,
                                          height: 46.h,
                                          boxFit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Share and Wishlist buttons - Amazon places these in the bottom right
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge
                      if (controller.product.category?.name != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            controller.product.category!.name!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                      // Product title with slightly smaller font than Amazon
                      Text(
                        controller.product.name ?? 'Product Name',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),


                      // Stock availability indicator
                      if (controller.product.productInventories?.quantity !=
                          null)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 16.sp,
                                color:
                                    int.parse(
                                              controller
                                                  .product
                                                  .productInventories!
                                                  .quantity
                                                  .toString(),
                                            ) >
                                            0
                                        ? Colors.green
                                        : Colors.red,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                int.parse(
                                          controller
                                              .product
                                              .productInventories!
                                              .quantity
                                              .toString(),
                                        ) >
                                        0
                                    ? 'In Stock (${controller.product.productInventories!.quantity} available)'
                                    : 'Out of Stock',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      int.parse(
                                                controller
                                                    .product
                                                    .productInventories!
                                                    .quantity
                                                    .toString(),
                                              ) >
                                              0
                                          ? Colors.green
                                          : Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Price section in Alibaba style (larger, with range format)
                      Text(
                        controller.product.packSize?.sellingPrice != null
                            ? '৳${controller.product.packSize!.sellingPrice}'
                            : controller.product.productPrices?.sellingPrice !=
                                null
                            ? '৳${controller.product.productPrices!.sellingPrice}'
                            : 'Price not available',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE51A19), // Alibaba's red color
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFF0E5),
                              border: Border.all(
                                color: Color(0xFFFF6A00),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: Text(
                              controller.product.productPrices?.sellingPrice !=
                                          null &&
                                      controller
                                              .product
                                              .productPrices
                                              ?.costPriceWithoutTax !=
                                          null
                                  ? '${((double.parse(controller.product.productPrices!.costPriceWithoutTax.toString()) - double.parse(controller.product.productPrices!.sellingPrice.toString())) / double.parse(controller.product.productPrices!.costPriceWithoutTax.toString()) * 100).toStringAsFixed(0)}% OFF'
                                  : controller.product.packSize?.vat != null
                                  ? '${controller.product.packSize!.vat}% VAT'
                                  : 'Special Offer',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Color(0xFFFF6A00),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F7FF),
                              border: Border.all(
                                color: Color(0xFF1890FF),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            child: Text(
                              'Free Shipping',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Color(0xFF1890FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      // Alibaba-style trade info row
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping_outlined,
                                  size: 16.sp,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Ships from ${controller.product.supplier?.country ?? controller.product.supplier?.city ?? 'Bangladesh'}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.timer_outlined,
                                  size: 16.sp,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Lead time: ${controller.product.stockBatches?.isNotEmpty == true ? '1-2'
                                          ' days' : '5-10 days'}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Icon(
                                  Icons.receipt_long_outlined,
                                  size: 16.sp,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Returns accepted',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  size: 16.sp,
                                  color: Colors.grey[700],
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '${controller.product.supplier?.companyName ?? 'Verified'} Seller',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Product Description Section
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // Product Features
                      if (controller.product.generic?.name != null ||
                          controller.product.category?.name != null ||
                          controller.product.packSize?.quantity != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Specifications',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // Specifications Table
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                children: [
                                  // Generic Information
                                  if (controller.product.generic?.name != null)
                                    _buildSpecificationRow(
                                      'Generic Name',
                                      controller.product.generic!.name!,
                                      isFirst: true,
                                    ),
                                  if (controller.product.generic?.category !=
                                      null)
                                    _buildSpecificationRow(
                                      'Generic Category',
                                      controller.product.generic!.category!,
                                    ),

                                  // Product Category
                                  if (controller.product.category?.name != null)
                                    _buildSpecificationRow(
                                      'Product Category',
                                      controller.product.category!.name!,
                                    ),

                                  // Product Unit Price
                                  if (controller
                                          .product
                                          .productPrices
                                          ?.sellingPrice !=
                                      null)
                                    _buildSpecificationRow(
                                      'Unit Selling Price',
                                      '৳${controller.product.productPrices!.sellingPrice}',
                                    ),

                                  // Pack Size Information
                                  if (controller.product.packSize?.name != null)
                                    _buildSpecificationRow(
                                      'Pack Size Name',
                                      controller.product.packSize!.name!,
                                    ),
                                  if (controller.product.packSize?.quantity !=
                                      null)
                                    _buildSpecificationRow(
                                      'Pack Quantity',
                                      '${controller.product.packSize!
                                          .quantity} ',
                                    ),
                                  if (controller
                                          .product
                                          .packSize
                                          ?.sellingPrice !=
                                      null)
                                    _buildSpecificationRow(
                                      'Pack Selling Price',
                                      '৳${controller.product.packSize!.sellingPrice}',
                                    ),


                                  // Additional Product Information
                                  if (controller
                                          .product
                                          .productInventories
                                          ?.quantity !=
                                      null)
                                    _buildSpecificationRow(
                                      'Available Stock',
                                      '${controller.product.productInventories!.quantity} units',
                                    ),
                                  if (controller.product.totalSoldQuantity !=
                                      null)
                                    _buildSpecificationRow(
                                      'Total Sold',
                                      '${controller.product.totalSoldQuantity} units',
                                      isLast: true,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Supplier Information Section
                if (controller.product.supplier != null)
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Supplier Information',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        if (controller.product.supplier!.companyName != null)
                          _buildInfoRow(
                            'Company',
                            controller.product.supplier!.companyName!,
                          ),

                        if (controller.product.supplier!.address1 != null)
                          _buildInfoRow(
                            'Address',
                            controller.product.supplier!.address1!,
                          ),
                      ],
                    ),
                  ),

                SizedBox(height: 8.h),
              ],
            ),

            // Bottom Add to Cart Bar with improved styling
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    // Chat button
                    SizedBox(width: 12.w),
                    // Add to Cart/Quantity buttons
                    Expanded(
                      child: Visibility(
                        visible: controller.product.addToCart!,
                        replacement: Container(
                          height: 42.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (controller.product.quantity! > 1) {
                                    controller.product.quantity =
                                        controller.product.quantity! - 1;
                                  } else {}
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: AppColors.primaryColor,
                                  size: 14.sp,
                                ),
                              ),
                              Text(
                                controller.product.quantity.toString(),
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.product.quantity =
                                      controller.product.quantity! + 1;
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: AppColors.primaryColor,
                                  size: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 42.h,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              Get.find<CartController>().addToCart(
                                controller.product,
                              );
                            },
                            child: Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Buy Now button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          controller.wishlistItem.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              controller.wishlistItem.value
                                  ? Colors.red
                                  : AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          Get.find<WishlistController>().wishlistAction(
                            controller.product.id.toString(),
                          );
                          controller.wishlistItem.value =
                              !controller.wishlistItem.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              '$label:',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecificationRow(
    String label,
    String value, {
    bool isFirst = false,
    bool isLast = false,
    bool isHeader = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: isFirst ? BorderSide.none : BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isHeader ? Colors.grey[100] : Colors.grey[50],
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isHeader ? Colors.black87 : Colors.grey[700],
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.black87,
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
