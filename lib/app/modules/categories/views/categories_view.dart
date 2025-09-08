import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      body: Obx(() {
        if (controller.ecomCategories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Selected category index
        final selectedIndex = controller.count.value;

        // Dummy product list for demo (replace with actual products for selected category)
        // final List<ProductData> products = [
        //   ProductData(
        //     id: 1,
        //     name: 'Naphthalene Balls (Super)',
        //     productImages: [ProductImage(path: 'https://i.imgur.com/1.png')],
        //     productPrices: ProductPrices(sellingPrice: '79'),
        //     totalSoldQuantity: 81,
        //   ),
        //   ProductData(
        //     id: 2,
        //     name: 'Hit Chalk Kills Cockroaches',
        //     productImages: [ProductImage(path: 'https://i.imgur.com/2.png')],
        //     productPrices: ProductPrices(sellingPrice: '23'),
        //     totalSoldQuantity: 19,
        //   ),
        //   ProductData(
        //     id: 3,
        //     name: 'Transtec Mosquito Bat TR-638',
        //     productImages: [ProductImage(path: 'https://i.imgur.com/3.png')],
        //     productPrices: ProductPrices(sellingPrice: '577'),
        //     totalSoldQuantity: 34,
        //   ),
        //   ProductData(
        //     id: 4,
        //     name: 'Hit Anti Roach Gel 20gm',
        //     productImages: [ProductImage(path: 'https://i.imgur.com/4.png')],
        //     productPrices: ProductPrices(sellingPrice: '225'),
        //     totalSoldQuantity: 8,
        //   ),
        // ];

        return Row(
          children: [
            // Vertical category tabs
            Container(
              width: 110,
              color: Colors.white,
              child: ListView.builder(
                itemCount: controller.ecomCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.ecomCategories[index];
                  final isSelected = selectedIndex == index;
                  return InkWell(
                    onTap: () => controller.count.value = index,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey[200] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border:
                            isSelected
                                ? Border.all(color: Colors.green, width: 2)
                                : null,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child:
                                  category.path != null &&
                                          category.path.toString().isNotEmpty
                                      ? Image.network(
                                        category.path.toString(),
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.image_not_supported,
                                                  size: 32,
                                                ),
                                      )
                                      : const Icon(
                                        Icons.category,
                                        size: 32,
                                        color: Colors.grey,
                                      ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              category.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isSelected ? Colors.green : Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  // Sort/Filter bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sort',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.keyboard_arrow_down),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Filters',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.filter_list),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //   // Product grid
                  //   Expanded(
                  //     child: GridView.builder(
                  //       padding: const EdgeInsets.all(8),
                  //       gridDelegate:
                  //           const SliverGridDelegateWithFixedCrossAxisCount(
                  //             crossAxisCount: 2,
                  //             childAspectRatio: 0.7,
                  //             crossAxisSpacing: 12,
                  //             mainAxisSpacing: 12,
                  //           ),
                  //       itemCount: products.length,
                  //       itemBuilder: (context, index) {
                  //         final product = products[index];
                  //         return ProductCard(product: product, index: index);
                  //       },
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
