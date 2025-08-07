import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:any_image_view/any_image_view.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/config/app_config.dart';
import 'package:turi/app/core/style/app_colors.dart';
import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart';
import 'package:turi/app/routes/app_pages.dart';
import '../../modules/cart/controllers/cart_controller.dart';

class ProductCard extends StatefulWidget {
  final ProductData product;
  final int index;

  const ProductCard({super.key, required this.product, required this.index});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CartController cartController = Get.find<CartController>();

  @override
  void initState() {
    super.initState();
  }

  String getProductImage() {
    if (widget.product.productImages != null &&
        widget.product.productImages!.isNotEmpty) {
      return '${AppConfig.imageBasePath}${widget.product.productImages![0]}';
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
    // Example: if you have an offer price, otherwise use selling price
    return widget.product.productPrices?.promoPrice?.toString() ??
        getSellingPrice();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT_DETAILS,
          arguments: {'product': widget.product},
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
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: AnyImageView(
                  imagePath: getProductImage(),
                  height: 120,
                  width: 120,
                  cachedNetPlaceholderHeight: 120,
                  cachedNetPlaceholderWidth: 120,
                ),
              ),
              SizedBox(height: 10),
              Text(
                getProductTitle(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 6),
              Row(
                children: [
                  if (getSellingPrice() != getOfferedPrice())
                    Text(
                      '${getSellingPrice()} BDT',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  SizedBox(width: 6),
                  Text(
                    '${getOfferedPrice()} BDT',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
            onPressed:
                () {
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
