import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/config/app_config.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
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
    return SizedBox(
      height: 0.35.sh, // Responsive height based on screen height
      child: Card(
        elevation: 2.r,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            width: 0.5.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image Stack - Responsive size
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsView(product: widget.product);
                          },
                        ),
                      ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: AnyImageView(
                          imagePath: getProductImage(),
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.contain,
                          errorWidget: AnyImageView(
                            imagePath: Assets.pngNotFound,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (widget.promoPrice.toString().isNotEmpty &&
                          getDiscountInfo() != null)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  getDiscountInfo()!['label'] == 'OFF'
                                      ? Colors.deepOrangeAccent
                                      : AppColors.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.r),
                                bottomRight: Radius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              '${getDiscountInfo()!['percent'].toStringAsFixed(0)}% ${getDiscountInfo()!['label']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
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
                              horizontal: 4.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8.r),
                                bottomLeft: Radius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              widget.showDiscountTag
                                  ? '${(((double.tryParse(widget.product.productPrices!.sellingPrice!.toString()) ?? 1) - (double.tryParse(widget.product.productPrices!.ecomFinalSellingPrice!.toString()) ?? 0)) / ((double.tryParse(widget.product.productPrices!.sellingPrice!.toString()) ?? 1)) * 100).abs().toStringAsFixed(2)}% OFF'
                                  : '',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 8.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 6.h),

              // Product Title - Flexible height
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap:
                      () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsView(product: widget.product);
                          },
                        ),
                      ),
                  child: Text(
                    getProductTitle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),

              SizedBox(height: 4.h),

              // Price Section - Flexible height
              Expanded(
                flex: 2,
                child: Builder(
                  builder: (context) {
                    final sellingPrice =
                        widget.product.productPrices?.sellingPrice
                            ?.toString() ??
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
                              '৳${double.parse(discountPrice).toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp,
                                color: AppColors.primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Flexible(
                            child: Text(
                              '৳$sellingPrice',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey[600],
                                decoration: TextDecoration.lineThrough,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      );
                    } else if (sellingPrice.isNotEmpty) {
                      return Text(
                        '৳$sellingPrice',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
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
              // Stock - Flexible height
              Expanded(
                flex: 2,
                child: Text(
                  'Stock: ${getTotalStock()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10.sp,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${double.parse(widget.product.productPrices!.packQuantity.toString()).toStringAsFixed(0)} ${widget.product.category?.name}\'s 1 '
                  '${widget.product.productPrices?.packName.toString()}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // SizedBox(height: 4.h),

              // Cart Section - Fixed at bottom
              Expanded(
                flex: 3,
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    final int stock = getTotalStock();
    final bool isOutOfStock = stock <= 0;

    return SizedBox(
      height: 50.h,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isOutOfStock ? Colors.grey[400] : AppColors.primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        onPressed:
            isOutOfStock
                ? null
                : () {
                  _showQuantitySelectionDialog();
                },
        icon: Icon(
          isOutOfStock ? Icons.remove_shopping_cart : Icons.shopping_bag,
          color: Colors.white,
          size: 14.sp,
        ),
        label: Text(
          isOutOfStock ? 'Out of Stock' : 'Add to Cart',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 10.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(int quantity) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: AppColors.primaryColor, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => cartController.decreaseQuantity(widget.product.id!),
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: FaIcon(
                quantity ==
                        int.parse(
                          widget.product.productPrices!.packQuantity.toString(),
                        )
                    ? FontAwesomeIcons.trash
                    : FontAwesomeIcons.minus,
                size: 10.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Text(
            quantity.toString(),
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              final availableStock = getTotalStock();
              if (quantity < availableStock &&
                  (quantity +
                          int.parse(
                            widget.product.productPrices!.packQuantity
                                .toString(),
                          )) <=
                      availableStock) {
                printLog(quantity);
                printLog(availableStock);

                cartController.increaseQuantity(widget.product.id!);
                widget.product.reactive;
              } else {
                AppWidgets().getSnackBar(
                  title: 'Stock Limit',
                  message: 'Cannot add more than available stock.',
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 10.sp,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showQuantitySelectionDialog() {
    final int availableStock = getTotalStock();
    printLog(availableStock);
    final int packQuantity = int.parse(
      widget.product.productPrices?.packQuantity?.toString() ?? '1',
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Quantity',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.red[200],
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Quantity Options
                  Container(
                    constraints: BoxConstraints(maxHeight: 300.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          _getQuantityOptions(
                            availableStock,
                            packQuantity,
                          ).length,
                      itemBuilder: (context, index) {
                        final quantity =
                            _getQuantityOptions(
                              availableStock,
                              packQuantity,
                            )[index];

                        final items = (quantity / packQuantity).ceil();

                        printLog(items);

                        return Center(
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              '$quantity ${widget.product.category?.name}\'s '
                              '$items ${widget.product.productPrices!.packName}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              cartController.addToCart(
                                widget.product,
                                quantity: quantity,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  // Footer
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.r),
                        bottomRight: Radius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Available Stock: $availableStock units',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<int> _getQuantityOptions(int availableStock, int packQuantity) {
    List<int> options = [];

    // Generate options based on pack quantity
    for (int i = 1; i <= 10; i++) {
      int quantity = packQuantity * i;
      if (quantity <= availableStock) {
        options.add(quantity);
      }
    }

    // If no pack-based options fit, add individual units up to available stock
    if (options.isEmpty) {
      for (int i = 1; i <= availableStock && i <= 20; i++) {
        options.add(i);
      }
    }

    return options;
  }
}
