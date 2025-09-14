import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/helper/debounce_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/product_card.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          appBar: AppBar(
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
                    contentPadding: EdgeInsets.only(top: 5, left: 10),
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
                      time: 300,
                    );
                  },
                )
            ),
          ),
          body: Column(
            children: [
              if (controller.searchController.value.text.isEmpty)

                SizedBox(height: Get.height / 1.5, child: Center(
                  child: Text(
                    'Type something to search!',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),),

              Expanded(
                child: GridView.builder(
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,

                  ),
                  itemCount: controller.searchProductList.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item =
                    controller.searchProductList[index];

                    final product = ProductData(
                      id: item.id,
                      quantity: 0,
                      addToCart: false,
                      addToWishlist: false,
                      name: item.name,
                      genericId: item.genericId,
                      categoryId: item.categoryId,
                      supplierId: item.supplierId,
                      // totalSoldQuantity: item.totalSoldQuantity,
                      generic: item.generic != null
                          ? Generic(
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
                      category: item.category != null
                          ? Category(
                        id: item.category!.id,
                        name: item.category!.name,
                        shortOrder: item.category!.shortOrder,
                        createdAt: item.category!.createdAt,
                        updatedAt: item.category!.updatedAt,
                        status: item.category!.status,
                      )
                          : null,
                      supplier: item.supplier != null
                          ? Supplier(
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
                      packSize: item.packSize != null
                          ? PackSize(
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
                      productVariationAttributes: item
                          .productVariationAttributes,
                      productVariations: item.productVariations,
                      productPrices: item.productPrices != null
                          ? ProductPrices(
                        id: item.productPrices!.id,
                        productId: item.productPrices!.productId,
                        costPriceWithoutTax: item.productPrices!
                            .costPriceWithoutTax,
                        sellingPrice: item.productPrices!.sellingPrice,
                        tradePrice: item.productPrices!.tradePrice,
                        vat: item.productPrices!.vat,
                        wholesale: item.productPrices!.wholesale,
                        wholesaleType: item.productPrices!.wholesaleType,
                        promoPrice: item.productPrices!.promoPrice,
                        promoStartDate: item.productPrices!.promoStartDate,
                        promoEndDate: item.productPrices!.promoEndDate,
                        disableFromPriceRules: item.productPrices!
                            .disableFromPriceRules,
                        allowPriceOverrideRegardlessOfPermissions: item
                            .productPrices!
                            .allowPriceOverrideRegardlessOfPermissions,
                        pricesIncludeTax: item.productPrices!.pricesIncludeTax,
                        onlyAllowItemsToBeSoldInWholeNumbers: item
                            .productPrices!
                            .onlyAllowItemsToBeSoldInWholeNumbers,
                        changeCostPriceDuringSale: item.productPrices!
                            .changeCostPriceDuringSale,
                        overrideDefaultCommission: item.productPrices!
                            .overrideDefaultCommission,
                        overrideDefaultTax: item.productPrices!
                            .overrideDefaultTax,
                        createdAt: item.productPrices!.createdAt,
                        updatedAt: item.productPrices!.updatedAt,
                        deletedAt: item.productPrices!.deletedAt,
                        isEditableInSale: item.productPrices!.isEditableInSale,
                      )
                          : null,

                      productImages: item.productImages != null
                          ? item.productImages!.map((img) =>
                          ProductImage(
                            id: img.id,
                            productId: img.productId,
                            path: img.path,
                            createdAt: img.createdAt,
                            updatedAt: img.updatedAt,
                            deletedAt: img.deletedAt,
                          )).toList()
                          : [],

                    );

                    return ProductCard(
                      product: product,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          )
      );
    });
  }
}
