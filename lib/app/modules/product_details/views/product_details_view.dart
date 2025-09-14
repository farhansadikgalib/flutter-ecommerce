import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:turi/generated/assets.dart';

import '../../../core/config/app_config.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/print_log.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/product_card.dart';
import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart'
    hide Supplier, Category, PackSize, ProductPrices;
import 'package:turi/app/data/remote/model/product/product_details_response.dart'
    hide ProductPrices, PackSize, Supplier, Category, Generic;
import 'package:turi/app/data/remote/repository/product/product_repository.dart';

import '../../../data/remote/model/product/product_review_response.dart';
import '../../../data/remote/model/product/related_product_response.dart';
import '../../cart/controllers/cart_controller.dart';
import '../../wishlist/controllers/wishlist_controller.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductData product;

  const ProductDetailsView({super.key, required this.product});

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  ProductData get product => widget.product;

  final productDetails = [].obs;
  final imageList = [].obs;
  final productReview = <ProductReview>[].obs;
  final wishlistItem = false.obs;
  final relatedProducts = <RelatedProducts>[].obs;

  getRelatedProduct() async {
    var response = await ProductRepository().getRelatedProduct(
      product.genericId.toString(),
    );
    if (response.data!.isNotEmpty) {
      relatedProducts.clear();
      relatedProducts.addAll(response.data ?? []);
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
    return Obx(() {
      return Scaffold(
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
                            onTap: () {},
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
                                      // pageanimateToPage(
                                      //   index,
                                      //   duration: Duration(milliseconds: 300),
                                      //   curve: Curves.easeInOut,
                                      // );
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
                      // Category badge
                      if (product.category?.name != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            product.category!.name!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),

                      // Product title with slightly smaller font than Amazon
                      Text(
                        product.name ?? 'Product Name',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      // Stock availability indicator
                      if (product.productInventories?.quantity != null)
                        Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 16.sp,
                                color:
                                    int.parse(
                                              product
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
                                          product.productInventories!.quantity
                                              .toString(),
                                        ) >
                                        0
                                    ? 'In Stock (${product.productInventories!.quantity} available)'
                                    : 'Out of Stock',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color:
                                      int.parse(
                                                product
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
                                  'Lead time: ${product.stockBatches?.isNotEmpty == true ? '1-2'
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

                Container(
                  height: Get.height,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.66,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                    ),
                    itemCount: relatedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = relatedProducts[index];

                      // Create a simplified ProductData for related products
                      final relatedProduct = ProductData(
                        id: item.id,
                        quantity: 0,
                        addToCart: false,
                        addToWishlist: false,
                        name: item.name,
                        genericId: item.genericId,
                        categoryId: item.categoryId,
                        supplierId: item.supplierId,
                        // Use null for complex nested objects to avoid type conflicts
                        generic: null,
                        category: null,
                        supplier: null,
                        packSize: null,
                        productPrices: null,
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
                        // Add other required fields with default values
                        productInventories: null,
                        stockBatches: null,
                        totalSoldQuantity: null,
                      );

                      return ProductCard(product: relatedProduct, index: index);
                    },
                  ),
                ),
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
                            .isProductInCart(product.id!);
                        int quantity = Get.find<CartController>()
                            .getProductQuantity(product.id!);

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
        Get.find<CartController>().addToCart(product, quantity: 1);
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
              Get.find<CartController>().increaseQuantity(product.id!);
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
  Widget _buildPriceSection(ProductData product) {
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
}
