import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/global_appbar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: globalAppBar(context, 'Categories',showBackButton: false),
      body: Obx(() {
        if (controller.ecomCategories.isEmpty) {
          return _buildLoadingState();
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.secondaryColor, AppColors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: controller.ecomCategories.length,
              itemBuilder: (context, index) {
                final category = controller.ecomCategories[index];
                return _buildCategoryCard(category, index);
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCategoryCard(dynamic category, int index) {
    final colors = [
      [const Color(0xFF6C5CE7), const Color(0xFFA29BFE)],
      [const Color(0xFF00B894), const Color(0xFF55EFC4)],
      [const Color(0xFFE17055), const Color(0xFFFFAB91)],
      [const Color(0xFF0984E3), const Color(0xFF74B9FF)],
      [const Color(0xFFE84393), const Color(0xFFFF7675)],
      [const Color(0xFF00CEC9), const Color(0xFF81ECEC)],
    ];

    final colorSet = colors[index % colors.length];

    return Hero(
      tag: 'category-${category.id}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToProducts(category),
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              gradient: LinearGradient(
                colors: colorSet,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorSet[0].withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  top: -20.h,
                  right: -20.w,
                  child: Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30.h,
                  left: -30.w,
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Icon/Image
                      Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child:
                            category.path != null &&
                                    category.path.toString().isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: AnyImageView(
                                    imagePath:
                                        '${AppConfig.imageBasePath}${category.path}',
                                    width: 50.w,
                                    height: 50.h,
                                    fit: BoxFit.cover,
                                    errorWidget: _buildDefaultIcon(),
                                  ),
                                )
                                : _buildDefaultIcon(),
                      ),

                      const Spacer(),

                      // Category Name
                      Text(
                        category.name ?? 'Category',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      SizedBox(height: 4.h),

                      // Subcategories count
                      if (category.childrenRecursive != null &&
                          category.childrenRecursive!.isNotEmpty)
                        Text(
                          '${category.childrenRecursive!.length} subcategories',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      SizedBox(height: 8.h),

                      // Arrow icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 32.w,
                            height: 32.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16.sp,
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
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(Icons.category_rounded, color: Colors.white, size: 28.sp);
  }

  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondaryColor, AppColors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
          ),
          itemCount: 6, // Show 6 skeleton items
          itemBuilder: (context, index) {
            return _buildSkeletonCard();
          },
        ),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skeleton icon
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),

            const Spacer(),

            // Skeleton text
            Container(
              width: double.infinity,
              height: 16.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),

            SizedBox(height: 8.h),

            Container(
              width: 80.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ],
        ),
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
