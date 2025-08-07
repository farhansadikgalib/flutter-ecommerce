import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import 'package:turi/app/modules/cart/controllers/cart_controller.dart';
import 'package:turi/app/modules/wishlist/controllers/wishlist_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../../routes/app_pages.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Wishlist', showBackButton: false),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildSkeletonLoading();
        } else {
          if (controller.wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty_order.png',
                    height: 120,
                    width: 120,
                    errorBuilder:
                        (ctx, obj, stack) => Icon(
                          Icons.favorite,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Your Wishlist is Empty',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Add items to your wishlist to keep track of products you love.',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed(Routes.DASHBOARD),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.getWishlist,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.wishlistItems.length,
              itemBuilder: (context, index) {
                final item = controller.wishlistItems[index];
                return InkWell(
                  onTap: (){
                    var product = ProductCollection(id: item.id,
                      productId: item.productId,
                      createdAt: item.createdAt,
                      updatedAt: item.updatedAt,
                        addToCart: false,
                    );
                    Get.toNamed(
                      Routes.PRODUCT_DETAILS,
                      arguments: {'product': product },
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: AppColors.primaryColor
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: '${AppConfig.imageBasePath}${item.product?.image}' ?? '',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) => Container(
                                    color: Colors.grey[200],
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey[200],
                                    child: const Icon(Icons.error),
                                  ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product?.title ?? 'No Title',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  ''
                                  '${item.product?.selling ?? 0} BDT',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColors.primaryColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),

                                      onPressed: () {
                                                                 },
                                      icon: const Icon(Icons.shopping_cart,
                                        color: AppColors.primaryColor,),
                                      label: const Text('Add to Cart',style:
                                      TextStyle(color: AppColors.primaryColor),),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        controller.wishlistAction(
                                          item.productId.toString(),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 35,
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
                  ),
                );
              },
            ),
          );
        }
      }),
    );
  }

  Widget _buildSkeletonLoading() {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 5),
        itemCount: 4, // Show 5 skeleton items while loading
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: "item.product?.image ",
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "item.product?.title ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '{item.product?.selling',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                // Add to cart functionality
                              },
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Add to Cart'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
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
          );
        },
      ),
    );
  }
}
