import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/data/remote/model/home/home_response.dart';
import 'package:turi/app/modules/home/controllers/home_controller.dart';
import '../../../core/config/app_config.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/style/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_category_controller.dart';

class ProductCategoryView extends GetView<ProductCategoryController> {
  const ProductCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Obx(() {
      return Scaffold(
        key: scaffoldKey,
        appBar: globalAppBar(context, controller.categoryName),
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
                    Obx(
                          () =>
                          Column(
                            children:
                            controller.category
                                .map(
                                  (category) =>
                                  CheckboxListTile(
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
                    ),
                    Visibility(
                        visible: controller.category.isNotEmpty,
                        child: Divider()),
                    // Brands
                    Visibility(
                      visible: controller.brands.isNotEmpty,
                      child: Text(
                        'Brands',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Obx(
                          () =>
                          Column(
                            children:
                            controller.brands
                                .map(
                                  (brand) =>
                                  CheckboxListTile(
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
                          () =>
                          Column(
                            children:
                            controller.collections
                                .map(
                                  (collection) =>
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    activeColor: AppColors.primaryColor,
                                    dense: true,
                                    title: Text(collection.title ?? ''),
                                    value: collection.isSelected ?? false,
                                    onChanged: (value) {
                                      collection.isSelected = value;
                                      printLog(
                                        'Selected Collection ID: ${collection
                                            .id}',
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
                          () =>
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children:
                            controller.deliveryType
                                .map(
                                  (deliveryType) =>
                                  RadioListTile(
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
                    if(controller.isLoading.isTrue) {
                      return Skeletonizer(
                        enabled: controller.isLoading.value,
                        child:  DynamicHeightGridView(
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
                                              TextDecoration
                                                  .lineThrough,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "  99999 BDT",
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color:
                                              AppColors.primaryColor,
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

                    if (controller.categoryProducts.isEmpty) {
                      return Center(
                        child: Text(
                          'No Products Found',
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
                        childAspectRatio: 0.62,
                      ),
                      itemCount: controller.categoryProducts.length,
                      shrinkWrap: true,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final product = controller.categoryProducts[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.PRODUCT_DETAILS,
                              arguments: {
                                'product': ProductCollection(
                                  id: product.id,
                                  title: product.title,
                                  slug: product.slug,
                                  image: product.image,
                                  selling: product.selling,
                                  offered: product.offered,
                                  price: product.price,
                                  reviewCount: product.reviewCount,
                                  rating: product.rating,
                                  quantity: 1,
                                  endTime: product.endTime,
                                  addToCart: true,
                                ),
                              },
                            );
                          },
                          child: AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                child: Card(
                                  margin: EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          '${AppConfig.imageBasePath}${product
                                              .image}',
                                          cacheHeight: 125,
                                          cacheWidth: 125,
                                        ),
                                        AppWidgets().gapH(4),
                                        Text(
                                          '${product.title}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        /*AppWidgets().gapH(4),
                                                Text(
                                                  "Stock ${product.product!.quantity}",
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),*/
                                        AppWidgets().gapH(6),
                                        RichText(
                                          text: TextSpan(
                                            style: TextStyle(
                                                color: Colors.black),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: product.selling
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                "  ${product.offered
                                                    .toString()} BDT",
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
                                        Visibility(
                                          visible: product.addToCart!,
                                          replacement: Container(
                                            margin: REdgeInsets.symmetric(
                                              horizontal: 14,
                                            ),
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius: BorderRadius
                                                  .circular(
                                                8,
                                              ),
                                              border: Border.all(
                                                color: AppColors.primaryColor,
                                                width: 1,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(
                                                    0.2,
                                                  ),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 1),
                                                  // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (product.quantity! > 1) {
                                                      product.quantity =
                                                          product.quantity! - 1;

                                                      Get
                                                          .find<
                                                          CartController>()
                                                          .cartProducts
                                                          .forEach((element) {
                                                        if (element.id ==
                                                            product.id) {
                                                          element.quantity =
                                                              product
                                                                  .quantity;
                                                        }
                                                      });

                                                      Get
                                                          .find<
                                                          HomeController>()
                                                          .homeElements
                                                          .refresh();
                                                    } else {
                                                      product.addToCart = true;
                                                      Get
                                                          .find<
                                                          HomeController>()
                                                          .homeElements
                                                          .refresh();
                                                      Get
                                                          .find<
                                                          HomeController>()
                                                          .cartCount
                                                          .value--;

                                                      Get
                                                          .find<
                                                          CartController>()
                                                          .cartProducts
                                                          .removeAt(
                                                        Get
                                                            .find<
                                                            CartController
                                                        >()
                                                            .cartProducts
                                                            .indexWhere(
                                                              (element) =>
                                                          element
                                                              .id ==
                                                              product.id,
                                                        ),
                                                      );

                                                      Get
                                                          .find<
                                                          HomeController>()
                                                          .cartCount
                                                          .refresh();
                                                    }
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.minus,
                                                    color: AppColors
                                                        .primaryColor,
                                                    size: 14,
                                                  ),
                                                ),

                                                Text(
                                                  product.quantity!.toString(),
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .primaryColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                IconButton(
                                                  onPressed: () {
                                                    product.quantity =
                                                        product.quantity! + 1;

                                                    Get
                                                        .find<CartController>()
                                                        .cartProducts
                                                        .forEach((element) {
                                                      if (element.id ==
                                                          product.id) {
                                                        element.quantity =
                                                            product.quantity;
                                                      }
                                                    });
                                                    Get
                                                        .find<HomeController>()
                                                        .homeElements
                                                        .refresh();
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.plus,
                                                    color: AppColors
                                                        .primaryColor,
                                                    size: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              product.quantity = 1;
                                              product.addToCart = false;
                                              Get
                                                  .find<HomeController>()
                                                  .cartCount
                                                  .value++;
                                              Get
                                                  .find<CartController>()
                                                  .cartProducts
                                                  .add(
                                                ProductCollection(
                                                  id: product.id,
                                                  title: product.title,
                                                  slug: product.slug,
                                                  image: product.image,
                                                  selling: product.selling,
                                                  offered: product.offered,
                                                  price: product.price,
                                                  reviewCount:
                                                  product.reviewCount,
                                                  rating: product.rating,
                                                  quantity: product.quantity,
                                                  endTime: product.endTime,
                                                  addToCart:
                                                  product.addToCart,
                                                  badge: product.badge,
                                                  productId: product.id,
                                                ),
                                              );
                                              Get
                                                  .find<HomeController>()
                                                  .cartCount
                                                  .refresh();
                                              Get
                                                  .find<HomeController>()
                                                  .homeElements
                                                  .refresh();
                                            },
                                            child: Text(
                                              '+ Add to Bag',
                                              style: TextStyle(
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),

            Visibility(
                visible: controller.categoryProducts.isNotEmpty,
                child:
            Positioned(
              top: MediaQuery
                  .of(context)
                  .size
                  .height / 2 - 28,
              child: InkWell(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
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
            ),)
          ],
        ),
      );
    });
  }
}
