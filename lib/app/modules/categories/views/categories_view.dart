import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/base/base_view.dart';
import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/global_appbar.dart';
import '../../../core/widget/product_card.dart';
import '../../../routes/app_pages.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends BaseView<CategoriesController> {
  CategoriesView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return globalAppBar(context, 'Categories', showBackButton: false);
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      if (controller.ecomCategories.isEmpty) {
        return _buildLoadingState();
      }

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Top - Horizontal Categories List
            Container(
              height: 90.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildCategorySidebar(),
            ),

            // Bottom - Subcategories/Products Grid
            Expanded(child: _buildSubcategoriesSection()),
          ],
        ),
      );
    });
  }

  Widget _buildCategorySidebar() {
    return Obx(() {
      final selectedIndex = controller.selectedCategoryIndex.value;

      return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: controller.ecomCategories.length,
        itemBuilder: (context, index) {
          final category = controller.ecomCategories[index];
          final isSelected = selectedIndex == index;
          final iconSize = isSelected ? 38.r : 34.r;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () => controller.selectCategory(index),
              child: Container(
                width: 70.w,
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                decoration: BoxDecoration(
                  gradient:
                      isSelected
                          ? LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                          : null,
                  color: isSelected ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow:
                      isSelected
                          ? [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                              spreadRadius: 0,
                            ),
                          ]
                          : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Category Icon with animated container - Square shape
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: iconSize,
                      height: iconSize,
                      decoration: BoxDecoration(
                        gradient:
                            isSelected
                                ? LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.9),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                                : LinearGradient(
                                  colors: [Colors.white, Colors.grey[100]!],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color:
                                isSelected
                                    ? Colors.white.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.1),
                            blurRadius: isSelected ? 6 : 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child:
                          category.path != null &&
                                  category.path.toString().isNotEmpty
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: AnyImageView(
                                  imagePath:
                                      '${AppConfig.imageBasePath}${category.path}',
                                  width: iconSize,
                                  height: iconSize,
                                  fit: BoxFit.cover,
                                  errorWidget: Icon(
                                    Icons.category_rounded,
                                    color:
                                        isSelected
                                            ? AppColors.primaryColor
                                            : Colors.grey[600],
                                    size: isSelected ? 18.sp : 16.sp,
                                  ),
                                ),
                              )
                              : Icon(
                                Icons.category_rounded,
                                color:
                                    isSelected
                                        ? AppColors.primaryColor
                                        : Colors.grey[600],
                                size: isSelected ? 18.sp : 16.sp,
                              ),
                    ),

                    SizedBox(height: 4.h),

                    // Category Name with animated text
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 300),
                      style: TextStyle(
                        fontSize: isSelected ? 9.sp : 8.sp,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : Colors.grey[700],
                      ),
                      child: Text(
                        category.name ?? 'Category',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildSubcategoriesSection() {
    return Obx(() {
      final selectedIndex = controller.selectedCategoryIndex.value;
      if (selectedIndex == -1 ||
          selectedIndex >= controller.ecomCategories.length) {
        return _buildSelectCategoryPrompt();
      }

      final selectedCategory = controller.ecomCategories[selectedIndex];
      final subcategories = selectedCategory.childrenRecursive ?? [];

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: Column(
          key: ValueKey(selectedIndex),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
                  subcategories.isEmpty
                      ? _buildProductsGrid()
                      : _buildSubcategoriesGrid(subcategories),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubcategoriesGrid(List<dynamic> subcategories) {
    return GridView.builder(
      padding: EdgeInsets.all(20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: subcategories.length,
      itemBuilder: (context, index) {
        final subcategory = subcategories[index];
        return _buildSubcategoryCard(subcategory, index);
      },
    );
  }

  Widget _buildSubcategoryCard(dynamic subcategory, int index) {
    return GestureDetector(
      onTap: () => _navigateToProducts(subcategory),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 100)),
        curve: Curves.easeOutBack,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Subcategory Icon
                Container(
                  width: 35.h,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child:
                      subcategory.path != null &&
                              subcategory.path.toString().isNotEmpty
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: AnyImageView(
                              imagePath:
                                  '${AppConfig.imageBasePath}${subcategory.path}',
                              width: 35.h,
                              height: 35.h,
                              fit: BoxFit.cover,
                              errorWidget: Icon(
                                Icons.category_outlined,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                            ),
                          )
                          : Icon(
                            Icons.category_outlined,
                            color: Colors.white,
                            size: 12.sp,
                          ),
                ),

                AppWidgets().gapH(6),

                // Subcategory Name
                Text(
                  subcategory.name ?? 'Subcategory',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsGrid() {
    return Obx(() {
      if (controller.isCategoryProductsLoading.value) {
        return _buildProductsLoadingSkeleton();
      }

      if (controller.categoryWiseProducts.isEmpty) {
        return _buildEmptyProductsState();
      }

      return CustomScrollView(
        controller: controller.categoryProductsScrollController,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16.w),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = controller.categoryWiseProducts[index];
                return ProductCard(
                  product: product,
                  index: index,
                  showDiscountTag: true,
                );
              }, childCount: controller.categoryWiseProducts.length),
            ),
          ),

          // Loading Indicator (spans full width)
          if (controller.isPaginationLoading.value ||
              controller.categoryProductsCurrentPage.value <
                  controller.categoryProductsTotalPage.value)
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
      );
    });
  }

  Widget _buildProductsLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2.r,
            margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
              side: BorderSide(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                width: 0.5.w,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image section
                  Expanded(
                    flex: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(color: Colors.grey[300]),
                    ),
                  ),

                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: 90.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),

                  SizedBox(height: 4),
                  // Cart button section
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.r),
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

  Widget _buildEmptyProductsState() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(40.w),
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Empty state icon
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    Colors.grey.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: Colors.grey[400],
                size: 50.sp,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'No Products Found',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'This category doesn\'t have any\nproducts available right now',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectCategoryPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated floating icon
          Container(
            width: 120.w,
            height: 135.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.1),
                  AppColors.primaryColor.withOpacity(0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.touch_app_rounded,
              size: 60.sp,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 32.h),

          Text(
            'Choose Your Category',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            'Select a category from the left sidebar\nto explore amazing subcategories',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: 24.h),

          // Animated arrow pointing left
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back_rounded,
                color: AppColors.primaryColor.withOpacity(0.6),
                size: 24.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Start here',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primaryColor.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey[50]!, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // Top horizontal loading categories
          Container(
            height: 90.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Container(
                  width: 70.w,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 34.r,
                        height: 34.r,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: 50.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom loading content
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(0.1),
                          AppColors.primaryColor.withOpacity(0.05),
                        ],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryColor,
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Loading categories...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToProducts(dynamic category) {
    Get.toNamed(
      Routes.PRODUCT_CATEGORY,
      arguments: {
        'categoryId': category.id,
        'categoryName': category.name ?? 'Products',
        'fromSearch': false,
      },
    );
  }
}
