import 'dart:io';
import 'package:any_image_view/any_image_view.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
import 'package:ousadbazar/app/core/helper/webview_helper.dart';
import 'package:ousadbazar/app/routes/app_pages.dart';
import 'package:ousadbazar/generated/assets.dart';
import '../../../core/base/base_view.dart';
import '../../../core/helper/dialog_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/product_card.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  HomeView({super.key});

  final CartController cartController = Get.find<CartController>();

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        DialogHelper().customDialogBox(
          context,
          "Are you sure you want to exit?",
          leftButtonOnTap: () {
            Get.back();
          },
          rightButtonOnTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        );
      },
      child: Obx(() {
        return RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            printLog('Refreshing Home View');
            // controller.getHomeData();
            controller.getCategoriesData();
            controller.getSupplierData();
            controller.getBestSellingProducts();
          },
          child: CustomScrollView(
            controller: controller.bestSellingScrollController,
            physics: AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                snap: false,
                elevation: 0,
                backgroundColor: Colors.white,
                expandedHeight: 85.h,
                automaticallyImplyLeading: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    margin: REdgeInsets.symmetric(horizontal: 10, vertical: 0),

                    color: Colors.white,
                    child: SafeArea(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AnyImageView(
                                imagePath: Assets.pngLogo,
                                height: 35.h,
                              ),

                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.TRANSACTIONS);
                                },
                                child: Container(
                                  padding: REdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor.withOpacity(
                                      0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8).r,
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                    '৳ 9999 ',
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              AppWidgets().gapW8(),
                              IconButton(
                                icon: Icon(
                                  FontAwesomeIcons.facebookMessenger,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  launchURL(
                                    'https://m.me/chaardik.chaardik.7',
                                    true,
                                  );
                                },
                                tooltip: 'Message us on Messenger',
                              ),
                            ],
                          ),
                          Skeletonizer(
                            enabled: controller.isLoading.value,
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(Routes.SEARCH);
                                // Get.toNamed(
                                //   Routes.PRODUCT_CATEGORY,
                                //   arguments: {
                                //     'name': 'Search',
                                //     'type': 'Search',
                                //     'id': '0',
                                //   },
                                // );
                              },
                              child: Container(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.gray,
                                    width: 1,
                                  ),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Content starts here
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Skeletonizer(
                      enabled: controller.isLoading.value,
                      child:
                          controller.bannerImage.isNotEmpty
                              ? Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  CarouselSlider(
                                    items:
                                        controller.bannerImage.map((element) {
                                          return AnyImageView(
                                            imagePath: element,
                                            fit: BoxFit.cover,
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
                                      count: controller.bannerImage.length,
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
                                            color: AppColors.gray.withOpacity(
                                              0.5,
                                            ),
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
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.PRODUCT_CATEGORY,
                                    arguments: {
                                      'name':
                                          controller.categoriesData[index].name,
                                      'type': 'Categories',
                                      'id': controller.categoriesData[index].id,
                                      /*                  'name':
                                          controller.categoriesData[index].name,
                                      'slug':
                                          controller.categoriesData[index].id,
                                      'brandId': '',
                                      'fromSearch': false,*/
                                    },
                                  );
                                },
                                child: Column(
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
                                            color: AppColors.gray.withOpacity(
                                              0.5,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height: 75.h,
                                        width: 75.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          controller
                                                          .categoriesData[index]
                                                          .name !=
                                                      null &&
                                                  controller
                                                      .categoriesData[index]
                                                      .name!
                                                      .isNotEmpty
                                              ? controller
                                                  .categoriesData[index]
                                                  .name![0]
                                                  .toUpperCase()
                                              : '',
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      /*          child: AnyImageView(
                                        imagePath:
                                            '${AppConfig
                                                .imageBasePath}${controller.categoriesData[index]}',
                                        height: 75.h,
                                      ),*/
                                    ),
                                    AppWidgets().gapH(4),
                                    Text(
                                      '${controller.categoriesData[index].name}',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                    AppWidgets().gapH8(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suppliers',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    AppWidgets().gapH(4),

                    controller.isSupplierLoading.value
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
                                            color: AppColors.gray.withOpacity(
                                              0.5,
                                            ),
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
                            itemCount: controller.supplierData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  horizontal: 15,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.PRODUCT_CATEGORY,
                                      arguments: {
                                        'name':
                                            controller
                                                .supplierData[index]
                                                .companyName,
                                        'type': 'Suppliers',
                                        'id': controller.supplierData[index].id,
                                      },
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 75.h,
                                        width: 75.h,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          controller
                                                          .supplierData[index]
                                                          .companyName !=
                                                      null &&
                                                  controller
                                                      .supplierData[index]
                                                      .companyName!
                                                      .isNotEmpty
                                              ? controller
                                                  .supplierData[index]
                                                  .companyName!
                                                  .toUpperCase()
                                              : '',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      /*     Container(
                                      margin: REdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.gray.withOpacity(
                                              0.5,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: AnyImageView(
                                        imagePath:
                                            '${AppConfig
                                                .imageBasePath}${controller
                                                .supplierData[index].imagePath}',
                                        height: 75.h,
                                      ),
                                    ),*/
                                      AppWidgets().gapH(4),
                                      Text(
                                        '${controller.supplierData[index].companyName}',
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                    /*          controller.isBrandLoading.value
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
                      onClickItem: (index) {
                        printLog('${controller.supplierData[index].companyName}');
                        Get.toNamed(
                          Routes.PRODUCT_CATEGORY,
                          arguments: {
                            'name': controller.supplierData[index].companyName,
                            'slug': '',
                            'brandId':
                            controller.supplierData[index].id.toString(),
                            'fromSearch': false,
                          },
                        );
                      },
                      itemConfig: GalleryItemConfig(
                        width: 175.h,
                        height: 175.h,
                        radius: 10,
                      ),
                      itemBuilder: (context, index) {
                        final brand = controller.supplierData[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.PRODUCT_CATEGORY,
                              arguments: {
                                'name': brand.companyName,
                                'slug': brand.companyName,
                                'brandId': brand.id,
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${AppConfig.imageBasePath}${brand.imagePath}',
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        );
                      },
                      controller: Gallery3DController(
                        itemCount: controller.supplierData.length,
                      ),
                    ),
                  ),
                ),*/
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          // Text(
                                          //   'See More',
                                          //   style: TextStyle(
                                          //     color: AppColors.primaryColor,
                                          //     fontSize: 16,
                                          //     fontWeight: FontWeight.bold,
                                          //   ),
                                          // ),
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
                                                    color:
                                                        AppColors
                                                            .secondaryColor,
                                                    height: 125,
                                                    width: 125,
                                                  ),
                                                  AppWidgets().gapH(4),
                                                  Text(
                                                    'Product Title',
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
                                                  AppWidgets().gapH(4),
                                                  Text(
                                                    "Stock 00",
                                                    style: TextStyle(
                                                      color:
                                                          AppColors
                                                              .primaryColor,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                  ElevatedButton(
                                                    onPressed: () {},
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                          side: BorderSide(
                                                            color:
                                                                Colors
                                                                    .transparent,
                                                          ), // Set the border
                                                          // color to grey
                                                        ),
                                                    child: Text(
                                                      '+ Add to Bag',
                                                      style: TextStyle(
                                                        color:
                                                            AppColors
                                                                .primaryColor,
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
                              : SizedBox(height: 16),
                    ),
                  ]),
                ),
              ),
              // Best Selling Products Header
              SliverPadding(
                padding: REdgeInsets.symmetric(horizontal: 12),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Selling Products',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      // Text(
                      //   'See More',
                      //   style: TextStyle(
                      //     color: AppColors.primaryColor,
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // Best Selling Products Grid
              SliverPadding(
                padding: REdgeInsets.all(12),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return ProductCard(
                      product: controller.bestSellingProducts[index],
                      index: index,
                      showDiscountTag: true,
                    );
                  }, childCount: controller.bestSellingProducts.length),
                ),
              ),

              // Loading Indicator (spans full width)
              if (controller.isPaginationLoading.value ||
                  controller.bestSellingCurrentPage.value <
                      controller.bestSellingTotalPage.value)
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: SizedBox(
                        width: 24.w,
                        height: 24.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
