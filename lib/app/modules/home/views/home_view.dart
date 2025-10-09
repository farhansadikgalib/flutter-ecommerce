import 'dart:io';
import 'package:any_image_view/any_image_view.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/config/app_config.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
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
        return SafeArea(
          top: false,
          bottom: true,
          maintainBottomViewPadding: true,
          child: RefreshIndicator(
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
                  pinned: true,
                  floating: false,
                  snap: false,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  expandedHeight: 85.h,
                  automaticallyImplyLeading: false,
                  collapsedHeight: 85.h,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      margin: REdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 0,
                      ),
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
                              ],
                            ),
                            Skeletonizer(
                              enabled: controller.isLoading.value,
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(Routes.SEARCH);
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
                                ? Container(
                                  height: 180.h,
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        CarouselSlider(
                                          items:
                                              controller.bannerImage.map((
                                                element,
                                              ) {
                                                return AnyImageView(
                                                  imagePath: element,
                                                  fit: BoxFit.cover,
                                                );
                                              }).toList(),
                                          options: CarouselOptions(
                                            height: 180.h,
                                            autoPlay: true,
                                            autoPlayInterval: Duration(
                                              seconds: 4,
                                            ),
                                            autoPlayAnimationDuration: Duration(
                                              milliseconds: 1000,
                                            ),
                                            aspectRatio: 16 / 9,
                                            viewportFraction: 1.0,
                                            onPageChanged: (index, reason) {
                                              controller.currentIndex.value =
                                                  index;
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 12,
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              controller.bannerImage.length,
                                              (index) => Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal: 3,
                                                ),
                                                width:
                                                    controller
                                                                .currentIndex
                                                                .value ==
                                                            index
                                                        ? 24
                                                        : 8,
                                                height: 8,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color:
                                                      controller
                                                                  .currentIndex
                                                                  .value ==
                                                              index
                                                          ? AppColors
                                                              .primaryColor
                                                          : Colors.white
                                                              .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                : Container(
                                  height: 180.h,
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[100],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          color: Colors.grey[400],
                                          size: 48,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'No banners available',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      ),
                      AppWidgets().gapH(16),
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
                      AppWidgets().gapH(8),

                      controller.isSupplierLoading.value
                          ? Skeletonizer(
                            child: SizedBox(
                              height: 120.h,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(right: 12.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70.h,
                                          width: 70.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Container(
                                          height: 10.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                          : SizedBox(
                            height: 120.h,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.supplierData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 12.w),
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
                                          'id':
                                              controller.supplierData[index].id,
                                        },
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70.h,
                                          width: 70.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.1,
                                                ),
                                                blurRadius: 4,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child:
                                                controller
                                                            .supplierData[index]
                                                            .imagePath ==
                                                        null
                                                    ? Container(
                                                      decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor
                                                            .withOpacity(0.1),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          controller.supplierData[index].companyName !=
                                                                      null &&
                                                                  controller
                                                                      .supplierData[index]
                                                                      .companyName!
                                                                      .isNotEmpty
                                                              ? controller
                                                                  .supplierData[index]
                                                                  .companyName![0]
                                                                  .toUpperCase()
                                                              : 'S',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                AppColors
                                                                    .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    : AnyImageView(
                                                      imagePath:
                                                          '${AppConfig.imageBasePath}${controller.supplierData[index].imagePath}',
                                                      height: 50.h,
                                                      width: 50.h,

                                                    ),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        SizedBox(
                                          width: 70.w,
                                          child: Text(
                                            '${controller.supplierData[index].companyName}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                      AppWidgets().gapH(16),
                    ]),
                  ),
                ),
                // Best Selling Products Header
                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Best Selling Products',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Best Selling Products Grid
                SliverPadding(
                  padding: REdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
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
          ),
        );
      }),
    );
  }
}
