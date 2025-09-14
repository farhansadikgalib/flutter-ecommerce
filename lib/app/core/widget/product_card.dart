import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/config/app_config.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/style/app_colors.dart';
import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:turi/app/modules/product_details/views/product_details_view.dart';
import 'package:turi/app/routes/app_pages.dart';
import 'package:turi/generated/assets.dart';
import '../../modules/cart/controllers/cart_controller.dart';

class ProductCard extends StatefulWidget {
  final ProductData product;
  final int index;
  final promoPrice; // Example promo price

  const ProductCard({
    super.key,
    required this.product,
    required this.index,
    this.promoPrice,
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
    return widget.product.productPrices?.sellingPrice ?? '0';
  }

  String getOfferedPrice() {
    return widget.promoPrice ?? getSellingPrice();
  }

  /// Returns a tuple: (percent, label) where label is 'OFF' or 'UP'
  Map<String, dynamic>? getDiscountInfo() {
    final selling = double.tryParse(getOfferedPrice()) ?? 0;
    final promo = double.tryParse(getSellingPrice()) ?? 0;
    // Only show discount if both prices are > 0 and not equal
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
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.primaryColor.withOpacity(0.5),
            width: 1,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  AnyImageView(
                    imagePath: getProductImage(),
                    height: 120,
                    width: 120,
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
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              getDiscountInfo()!['label'] == 'OFF'
                                  ? Colors.redAccent
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
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,

                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        '${double.parse((double.parse(widget.product.productPrices!.ecomFinalSellingPrice.toString()) - double.parse(widget.product.productPrices!.sellingPrice.toString()) / 100).toString()).toStringAsFixed(2)}% OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  getProductTitle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 6),

              // Price Section
              Builder(
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
                        Text(
                          double.parse(discountPrice).toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          sellingPrice,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    );
                  } else if (sellingPrice.isNotEmpty) {
                    return Text(
                      sellingPrice,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
              SizedBox(height: 6),

              //stock
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Stock: ${getTotalStock()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              Spacer(),
              // Cart Section - Show quantity selector if in cart, otherwise show add button
              Obx(() {
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
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      onPressed: () {
        cartController.addToCart(widget.product, quantity: 1);
      },
      icon: Icon(Icons.shopping_bag, color: Colors.white, size: 18),
      label: Text(
        'Add to Cart',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
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
