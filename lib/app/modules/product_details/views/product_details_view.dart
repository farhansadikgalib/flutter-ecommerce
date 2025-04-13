import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/modules/product_details/controllers/product_details_controller.dart';

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
                        itemCount: controller.productDetails.first.images!.length,
                        onPageChanged: (index) {
                          controller.currentPage.value = index;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return AnyImageView(
                            imagePath: '${AppConfig.imageBasePath}${controller.productDetails.first.images![index].image}',
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
                          children: List.generate(controller.productDetails.first.images!.length, // Number of images
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
                                        ? Colors.orange
                                        : Colors.grey,
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
                  title: const Text('Specifications'),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '• Size: Medium\n• Color: Red\n• Material: Cotton',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: const Text('Reviews & Ratings'),
                  children: [
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
                  ],
                ),
                ExpansionTile(
                  title: const Text('Seller Information'),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Seller: ABC Store\nLocation: China\nRating: 4.5/5',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
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
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('Add to Cart'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Buy now logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Buy Now'),
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
