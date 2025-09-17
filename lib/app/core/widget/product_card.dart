import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/config/app_config.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
import 'package:ousadbazar/app/core/style/app_colors.dart';
import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:ousadbazar/app/modules/product_details/views/product_details_view.dart';
import 'package:ousadbazar/generated/assets.dart';
import '../../modules/cart/controllers/cart_controller.dart';

class ProductCard extends StatefulWidget {
  final ProductData product;
  final int index;
  final promoPrice;
  final bool showDiscountTag;

  const ProductCard({
    super.key,
    required this.product,
    required this.index,
    this.promoPrice,
    this.showDiscountTag = false,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
    getDiscountInfo();
  }

  String getProductImage() {
    if (widget.product.productImages != null &&
        widget.product.productImages!.isNotEmpty) {
      return '${AppConfig.imageBasePath}${widget.product.productImages?.first.path}';
    }
    return '${AppConfig.imageBasePath}default.png';
  }

  String getProductTitle() {
    // Use name as title
    return widget.product.name ?? '';
  }

  String getSellingPrice() {
    return widget.product.productPrices?.sellingPrice.toString() ?? '0';
  }

  String getOfferedPrice() {
    return widget.promoPrice ?? '0';
  }

  /// Returns a tuple: (percent, label) where label is 'OFF' or 'UP'
  Map<String, dynamic>? getDiscountInfo() {
    final selling = double.tryParse(getOfferedPrice()) ?? 0;
    final promo = double.tryParse(getSellingPrice()) ?? 0;
    // Only show discount if both prices are > 0 and not equal

    // printLog('selling: $selling, promo: $promo');
    if (selling > 0 && promo > 0 && promo != selling) {
      double percent = ((promo - selling).abs() / selling) * 100;
      String label = promo < selling ? 'OFF' : 'UP';
      return {'percent': percent, 'label': label};
    }
    return null;
  }

  int getTotalStock() {
    final batches = widget.product.stockBatches;
    if (batches == null || batches.isEmpty) return 0;
    return batches.fold<int>(
      0,
          (sum, batch) =>
      sum + (double.parse(batch.balancedQuantity.toString()).toInt()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        printLog('clicked: ${widget.product.name}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductDetailsView(product: widget.product);
            },
          ),
        );
      },
      child: SizedBox(
        height: 280.h, // Fixed card height
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.primaryColor.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image Stack - Fixed size
                SizedBox(
                  height: 100.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnyImageView(
                        imagePath: getProductImage(),
                        height: 100.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(16),
                        errorWidget: AnyImageView(
                          imagePath: Assets.pngNotFound,
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (widget.promoPrice.toString().isNotEmpty &&
                          getDiscountInfo() != null)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: getDiscountInfo()!['label'] == 'OFF'
                                  ? Colors.deepOrangeAccent
                                  : AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              '${getDiscountInfo()!['percent'].toStringAsFixed(0)}% ${getDiscountInfo()!['label']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Visibility(
                          visible: widget.showDiscountTag,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: Text(
                              widget.showDiscountTag
                                  ? '${(((double.tryParse(widget.product.productPrices!.sellingPrice!.toString()) ?? 1) - (double.tryParse(widget.product.productPrices!.ecomFinalSellingPrice!.toString()) ?? 0)) / ((double.tryParse(widget.product.productPrices!.sellingPrice!.toString()) ?? 1)) * 100).abs().toStringAsFixed(2)}% OFF'
                                  : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Product Title - Fixed height container
                SizedBox(
                  height: 35.h,
                  child: Text(
                    getProductTitle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 4.h),

                // Price Section - Fixed height
                SizedBox(
                  height: 20.h,
                  child: Builder(
                    builder: (context) {
                      final sellingPrice =
                          widget.product.productPrices?.sellingPrice?.toString() ??
                              '';
                      final discountPrice =
                          widget.product.productPrices?.ecomFinalSellingPrice
                              ?.toString() ??
                              '';
                      if (discountPrice.isNotEmpty &&
                          sellingPrice.isNotEmpty &&
                          discountPrice != sellingPrice) {
                        return Row(
                          children: [
                            Flexible(
                              child: Text(
                                double.parse(discountPrice).toStringAsFixed(2),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Flexible(
                              child: Text(
                                sellingPrice,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        );
                      } else if (sellingPrice.isNotEmpty) {
                        return Text(
                          sellingPrice,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),

                SizedBox(height: 4.h),

                // Stock - Fixed height
                SizedBox(
                  height: 15.h,
                  child: Text(
                    'Stock: ${getTotalStock()}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: 6.h),

                // Cart Section - Fixed at bottom
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Obx(() {
                      bool isInCart = cartController.isProductInCart(
                        widget.product.id!,
                      );
                      int quantity = cartController.getProductQuantity(
                        widget.product.id!,
                      );

                      if (isInCart && quantity > 0) {
                        return _buildQuantitySelector(quantity);
                      } else {
                        return _buildAddToCartButton();
                      }
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(width: Get.width,
    child:  ElevatedButton.icon(

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: REdgeInsets.symmetric(vertical: 10,horizontal: 10),
      ),
      onPressed: () {
        cartController.addToCart(widget.product, quantity: 1);
      },
      icon: Icon(Icons.shopping_bag, color: Colors.white, size: 18),
      label: Text(
        'Add to Cart',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ));
  }

  Widget _buildQuantitySelector(int quantity) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed:
                () => cartController.decreaseQuantity(widget.product.id!),
            icon: FaIcon(
              quantity == 1 ? FontAwesomeIcons.trash : FontAwesomeIcons.minus,
              size: 14,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            quantity.toString(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              cartController.increaseQuantity(widget.product.id!);
              widget.product.reactive;
            },
            icon: FaIcon(
              FontAwesomeIcons.plus,
              size: 14,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
