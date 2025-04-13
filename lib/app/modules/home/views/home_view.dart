import 'package:any_image_view/any_image_view.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gallery_3d/gallery3d.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:turi/app/core/config/app_config.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:turi/app/routes/app_pages.dart';
import '../../../core/base/base_view.dart';
import '../../../core/style/app_colors.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: REdgeInsets.only(left: 12, right: 12, top: 30),
        child: Column(
          children: [
            Skeletonizer(
              enabled: controller.isLoading.value,
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.PRODUCT_SEARCH);
                },
                child: Container(
                  height: 40.h,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    // color: AppColors.gray,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.gray, width: 1),
                  ),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: AppColors.primaryColor,
                      ),
                      AppWidgets().gapW8(),
                      Text(
                        'What are you looking for?',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AppWidgets().gapH(4),
            Skeletonizer(
              enabled: controller.isLoading.value,

              child:
                  controller.homeElements.isNotEmpty
                      ? Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          CarouselSlider(
                            items:
                                controller.homeElements.first.banners!.map((
                                  element,
                                ) {
                                  return AnyImageView(
                                    imagePath:
                                        '${AppConfig.imageBasePath}${element.image}',
                                    boxFit: BoxFit.cover,
                                    cachedNetPlaceholderHeight: 150.h,
                                    cachedNetPlaceholderWidth: Get.width,
                                  );
                                }).toList(),
                            options: CarouselOptions(
                              height: 175.h,
                              autoPlay: true,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                controller.currentIndex.value = index;
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            child: CarouselIndicator(
                              count:
                                  controller.homeElements.first.banners!.length,
                              index: controller.currentIndex.value,
                              color: AppColors.secondaryColor,
                              activeColor: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      )
                      : Container(
                        height: 150.h,
                        width: Get.width,
                        color: AppColors.secondaryColor,
                      ),
            ),
            AppWidgets().gapH8(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            controller.isCategoryLoading.value
                ? Skeletonizer(
                  child: SizedBox(
                    height: 125.h,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: REdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.gray.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Container(
                                color: AppColors.primaryColor,
                                height: 75.h,
                                width: 75.h,
                              ),
                            ),
                            AppWidgets().gapH(4),
                            Text(
                              'Category Title',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
                : SizedBox(
                  height: 125.h,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categoriesData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: REdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gray.withOpacity(0.5),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: AnyImageView(
                              imagePath:
                                  '${AppConfig.imageBasePath}${controller.categoriesData[index].image}',
                              height: 75.h,
                            ),
                          ),
                          AppWidgets().gapH(4),
                          Text(
                            '${controller.categoriesData[index].title}',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

            AppWidgets().gapH8(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Top Brands',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            AppWidgets().gapH(4),

            controller.isBrandLoading.value
                ? Skeletonizer(
                  enabled: true,
                  child: SizedBox(
                    width: Get.width,
                    height: Get.width / 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: Get.width / 3,
                          width: Get.width / 4,
                          color: AppColors.gray,
                        ),
                        Container(
                          height: Get.width / 3,
                          width: Get.width / 3,
                          color: AppColors.gray,
                        ),
                        Container(
                          height: Get.width / 3,
                          width: Get.width / 4,
                          color: AppColors.gray,
                        ),
                      ],
                    ),
                  ),
                )
                : SizedBox(
                  height: 175.h,
                  width: Get.width,
                  child: Center(
                    child: Gallery3D(
                      width: Get.width,
                      itemConfig: GalleryItemConfig(
                        width: 175.h,
                        height: 175.h,
                        radius: 10,
                      ),
                      itemBuilder: (context, index) {
                        final brand = controller.brandsData[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                '${AppConfig.imageBasePath}${brand.image}',
                              ),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                      controller: Gallery3DController(
                        itemCount: controller.brandsData.length,
                      ),
                    ),
                  ),
                ),
            AppWidgets().gapH8(),
            Skeletonizer(
              enabled: controller.isLoading.value,
              child:
                  controller.isLoading.value
                      ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppWidgets().gapH8(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Category Title',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'See More',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              DynamicHeightGridView(
                                crossAxisCount: 2,
                                itemCount: 2,
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
                            ],
                          );
                        },
                      )
                      : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount:
                            controller.homeElements.first.collections!.length,
                        itemBuilder: (context, index) {
                          final collection =
                              controller.homeElements.first.collections![index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppWidgets().gapH8(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${collection.title}',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'See More',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.62,
                                    ),
                                itemCount:
                                    collection.productCollections!.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product =
                                      collection.productCollections![index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.PRODUCT_DETAILS,
                                          arguments: {
                                            'product': product,
                                          });
                                    },
                                    child: AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration: const Duration(
                                        milliseconds: 375,
                                      ),
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
                                                    '${AppConfig.imageBasePath}${product.image}',
                                                    cacheHeight: 125,
                                                    cacheWidth: 125,
                                                  ),
                                                  AppWidgets().gapH(4),
                                                  Text(
                                                    '${product.title}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColors
                                                              .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              product.selling
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                          ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "  ${product.offered.toString()} BDT",
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            color:
                                                                AppColors
                                                                    .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  AppWidgets().gapH8(),
                                                  Visibility(
                                                    visible: product.addToCart!,
                                                    replacement: Container(
                                                      margin:
                                                          REdgeInsets.symmetric(
                                                            horizontal: 14,
                                                          ),
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              8,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              AppColors
                                                                  .primaryColor,
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
                                                            offset: Offset(
                                                              0,
                                                              1,
                                                            ),
                                                            // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              if (product
                                                                      .quantity! >
                                                                  1) {
                                                                product.quantity =
                                                                    product
                                                                        .quantity! -
                                                                    1;

                                                                Get.find<
                                                                      CartController
                                                                    >()
                                                                    .cartProducts
                                                                    .forEach((
                                                                      element,
                                                                    ) {
                                                                      if (element
                                                                              .id ==
                                                                          product
                                                                              .id) {
                                                                        element.quantity =
                                                                            product.quantity;
                                                                      }
                                                                    });

                                                                controller
                                                                    .homeElements
                                                                    .refresh();
                                                              } else {
                                                                product.addToCart =
                                                                    true;
                                                                controller
                                                                    .homeElements
                                                                    .refresh();
                                                                controller
                                                                    .cartCount
                                                                    .value--;

                                                                Get.find<
                                                                      CartController
                                                                    >()
                                                                    .cartProducts
                                                                    .removeAt(
                                                                      Get.find<
                                                                            CartController
                                                                          >()
                                                                          .cartProducts
                                                                          .indexWhere(
                                                                            (
                                                                              element,
                                                                            ) =>
                                                                                element.id ==
                                                                                product.id,
                                                                          ),
                                                                    );

                                                                controller
                                                                    .cartCount
                                                                    .refresh();
                                                              }
                                                            },
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .minus,
                                                              color:
                                                                  AppColors
                                                                      .primaryColor,
                                                              size: 14,
                                                            ),
                                                          ),

                                                          Text(
                                                            product.quantity!
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  AppColors
                                                                      .primaryColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),

                                                          IconButton(
                                                            onPressed: () {
                                                              product.quantity =
                                                                  product
                                                                      .quantity! +
                                                                  1;

                                                              Get.find<
                                                                    CartController
                                                                  >()
                                                                  .cartProducts
                                                                  .forEach((
                                                                    element,
                                                                  ) {
                                                                    if (element
                                                                            .id ==
                                                                        product
                                                                            .id) {
                                                                      element.quantity =
                                                                          product
                                                                              .quantity;
                                                                    }
                                                                  });
                                                              controller
                                                                  .homeElements
                                                                  .refresh();
                                                            },
                                                            icon: FaIcon(
                                                              FontAwesomeIcons
                                                                  .plus,
                                                              color:
                                                                  AppColors
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
                                                        product.addToCart =
                                                            false;
                                                        controller
                                                            .cartCount
                                                            .value++;
                                                        Get.find<
                                                              CartController
                                                            >()
                                                            .cartProducts
                                                            .add(product);
                                                        controller.cartCount
                                                            .refresh();
                                                        controller.homeElements
                                                            .refresh();
                                                      },
                                                      child: Text(
                                                        '+ Add to Bag',
                                                        style: TextStyle(
                                                          color:
                                                              AppColors
                                                                  .primaryColor,
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
                              ),
                            ],
                          );
                        },
                      ),
            ),
          ],
        ),
      );
    });
  }
}
