import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import '../../../core/helper/debounce_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/product_card.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart'
    as BestSellingModel;
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[50]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              _buildSearchHeader(),
              _buildSearchFilters(),
              Expanded(child: _buildSearchResults()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.primaryColor,
              size: 20.r,
            ),
          ),
          AppWidgets().gapW8(),
          Expanded(
            child: Container(
              height: 40.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.grey[50]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.8),
                    blurRadius: 15,
                    offset: const Offset(0, -2),
                    spreadRadius: 0,
                  ),
                ],
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Obx(
                () => TextField(
                  controller: controller.searchController.value,
                  focusNode: controller.searchFocusNode,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: 'What are you looking for today?',
                    hintStyle: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon:
                        controller.searchController.value.text.isNotEmpty
                            ? GestureDetector(
                              onTap: () {
                                controller.searchController.value.clear();
                                controller.searchProducts('');
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                child: Icon(
                                  Icons.clear_rounded,
                                  color: Colors.grey[400],
                                  size: 20.sp,
                                ),
                              ),
                            )
                            : Container(
                              padding: EdgeInsets.all(12.w),
                              child: Icon(
                                Icons.search_rounded,
                                color: AppColors.primaryColor.withValues(
                                  alpha: 0.7,
                                ),
                                size: 20.sp,
                              ),
                            ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                  ),
                  onChanged: (value) {
                    controller.debounceHelper.debounce(
                      tag: DebounceHelper.searchTextTag,
                      onMethod: () {
                        controller.searchProducts(value);
                      },
                      time: 300,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilters() {
    return Obx(() {
      if (controller.searchController.value.text.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.7),
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withValues(alpha: 0.1),
                    AppColors.primaryColor.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    color: AppColors.primaryColor,
                    size: 16.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Results: ${controller.searchProductList.length}',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            if (controller.searchProductList.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: Colors.green[600],
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'Found',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[600],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildSearchResults() {
    return Obx(() {
      final searchText = controller.searchController.value.text;

      if (searchText.isEmpty) {
        return _buildSearchPrompt();
      }

      if (controller.searchProductList.isEmpty) {
        return _buildNoResultsFound(searchText);
      }

      return _buildProductGrid();
    });
  }

  Widget _buildSearchPrompt() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated search icon
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withValues(alpha: 0.1),
                  AppColors.primaryColor.withValues(alpha: 0.05),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Icon(
              Icons.search_rounded,
              size: 60.sp,
              color: AppColors.primaryColor,
            ),
          ),

          SizedBox(height: 32.h),

          Text(
            'Start typing in the search bar above\nto find exactly what you need',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return GestureDetector(
      onTap: () {
        controller.searchController.value.text = text;
        controller.searchProducts(text);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.1),
              AppColors.primaryColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppColors.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultsFound(String searchText) {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // No results icon
          Container(
            width: 100.w,
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withValues(alpha: 0.1),
                  Colors.orange.withValues(alpha: 0.05),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 50.sp,
              color: Colors.orange[600],
            ),
          ),

          SizedBox(height: 24.h),

          Text(
            'No Results Found',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            'We couldn\'t find any products for\n"$searchText"',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),

          SizedBox(height: 32.h),

          // Suggestions container
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Try these suggestions:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16.h),
                _buildSuggestionItem('Check your spelling'),
                _buildSuggestionItem('Use different keywords'),
                _buildSuggestionItem('Try more general terms'),
                _buildSuggestionItem('Browse categories instead'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            color: AppColors.primaryColor.withValues(alpha: 0.7),
            size: 16.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.66,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: controller.searchProductList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = controller.searchProductList[index];
          final product = BestSellingModel.ProductData(
            id: item.id,
            quantity: 0,
            addToCart: false,
            addToWishlist: false,
            name: item.name,
            genericId: item.genericId,
            categoryId: item.categoryId,
            supplierId: item.supplierId,
            pharmaSalesQuantity: null,
            ecommerceSalesQuantity: null,
            totalSoldQuantity: null,
            totalBalancedQuantity: null,
            generic:
                item.generic != null
                    ? BestSellingModel.Generic(
                      id: item.generic!.id,
                      name: item.generic!.name,
                      category: item.generic!.category,
                      status: item.generic!.status,
                      createdBy: item.generic!.createdBy,
                      updatedBy: item.generic!.updatedBy,
                      createdAt: item.generic!.createdAt,
                      updatedAt: item.generic!.updatedAt,
                    )
                    : null,
            category:
                item.category != null
                    ? BestSellingModel.Category(
                      id: item.category!.id,
                      name: item.category!.name,
                      shortOrder: item.category!.shortOrder,
                      createdAt: item.category!.createdAt,
                      updatedAt: item.category!.updatedAt,
                      status: item.category!.status,
                      deletedAt: null,
                    )
                    : null,
            supplier:
                item.supplier != null
                    ? BestSellingModel.Supplier(
                      id: item.supplier!.id,
                      firstName: item.supplier!.firstName,
                      lastName: item.supplier!.lastName,
                      address1: item.supplier!.address1,
                      address2: item.supplier!.address2,
                      city: item.supplier!.city,
                      stateOrProvince: item.supplier!.stateOrProvince,
                      zip: item.supplier!.zip,
                      country: item.supplier!.country,
                      comments: item.supplier!.comments,
                      contact: item.supplier!.contact,
                      email: item.supplier!.email,
                      companyName: item.supplier!.companyName,
                      accountNo: item.supplier!.accountNo,
                      imagePath: item.supplier!.imagePath,
                      status: item.supplier!.status,
                      createdAt: item.supplier!.createdAt,
                      updatedAt: item.supplier!.updatedAt,
                      type: item.supplier!.type,
                      storeAccountBalance: item.supplier!.storeAccountBalance,
                      payAmount: item.supplier!.payAmount,
                      deletedAt: item.supplier!.deletedAt,
                      deletedBy: item.supplier!.deletedBy,
                    )
                    : null,
            packSize:
                item.packSize != null
                    ? BestSellingModel.PackSize(
                      id: item.packSize!.id,
                      productId: item.packSize!.productId,
                      name: item.packSize!.name,
                      quantity: item.packSize!.quantity,
                      tp: item.packSize!.tp,
                      vatPercent: item.packSize!.vatPercent,
                      vat: item.packSize!.vat,
                      sellingPrice: item.packSize!.sellingPrice,
                      defaultUnit: item.packSize!.defaultUnit,
                      createdAt: item.packSize!.createdAt,
                      updatedAt: item.packSize!.updatedAt,
                      deletedAt: item.packSize!.deletedAt,
                    )
                    : null,
            productVariationAttributes: item.productVariationAttributes ?? [],
            productVariations: item.productVariations ?? [],
            productPrices:
                item.productPrices != null
                    ? BestSellingModel.ProductPrices(
                      id: item.productPrices!.id,
                      productId: item.productPrices!.productId,
                      costPriceWithoutTax:
                          item.productPrices!.costPriceWithoutTax,
                      sellingPrice: item.productPrices!.sellingPrice,
                      tradePrice: item.productPrices!.tradePrice,
                      vat: item.productPrices!.vat,
                      wholesale: item.productPrices!.wholesale,
                      wholesaleType: item.productPrices!.wholesaleType,
                      promoPrice: item.productPrices!.promoPrice,
                      promoStartDate: item.productPrices!.promoStartDate,
                      promoEndDate: item.productPrices!.promoEndDate,
                      disableFromPriceRules:
                          item.productPrices!.disableFromPriceRules,
                      allowPriceOverrideRegardlessOfPermissions:
                          item
                              .productPrices!
                              .allowPriceOverrideRegardlessOfPermissions,
                      pricesIncludeTax: item.productPrices!.pricesIncludeTax,
                      onlyAllowItemsToBeSoldInWholeNumbers:
                          item
                              .productPrices!
                              .onlyAllowItemsToBeSoldInWholeNumbers,
                      changeCostPriceDuringSale:
                          item.productPrices!.changeCostPriceDuringSale,
                      overrideDefaultCommission:
                          item.productPrices!.overrideDefaultCommission,
                      overrideDefaultTax:
                          item.productPrices!.overrideDefaultTax,
                      createdAt: item.productPrices!.createdAt,
                      updatedAt: item.productPrices!.updatedAt,
                      deletedAt: item.productPrices!.deletedAt,
                      isEditableInSale:
                          item.productPrices!.isEditableInSale?.toString(),
                      packQuantity: null,
                      ecomDiscountPercentage: null,
                      ecomDiscountAmount: null,
                      ecomFinalSellingPrice: null,
                    )
                    : null,
          );

          return AnimatedContainer(
            duration: Duration(milliseconds: 300 + (index * 50)),
            curve: Curves.easeOutBack,
            child: ProductCard(product: product, index: index),
          );
        },
      ),
    );
  }
}
