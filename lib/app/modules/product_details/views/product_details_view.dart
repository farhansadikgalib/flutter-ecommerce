import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/modules/home/controllers/home_controller.dart';
import 'package:turi/app/modules/product_details/controllers/product_details_controller.dart';

import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../cart/controllers/cart_controller.dart';

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
        appBar: globalAppBar(context, 'Product Details'),
        body: Stack(
          children: [
            ListView(
              children: [
                // Product Image Carousel
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: controller.pageController,
                        itemCount: controller.imageList.length,
                        onPageChanged: (index) {
                          controller.currentPage.value = index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return AnyImageView(
                            imagePath:
                                '${AppConfig.imageBasePath}${controller.imageList[index].image}',
                            width: double.infinity,
                            height: 300,
                          );
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            controller.imageList.length, //
                            // Number of
                            // images
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width:
                                  controller.currentPage.value == index
                                      ? 12
                                      : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color:
                                    controller.currentPage.value == index
                                        ? AppColors.primaryColor
                                        : AppColors.secondaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Product Info Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.product.title.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${controller.product.offered.toString()} BDT',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${controller.product.selling.toString()} BDT',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      int.parse(controller.product.reviewCount.toString()) > 0
                          ? Row(
                            children: List.generate(
                              int.parse(
                                controller.product.reviewCount.toString(),
                              ),
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                            ),
                          )
                          : Row(
                            children: List.generate(
                              5,
                              (index) => const Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Shipping Info
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Ships to:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            'Worldwide',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Delivery:',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          Text(
                            '5-10 Business Days',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Expandable Sections
                ExpansionTile(
                  textColor: AppColors.black,
                  iconColor: AppColors.black,
                  title: const Text('Specifications'),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                          controller.productDetails.isEmpty?'':
                        controller.productDetails.first.metaDescription
                            .toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  textColor: AppColors.black,
                  iconColor: AppColors.black,
                  title: const Text('Reviews & Ratings'),
                  children: [
                    Text(
                      'No Review Found',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    /*

                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/50',
                        ),
                      ),
                      title: const Text('John Doe'),
                      subtitle: const Text('Great product! Highly recommend.'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
*/
                  ],
                ),
              ],
            ),

            // Floating Action Buttons at the Bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      /*child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Add to Cart'),
                      ),*/
                      child: Visibility(
                        visible: controller.product.addToCart!,
                        replacement: Container(
                          margin: REdgeInsets.symmetric(horizontal: 14),
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                                // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (controller.product.quantity! > 1) {
                                    controller.product.quantity =
                                        controller.product.quantity! - 1;

                                    Get.find<CartController>().cartProducts
                                        .forEach((element) {
                                          if (element.id ==
                                              controller.product.id) {
                                            element.quantity =
                                                controller.product.quantity;
                                          }
                                        });

                                    Get.find<HomeController>().homeElements
                                        .refresh();
                                  } else {
                                    controller.product.addToCart = true;
                                    Get.find<HomeController>().homeElements
                                        .refresh();
                                    Get.find<HomeController>()
                                        .cartCount
                                        .value--;

                                    Get.find<CartController>().cartProducts
                                        .removeAt(
                                          Get.find<CartController>()
                                              .cartProducts
                                              .indexWhere(
                                                (element) =>
                                                    element.id ==
                                                    controller.product.id,
                                              ),
                                        );

                                    Get.find<HomeController>().cartCount
                                        .refresh();
                                  }
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: AppColors.primaryColor,
                                  size: 14,
                                ),
                              ),

                              Text(
                                controller.product.quantity!.toString(),
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  controller.product.quantity =
                                      controller.product.quantity! + 1;

                                  Get.find<CartController>().cartProducts
                                      .forEach((element) {
                                        if (element.id ==
                                            controller.product.id) {
                                          element.quantity =
                                              controller.product.quantity;
                                        }
                                      });
                                  Get.find<HomeController>().homeElements
                                      .refresh();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: AppColors.primaryColor,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.product.quantity = 1;
                            controller.product.addToCart = false;
                            Get.find<HomeController>().cartCount.value++;
                            Get.find<CartController>().cartProducts.add(
                              controller.product,
                            );
                            Get.find<HomeController>().cartCount.refresh();
                            Get.find<HomeController>().homeElements.refresh();
                          },
                          child: Text(
                            '+ Add to Cart',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
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
}
