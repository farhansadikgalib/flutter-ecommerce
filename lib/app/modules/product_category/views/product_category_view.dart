import 'package:any_image_view/any_image_view.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/data/remote/model/home/best_selling_product_response.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/debounce_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/global_appbar.dart';
import '../../../core/widget/product_card.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_category_controller.dart';

class ProductCategoryView extends GetView<ProductCategoryController> {
  const ProductCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CartController);
    return Obx(() {
      return Scaffold(
        key: controller.scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar:
            controller.fromSearch
                ? AppBar(
                  elevation: 0.0,
                  titleSpacing: -20,
                  centerTitle: false,
                  backgroundColor: AppColors.white,
                  leading: InkWell(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  title: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    height: 50.h,
                    width: Get.width / 1.10,
                    padding: REdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: TextField(
                      cursorColor: AppColors.primaryColor,
                      cursorHeight: 20,
                      controller: controller.searchController.value,
                      focusNode: controller.searchFocusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'What are you looking for?',
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      ),
                      onChanged: (value) {
                        controller.debounceHelper.debounce(
                          tag: DebounceHelper.searchTextTag,
                          onMethod: () {
                            controller.searchProducts(value);
                          },
                          time: 500,
                        );
                      },
                    ),
                  ),
                )
                : globalAppBar(context, controller.itemName),
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: REdgeInsets.only(left: 10, bottom: 50, top: 20),
                  children: [
                    AppWidgets().gapH8(),
                    Visibility(
                      visible: controller.category.isNotEmpty,
                      child: Text(
                        'Categories',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    /*           Obx(
                      () => Column(
                        children:
                            controller.category
                                .map(
                                  (category) => CheckboxListTile(
                                    title: Text(category.title ?? ''),
                                    value: category.isSelected ?? false,
                                    onChanged: (value) {
                                      category.isSelected = value;
                                      printLog(
                                        'Selected Category ID: ${category.id}',
                                      );
                                      controller.category.refresh();
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ),*/
                    Visibility(
                      visible: controller.category.isNotEmpty,
                      child: Divider(),
                    ),
                    // Brands
                    Visibility(
                      visible: controller.brands.isNotEmpty,
                      child: Text(
                        'Brands',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => Column(
                        children:
                            controller.brands
                                .map(
                                  (brand) => CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColors.primaryColor,
                                    dense: true,
                                    title: Text(brand.title ?? ''),
                                    value: brand.isSelected ?? false,
                                    onChanged: (value) {
                                      brand.isSelected = value;
                                      printLog(
                                        'Selected Brand ID: ${brand.id}',
                                      );
                                      controller.brands.refresh();
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    Divider(),
                    // Collections
                    Visibility(
                      visible: controller.collections.isNotEmpty,
                      child: Text(
                        'Collections',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => Column(
                        children:
                            controller.collections
                                .map(
                                  (collection) => CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColors.primaryColor,
                                    dense: true,
                                    title: Text(collection.title ?? ''),
                                    value: collection.isSelected ?? false,
                                    onChanged: (value) {
                                      collection.isSelected = value;
                                      printLog(
                                        'Selected Collection ID: ${collection.id}',
                                      );
                                      controller.collections.refresh();
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    Divider(),

                    // Delivery Type
                    Visibility(
                      visible: controller.deliveryType.isNotEmpty,
                      child: Text(
                        'Delivery Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                      () => Column(
                        mainAxisSize: MainAxisSize.min,
                        children:
                            controller.deliveryType
                                .map(
                                  (deliveryType) => RadioListTile(
                                    activeColor: AppColors.primaryColor,
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(deliveryType.title ?? ''),
                                    value: deliveryType.id,
                                    dense: true,
                                    groupValue:
                                        controller.deliveryType
                                            .firstWhereOrNull(
                                              (type) => type.isSelected == true,
                                            )
                                            ?.id,
                                    onChanged: (value) {
                                      controller.deliveryType.forEach((type) {
                                        type.isSelected = type.id == value;
                                      });
                                      printLog(
                                        'Selected Delivery Type ID: $value',
                                      );
                                      controller.deliveryType.refresh();
                                    },
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    Divider(),
                    // Price Range
                    Text(
                      'Price Range',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RangeSlider(
                      activeColor: AppColors.primaryColor,
                      inactiveColor: AppColors.gray,
                      values: controller.priceRange.value,
                      min: 0,
                      max: 1000,
                      divisions: 20,
                      labels: RangeLabels(
                        controller.priceRange.value.start.round().toString(),
                        controller.priceRange.value.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        controller.priceRange.value = values;
                        printLog(
                          'Price Range: ${values.start} - ${values.end}',
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.filterProducts();
                        },
                        child: Text(
                          'Apply Filters',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Apply Button
        ),

        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.isLoading.isTrue) {
                      return Skeletonizer(
                        enabled: controller.isLoading.value,
                        child: DynamicHeightGridView(
                          crossAxisCount: 2,
                          itemCount: 4,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          builder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(8.0),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Container(
                                      color: AppColors.secondaryColor,
                                      height: 125,
                                      width: 125,
                                    ),
                                    AppWidgets().gapH(4),
                                    Text(
                                      'Product Title',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    AppWidgets().gapH(4),
                                    Text(
                                      "Stock 00",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    AppWidgets().gapH(4),
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '9999',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "  99999 BDT",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AppWidgets().gapH8(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        side: BorderSide(
                                          color: Colors.transparent,
                                        ), // Set the border
                                        // color to grey
                                      ),
                                      child: Text(
                                        '+ Add to Bag',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                        ),
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

                    if (controller.fromSearch) {
                      return Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.66,
                                  ),
                              itemCount: controller.searchProductList.length,
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item =
                                    controller.searchProductList[index];
                                final product = ProductData(
                                  id: item.id,
                                  name: item.name,
                                  addToCart: false,
                                  quantity: 0,
                                  categoryId: item.categoryId,
                                );
                                return ProductCard(
                                  product: product,
                                  index: index,
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    if (controller.categoryProducts.isEmpty) {
                      return Center(
                        child: Text(
                          controller.fromSearch
                              ? 'Search Now !'
                              : 'No Products Found!',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.66,
                      ),
                      itemCount: controller.categoryProducts.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = controller.categoryProducts[index];
                        final product = ProductData(
                          id: item.id,
                          name: item.name,
                          quantity: 1,
                          addToCart: true,
                        );
                        return ProductCard(product: product, index: index);
                      },
                    );
                  }),
                ),
              ],
            ),

            Visibility(
              visible:
                  controller.categoryProducts.isNotEmpty &&
                  !controller.fromSearch,
              child: Positioned(
                top: MediaQuery.of(context).size.height / 2 - 28,
                child: InkWell(
                  onTap: () {
                    controller.scaffoldKey.currentState?.openDrawer();
                  },
                  child: Container(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),

                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.filter,
                          color: AppColors.white,
                          size: 16,
                        ),
                        AppWidgets().gapW(4),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
