import 'dart:ui';
import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/generated/assets.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/config/app_config.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/print_log.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/product_card.dart';
import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart'
    as BestSellingModel;
import 'package:ousadbazar/app/data/remote/repository/product/product_repository.dart';

import '../../../data/remote/model/product/product_review_response.dart';
import '../../../data/remote/model/product/related_product_response.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class ProductDetailsView extends StatefulWidget {
  final BestSellingModel.ProductData product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  BestSellingModel.ProductData get product => widget.product;

  final productDetails = [].obs;
  final imageList = [].obs;
  final productReview = <ProductReview>[].obs;
  final wishlistItem = false.obs;
  final relatedProducts = <RelatedProducts>[].obs;
  final isRelatedProductsLoading = true.obs;

  Future<void> getRelatedProduct() async {
    isRelatedProductsLoading.value = true;
    try {
      var response = await ProductRepository().getRelatedProduct(
        product.genericId.toString(),
      );
      if (response.data!.isNotEmpty) {
        relatedProducts.clear();
        relatedProducts.addAll(response.data ?? []);
        relatedProducts.removeWhere((item) => item.id == product.id);
      }
    } catch (e) {
      print('Error loading related products: $e');
    } finally {
      isRelatedProductsLoading.value = false;
    }
  }

  void getProductReview() async {
    var response = await ProductRepository().getProductReview(
      product.id.toString(),
    );

    if (response.status == 200) {
      //   productReview.addAll(response.data! as Iterable<ProductReview>);
    } else {
      printLog(response.message);
      AppWidgets().getSnackBar(message: response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    getRelatedProduct();
    return SafeArea(
      bottom: false,
      top: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          height: 50.h,
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
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          child: Row(
            children: [
              // Add to Cart/Quantity buttons - Same logic as ProductCard
              Expanded(
                child: Obx(() {
                  bool isInCart = Get.find<CartController>().isProductInCart(
                    product.id!,
                  );
                  int quantity = Get.find<CartController>().getProductQuantity(
                    product.id!,
                  );

                  if (isInCart && quantity > 0) {
                    return _buildQuantitySelector(quantity);
                  } else {
                    return _buildAddToCartButton();
                  }
                }),
              ),

              SizedBox(width: 12.w),
              /*
                    // Wishlist button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          wishlistItem.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              wishlistItem.value
                                  ? Colors.red
                                  : AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          Get.find<WishlistController>().addToWishlist(product);
                          wishlistItem.value = !wishlistItem.value;
                        },
                      ),
                    ),*/
            ],
          ),
        ),
        body: Stack(
          children: [
            ListView(
              physics: AlwaysScrollableScrollPhysics(),
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
                        controller: pageController,
                        itemCount: 1,
                        onPageChanged: (index) {
                          currentPage.value = index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              _showFullScreenImageDialog(context, index);
                            },
                            child: Hero(
                              tag: 'product-${product.id}',
                              child: AnyImageView(
                                imagePath:
                                    product.productImages != null &&
                                            product.productImages!.isNotEmpty
                                        ? '${AppConfig.imageBasePath}${product.productImages![index].path}'
                                        : Assets.pngNotFound,
                                width: double.infinity,
                                height: 350.h,
                                errorPlaceHolder: Assets.pngNotFound,
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
                                  product.productImages?.length ?? 1,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      pageController.animateToPage(
                                        index,
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                      _showFullScreenImageDialog(
                                        context,
                                        index,
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
                                              currentPage.value == index
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
                                              product.productImages != null &&
                                                      product
                                                          .productImages!
                                                          .isNotEmpty
                                                  ? '${AppConfig.imageBasePath}${product.productImages![index].path}'
                                                  : 'https://via.placeholder.com/46x46?text=No+Image',
                                          width: 46.w,
                                          height: 46.h,
                                          errorPlaceHolder: Assets.pngNotFound,
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
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(16.w),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category badge - Professional styling
                      if (product.category?.name != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor.withOpacity(0.1),
                                  AppColors.primaryColor.withOpacity(0.05),
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.08,
                                  ),
                                  blurRadius: 1,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              product.category!.name!.toUpperCase(),
                              style: TextStyle(
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                      // Product title
                      Container(
                        margin: EdgeInsets.only(bottom: 4.h),
                        child: Text(
                          product.name ?? 'Product Name',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            height: 1.3,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppWidgets().gapH(4.h),

                      // Stock availability indicator - Updated to match button logic
                      Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 16.sp,
                              color:
                                  _getTotalStock() > 0
                                      ? Colors.green
                                      : Colors.red,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              _getTotalStock() > 0
                                  ? 'In Stock (${_getTotalStock()} available)'
                                  : 'Out of Stock',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color:
                                    _getTotalStock() > 0
                                        ? Colors.green
                                        : Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Price section in Alibaba style (larger, with range format)
                      _buildPriceSection(product),

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
                              'Special Offer',
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
                                  'Ships from ${product.supplier?.country ?? product.supplier?.city ?? 'Bangladesh'}',
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
                                  'Lead time: ${product.stockBatches?.isNotEmpty == true ? '1'
                                          ' days' : '2 days'}',
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
                                  '${product.supplier?.companyName ?? 'Verified'} Seller',
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
                      if (product.generic?.name != null ||
                          product.category?.name != null ||
                          product.packSize?.quantity != null)
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
                                  if (product.generic?.name != null)
                                    _buildSpecificationRow(
                                      'Generic Name',
                                      product.generic!.name!,
                                      isFirst: true,
                                    ),
                                  if (product.generic?.category != null)
                                    _buildSpecificationRow(
                                      'Generic Category',
                                      product.generic!.category!,
                                    ),

                                  // Product Category
                                  if (product.category?.name != null)
                                    _buildSpecificationRow(
                                      'Product Category',
                                      product.category!.name!,
                                    ),

                                  // Product Unit Price
                                  if (product.productPrices?.sellingPrice !=
                                      null)
                                    _buildSpecificationRow(
                                      'Unit Selling Price',
                                      '৳${product.productPrices!.sellingPrice}',
                                    ),

                                  // Pack Size Information
                                  if (product.packSize?.name != null)
                                    _buildSpecificationRow(
                                      'Pack Size Name',
                                      product.packSize!.name!,
                                    ),
                                  if (product.packSize?.quantity != null)
                                    _buildSpecificationRow(
                                      'Pack Quantity',
                                      '${product.packSize!.quantity} ',
                                    ),
                                  if (product.packSize?.sellingPrice != null)
                                    _buildSpecificationRow(
                                      'Pack Selling Price',
                                      '৳${product.packSize!.sellingPrice}',
                                    ),

                                  // Additional Product Information
                                  if (product.productInventories?.quantity !=
                                      null)
                                    _buildSpecificationRow(
                                      'Available Stock',
                                      '${product.productInventories!.quantity} units',
                                    ),
                                  if (product.totalSoldQuantity != null)
                                    _buildSpecificationRow(
                                      'Total Sold',
                                      '${product.totalSoldQuantity} units',
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

                // Related Products Section with Shimmer
                Obx(() {
                  // Show loading, has products, or is empty
                  final showSection =
                      isRelatedProductsLoading.value ||
                      relatedProducts.isNotEmpty;

                  if (!showSection) {
                    return SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Related Products',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Products Grid
                      Container(
                        height: Get.height,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child:
                            isRelatedProductsLoading.value
                                ? _buildRelatedProductsShimmer()
                                : GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.66,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                      ),
                                  itemCount: relatedProducts.length,
                                  itemBuilder: (
                                    BuildContext context,
                                    int index,
                                  ) {
                                    final item = relatedProducts[index];
                                    final relatedProduct = BestSellingModel.ProductData(
                                      id: item.id,
                                      quantity: 0,
                                      addToCart: false,
                                      addToWishlist: false,
                                      name: item.name,
                                      genericId: item.genericId,
                                      categoryId: item.categoryId,
                                      supplierId: item.supplierId,
                                      pharmaSalesQuantity: null,
                                      ecommerceSalesQuantity: null,
                                      totalSoldQuantity: null,
                                      totalBalancedQuantity: null,
                                      generic:
                                          item.generic != null
                                              ? BestSellingModel.Generic(
                                                id: item.generic!.id,
                                                name: item.generic!.name,
                                                category:
                                                    item.generic!.category,
                                                status: item.generic!.status,
                                                createdBy:
                                                    item.generic!.createdBy,
                                                updatedBy:
                                                    item.generic!.updatedBy,
                                                createdAt:
                                                    item.generic!.createdAt,
                                                updatedAt:
                                                    item.generic!.updatedAt,
                                              )
                                              : null,
                                      category:
                                          item.category != null
                                              ? BestSellingModel.Category(
                                                id: item.category!.id,
                                                name: item.category!.name,
                                                shortOrder:
                                                    item.category!.shortOrder,
                                                createdAt:
                                                    item.category!.createdAt,
                                                updatedAt:
                                                    item.category!.updatedAt,
                                                status: item.category!.status,
                                                deletedAt: null,
                                              )
                                              : null,
                                      supplier:
                                          item.supplier != null
                                              ? BestSellingModel.Supplier(
                                                id: item.supplier!.id,
                                                firstName:
                                                    item.supplier!.firstName,
                                                lastName:
                                                    item.supplier!.lastName,
                                                address1:
                                                    item.supplier!.address1,
                                                address2:
                                                    item.supplier!.address2,
                                                city: item.supplier!.city,
                                                stateOrProvince:
                                                    item
                                                        .supplier!
                                                        .stateOrProvince,
                                                zip: item.supplier!.zip,
                                                country: item.supplier!.country,
                                                comments:
                                                    item.supplier!.comments,
                                                contact: item.supplier!.contact,
                                                email: item.supplier!.email,
                                                companyName:
                                                    item.supplier!.companyName,
                                                accountNo:
                                                    item.supplier!.accountNo,
                                                imagePath:
                                                    item.supplier!.imagePath,
                                                status: item.supplier!.status,
                                                createdAt:
                                                    item.supplier!.createdAt,
                                                updatedAt:
                                                    item.supplier!.updatedAt,
                                                type: item.supplier!.type,
                                                storeAccountBalance:
                                                    item
                                                        .supplier!
                                                        .storeAccountBalance,
                                                payAmount:
                                                    item.supplier!.payAmount,
                                                deletedAt:
                                                    item.supplier!.deletedAt,
                                                deletedBy:
                                                    item.supplier!.deletedBy,
                                              )
                                              : null,
                                      packSize:
                                          item.packSize != null
                                              ? BestSellingModel.PackSize(
                                                id: item.packSize!.id,
                                                productId:
                                                    item.packSize!.productId,
                                                name: item.packSize!.name,
                                                quantity:
                                                    item.packSize!.quantity,
                                                tp: item.packSize!.tp,
                                                vatPercent:
                                                    item.packSize!.vatPercent,
                                                vat: item.packSize!.vat,
                                                sellingPrice:
                                                    item.packSize!.sellingPrice,
                                                defaultUnit:
                                                    item.packSize!.defaultUnit,
                                                createdAt:
                                                    item.packSize!.createdAt,
                                                updatedAt:
                                                    item.packSize!.updatedAt,
                                                deletedAt:
                                                    item.packSize!.deletedAt,
                                              )
                                              : null,

                                      productPrices:
                                          item.productPrices != null
                                              ? BestSellingModel.ProductPrices(
                                                id: item.productPrices!.id,
                                                productId:
                                                    item
                                                        .productPrices!
                                                        .productId,
                                                costPriceWithoutTax:
                                                    item
                                                        .productPrices!
                                                        .costPriceWithoutTax,
                                                sellingPrice:
                                                    item
                                                        .productPrices!
                                                        .sellingPrice,
                                                tradePrice:
                                                    item
                                                        .productPrices!
                                                        .tradePrice,
                                                vat: item.productPrices!.vat,
                                                wholesale:
                                                    item
                                                        .productPrices!
                                                        .wholesale,
                                                wholesaleType:
                                                    item
                                                        .productPrices!
                                                        .wholesaleType,
                                                promoPrice:
                                                    item
                                                        .productPrices!
                                                        .promoPrice,
                                                promoStartDate:
                                                    item
                                                        .productPrices!
                                                        .promoStartDate,
                                                promoEndDate:
                                                    item
                                                        .productPrices!
                                                        .promoEndDate,
                                                disableFromPriceRules:
                                                    item
                                                        .productPrices!
                                                        .disableFromPriceRules,
                                                allowPriceOverrideRegardlessOfPermissions:
                                                    item
                                                        .productPrices!
                                                        .allowPriceOverrideRegardlessOfPermissions,
                                                pricesIncludeTax:
                                                    item
                                                        .productPrices!
                                                        .pricesIncludeTax,
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
                                                    item
                                                        .productPrices!
                                                        .overrideDefaultTax,
                                                createdAt:
                                                    item
                                                        .productPrices!
                                                        .createdAt,
                                                updatedAt:
                                                    item
                                                        .productPrices!
                                                        .updatedAt,
                                                deletedAt:
                                                    item
                                                        .productPrices!
                                                        .deletedAt,
                                                isEditableInSale:
                                                    item
                                                        .productPrices!
                                                        .isEditableInSale
                                                        ?.toString(),
                                                packQuantity:
                                                    item
                                                        .productPrices!
                                                        .packQuantity,
                                                ecomDiscountPercentage:
                                                    item
                                                        .productPrices!
                                                        .ecomDiscountPercentage,
                                                ecomDiscountAmount:
                                                    item
                                                        .productPrices!
                                                        .ecomDiscountAmount,
                                                ecomFinalSellingPrice:
                                                    item
                                                        .productPrices!
                                                        .ecomFinalSellingPrice,
                                              )
                                              : null,

                                      productLocations:
                                          null, // Different structure between models
                                      productImages:
                                          item.productImages != null
                                              ? item.productImages!
                                                  .map(
                                                    (img) =>
                                                        BestSellingModel.ProductImage(
                                                          id: img.id,
                                                          path: img.path,
                                                          productId: img.path,
                                                          createdAt:
                                                              img.createdAt,
                                                          updatedAt:
                                                              img.updatedAt,
                                                          deletedAt:
                                                              img.deletedAt,
                                                        ),
                                                  )
                                                  .toList()
                                              : [],
                                      stockBatches:
                                          item.stockBatches
                                              ?.map(
                                                (
                                                  batch,
                                                ) => BestSellingModel.StockBatch(
                                                  id: batch.id,
                                                  productId: batch.productId,
                                                  batchNo: batch.batchNo,
                                                  expiryDate: batch.expiryDate,
                                                  purchaseId: batch.purchaseId,
                                                  purchaseProductId:
                                                      batch.purchaseProductId,
                                                  purchaseBonusProductId:
                                                      batch
                                                          .purchaseBonusProductId,
                                                  receivedQuantity:
                                                      batch.receivedQuantity,
                                                  balancedQuantity:
                                                      batch.balancedQuantity,
                                                  locked: batch.locked,
                                                  createdAt: batch.createdAt,
                                                  updatedAt: batch.updatedAt,
                                                  saleReturnId:
                                                      batch.saleReturnId,
                                                  saleReturnProductId:
                                                      batch.saleReturnProductId,
                                                  cost: batch.cost,
                                                  reconciliationId:
                                                      batch.reconciliationId,
                                                  reconciliationProductId:
                                                      batch
                                                          .reconciliationProductId,
                                                  reconciliationQuantity:
                                                      batch
                                                          .reconciliationQuantity,
                                                  branchId: batch.branchId,
                                                  purchaseReturnId:
                                                      batch.purchaseReturnId,
                                                  purchaseReturnDetailId:
                                                      batch
                                                          .purchaseReturnDetailId,
                                                ),
                                              )
                                              .toList(),
                                    );
                                    return ProductCard(
                                      product: relatedProduct,
                                      index: index,
                                      promoPrice:
                                          product.productPrices?.sellingPrice
                                              ?.toString(),
                                      showDiscountTag: true,
                                    );
                                  },
                                ),
                      ),
                    ],
                  );
                }),
              ],
            ),

            Positioned(
              top: 50,
              left: 10,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
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
          ],
        ),
      ),
    );
  }

  // Full screen image dialog with zoom functionality
  void _showFullScreenImageDialog(BuildContext context, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        return _FullScreenImageDialog(
          images: product.productImages ?? [],
          initialIndex: initialIndex,
        );
      },
    );
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
    final bool isOutOfStock = _isOutOfStock();

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isOutOfStock ? Colors.grey[400] : AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        padding: EdgeInsets.symmetric(vertical: 12.h),
      ),
      onPressed:
          isOutOfStock
              ? null
              : () {
                Get.find<CartController>().addToCart(product, quantity: 1);
              },
      icon: Icon(
        isOutOfStock ? Icons.remove_shopping_cart : Icons.shopping_bag,
        color: Colors.white,
        size: 18.sp,
      ),
      label: Text(
        isOutOfStock ? 'Out of Stock' : 'Add to Cart',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  // Helper method to get total stock
  int _getTotalStock() {
    // First check stockBatches (like ProductCard does)
    final batches = product.stockBatches;
    if (batches != null && batches.isNotEmpty) {
      final totalStock = batches.fold<int>(
        0,
        (sum, batch) =>
            sum + (double.parse(batch.balancedQuantity.toString()).toInt()),
      );
      print(
        'DEBUG: Stock from stockBatches: $totalStock (batches: ${batches.length})',
      );
      return totalStock;
    }

    // Fallback to productInventories
    if (product.productInventories?.quantity != null) {
      final inventoryStock = int.parse(
        product.productInventories!.quantity.toString(),
      );
      print('DEBUG: Stock from productInventories: $inventoryStock');
      return inventoryStock;
    }

    // If no inventory info, return 0 to disable button instead of allowing purchases
    print('DEBUG: No stock info found, returning 0');
    return 0;
  }

  // Helper method to check if product is out of stock
  bool _isOutOfStock() {
    final totalStock = _getTotalStock();
    final outOfStock = totalStock <= 0;
    print('DEBUG: Total stock: $totalStock, Out of stock: $outOfStock');
    return outOfStock;
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
                () => Get.find<CartController>().decreaseQuantity(product.id!),
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
              final availableStock = _getTotalStock();

              if (quantity < availableStock) {
                Get.find<CartController>().increaseQuantity(product.id!);
              }
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

  // Price section in Alibaba style (larger, with range format)
  Widget _buildPriceSection(BestSellingModel.ProductData product) {
    final sellingPrice = product.productPrices?.sellingPrice?.toString() ?? '';
    final discountPrice =
        product.productPrices?.ecomFinalSellingPrice?.toString() ?? '';
    if (discountPrice.isNotEmpty &&
        sellingPrice.isNotEmpty &&
        discountPrice != sellingPrice) {
      return Row(
        children: [
          Text(
            '৳${double.parse(discountPrice).toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE51A19), // Alibaba's red color
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '৳$sellingPrice',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      );
    } else {
      return Text(
        sellingPrice.isNotEmpty ? '৳$sellingPrice' : 'Price not available',
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
          color: Color(0xFFE51A19), // Alibaba's red color
        ),
      );
    }
  }

  // Shimmer loading for related products
  Widget _buildRelatedProductsShimmer() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.66,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 4, // Show 4 skeleton items
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image Skeleton
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.r),
                      ),
                    ),
                  ),
                ),

                // Product Details Skeleton
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name
                        Container(
                          width: double.infinity,
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),

                        SizedBox(height: 6.h),

                        // Price
                        Container(
                          width: 60.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),

                        SizedBox(height: 6.h),

                        // Stock
                        Container(
                          width: 40.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),

                        Spacer(),

                        // Add to Cart Button
                        Container(
                          width: double.infinity,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _FullScreenImageDialog extends StatefulWidget {
  final List<dynamic> images;
  final int initialIndex;

  const _FullScreenImageDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageDialog> createState() => _FullScreenImageDialogState();
}

class _FullScreenImageDialogState extends State<_FullScreenImageDialog> {
  late PageController pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Backdrop filter
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.8)),
          ),

          // Image PageView
          PageView.builder(
            controller: pageController,
            itemCount: widget.images.isNotEmpty ? widget.images.length : 1,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final imagePath =
                  widget.images.isNotEmpty
                      ? '${AppConfig.imageBasePath}${widget.images[index].path}'
                      : Assets.pngNotFound;

              return Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: AnyImageView(
                    imagePath: imagePath,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          // Close button
          Positioned(
            top: 15.h,
            right: 15.w,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40.h,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: AppColors.white, size: 24.sp),
              ),
            ),
          ),

          // Page indicator (if multiple images)
          if (widget.images.length > 1)
            Positioned(
              bottom: 50.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (index) => Container(
                    width: 8.w,
                    height: 8.h,
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          currentIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
