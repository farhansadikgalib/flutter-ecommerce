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
import '../../../core/widget/product_card.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';

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
                          return GestureDetector(
                            onTap: () {},
                            child: Hero(
                              tag: 'product-${controller.product.id}',
                              child: AnyImageView(
                                imagePath:
                                    controller.product.productImages != null &&
                                            controller
                                                .product
                                                .productImages!
                                                .isNotEmpty
                                        ? '${AppConfig.imageBasePath}${controller.product.productImages![index].path}'
                                        : 'https://via.placeholder.com/350x350?text=No+Image',
                                width: double.infinity,
                                height: 350.h,
                                fit: BoxFit.cover,
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
                                                  ? '${AppConfig.imageBasePath}${controller.product.productImages![index].path}'
                                                  : 'https://via.placeholder.com/46x46?text=No+Image',
                                          width: 46.w,
                                          height: 46.h,
                                          fit: BoxFit.cover,
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
                        controller.product.productPrices?.sellingPrice != null
                            ? '৳${controller.product.productPrices!.sellingPrice}'
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
                                      '${controller.product.packSize!.quantity} ',
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

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text('Related Products'),
                ),

                Container(
                  height: Get.height,
                  padding: EdgeInsets.all(16.w),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.66,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.relatedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Dart
                      final item = controller.relatedProducts[index];

                      final product = ProductData(
                        id: item.id,
                        quantity: 0,
                        addToCart: false,
                        addToWishlist: false,
                        name: item.name,
                        genericId: item.genericId,
                        categoryId: item.categoryId,
                        supplierId: item.supplierId,
                        generic:
                            item.generic != null
                                ? Generic(
                                  id: item.generic!.id,
                                  name: item.generic!.name,
                                  category: item.generic!.category,
                                  status: item.generic!.status,
                                  createdBy: item.generic!.createdBy,
                                  updatedBy: item.generic!.updatedBy,
                                  createdAt: item.generic!.createdAt,
                                  updatedAt: item.generic!.updatedAt,
                                )
                                : null,
                        category:
                            item.category != null
                                ? Category(
                                  id: item.category!.id,
                                  name: item.category!.name,
                                  shortOrder: item.category!.shortOrder,
                                  createdAt: item.category!.createdAt,
                                  updatedAt: item.category!.updatedAt,
                                  status: item.category!.status,
                                )
                                : null,
                        supplier:
                            item.supplier != null
                                ? Supplier(
                                  id: item.supplier!.id,
                                  firstName: item.supplier!.firstName,
                                  lastName: item.supplier!.lastName,
                                  address1: item.supplier!.address1,
                                  address2: item.supplier!.address2,
                                  city: item.supplier!.city,
                                  stateOrProvince:
                                      item.supplier!.stateOrProvince,
                                  zip: item.supplier!.zip,
                                  country: item.supplier!.country,
                                  comments: item.supplier!.comments,
                                  contact: item.supplier!.contact,
                                  email: item.supplier!.email,
                                  companyName: item.supplier!.companyName,
                                  accountNo: item.supplier!.accountNo,
                                  imagePath: item.supplier!.imagePath,
                                  status: item.supplier!.status,
                                  createdAt: item.supplier!.createdAt,
                                  updatedAt: item.supplier!.updatedAt,
                                  type: item.supplier!.type,
                                  storeAccountBalance:
                                      item.supplier!.storeAccountBalance,
                                  payAmount: item.supplier!.payAmount,
                                  deletedAt: item.supplier!.deletedAt,
                                  deletedBy: item.supplier!.deletedBy,
                                )
                                : null,
                        packSize:
                            item.packSize != null
                                ? PackSize(
                                  id: item.packSize!.id,
                                  productId: item.packSize!.productId,
                                  name: item.packSize!.name,
                                  quantity: item.packSize!.quantity,
                                  tp: item.packSize!.tp,
                                  vatPercent: item.packSize!.vatPercent,
                                  vat: item.packSize!.vat,
                                  sellingPrice: item.packSize!.sellingPrice,
                                  defaultUnit: item.packSize!.defaultUnit,
                                  createdAt: item.packSize!.createdAt,
                                  updatedAt: item.packSize!.updatedAt,
                                  deletedAt: item.packSize!.deletedAt,
                                )
                                : null,
                        productPrices:
                            item.productPrices != null
                                ? ProductPrices(
                                  id: item.productPrices!.id,
                                  productId: item.productPrices!.productId,
                                  costPriceWithoutTax:
                                      item.productPrices!.costPriceWithoutTax,
                                  sellingPrice:
                                      item.productPrices!.sellingPrice,
                                  tradePrice: item.productPrices!.tradePrice,
                                  vat: item.productPrices!.vat,
                                  wholesale: item.productPrices!.wholesale,
                                  wholesaleType:
                                      item.productPrices!.wholesaleType,
                                  promoPrice: item.productPrices!.promoPrice,
                                  promoStartDate:
                                      item.productPrices!.promoStartDate,
                                  promoEndDate:
                                      item.productPrices!.promoEndDate,
                                  disableFromPriceRules:
                                      item.productPrices!.disableFromPriceRules,
                                  allowPriceOverrideRegardlessOfPermissions:
                                      item
                                          .productPrices!
                                          .allowPriceOverrideRegardlessOfPermissions,
                                  pricesIncludeTax:
                                      item.productPrices!.pricesIncludeTax,
                                  onlyAllowItemsToBeSoldInWholeNumbers:
                                      item
                                          .productPrices!
                                          .onlyAllowItemsToBeSoldInWholeNumbers,
                                  changeCostPriceDuringSale:
                                      item
                                          .productPrices!
                                          .changeCostPriceDuringSale,
                                  overrideDefaultCommission:
                                      item
                                          .productPrices!
                                          .overrideDefaultCommission,
                                  overrideDefaultTax:
                                      item.productPrices!.overrideDefaultTax,
                                  createdAt: item.productPrices!.createdAt,
                                  updatedAt: item.productPrices!.updatedAt,
                                  deletedAt: item.productPrices!.deletedAt,
                                  isEditableInSale:
                                      item.productPrices!.isEditableInSale,
                                )
                                : null,
                        productImages:
                            item.productImages != null
                                ? item.productImages!
                                    .map(
                                      (img) => ProductImage(
                                        id: img.id,
                                        productId: img.productId,
                                        path: img.path,
                                        createdAt: img.createdAt,
                                        updatedAt: img.updatedAt,
                                        deletedAt: img.deletedAt,
                                      ),
                                    )
                                    .toList()
                                : [],
                      );
                      return ProductCard(product: product, index: index);
                    },
                  ),
                ),
              ],
            ),

            Positioned(
              top: 50,
              left: 10,

              child: InkWell(
                onTap: () => Get.back(),
                child: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,

                  child: Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
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
                    // Add to Cart/Quantity buttons - Same logic as ProductCard
                    Expanded(
                      child: Obx(() {
                        bool isInCart = Get.find<CartController>()
                            .isProductInCart(controller.product.id!);
                        int quantity = Get.find<CartController>()
                            .getProductQuantity(controller.product.id!);

                        if (isInCart && quantity > 0) {
                          return _buildQuantitySelector(quantity);
                        } else {
                          return _buildAddToCartButton();
                        }
                      }),
                    ),

                    SizedBox(width: 12.w),

                    // Wishlist button
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
                          Get.find<WishlistController>().addToWishlist(
                            controller.product,
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

  // Add to Cart button - Same as ProductCard
  Widget _buildAddToCartButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      onPressed: () {
        Get.find<CartController>().addToCart(controller.product, quantity: 1);
      },
      icon: Icon(Icons.shopping_bag, color: Colors.white, size: 18.sp),
      label: Text(
        'Add to Cart',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  // Quantity selector - Same as ProductCard
  Widget _buildQuantitySelector(int quantity) {
    return Container(
      height: 42.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                () => Get.find<CartController>().decreaseQuantity(
                  controller.product.id!,
                ),
            icon: FaIcon(
              quantity == 1 ? FontAwesomeIcons.trash : FontAwesomeIcons.minus,
              size: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            quantity.toString(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.find<CartController>().increaseQuantity(
                controller.product.id!,
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.plus,
              size: 14.sp,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
