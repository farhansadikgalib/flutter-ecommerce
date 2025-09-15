import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../core/helper/debounce_helper.dart';
import '../../../core/style/app_colors.dart';
import '../../../core/widget/global_appbar.dart';
import '../../../core/widget/product_card.dart';
import 'package:ousadbazar/app/data/remote/model/home/best_selling_product_response.dart'
as BestSellingModel;
import '../../../data/remote/model/home/best_selling_product_response.dart';
import '../../cart/controllers/cart_controller.dart';
import '../controllers/product_category_controller.dart';

class ProductCategoryView extends GetView<ProductCategoryController> {
  const ProductCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    Get.put(CartController);
    return Obx(() {
      return Scaffold(
        key: scaffoldKey,
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
                                      for (var type in controller.deliveryType) {
                                        type.isSelected = type.id == value;
                                      }
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
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Column(
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
                            if (controller.searchController.value.text.isEmpty)
                              SizedBox(
                                height: Get.height / 1.5,
                                child: Center(
                                  child: Text(
                                    'Type something to search!',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),

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
                                            ? Generic(
                                              id: item.generic!.id,
                                              name: item.generic!.name,
                                              category: item.generic!.category,
                                              status: item.generic!.status,
                                              createdBy:
                                                  item.generic!.createdBy,
                                              updatedBy:
                                                  item.generic!.updatedBy,
                                              createdAt:
                                                  item.generic!.createdAt,
                                              updatedAt:
                                                  item.generic!.updatedAt,
                                            )
                                            : null,
                                    category:
                                        item.category != null
                                            ? Category(
                                              id: item.category!.id,
                                              name: item.category!.name,
                                              shortOrder:
                                                  item.category!.shortOrder,
                                              createdAt:
                                                  item.category!.createdAt,
                                              updatedAt:
                                                  item.category!.updatedAt,
                                              status: item.category!.status,
                                              deletedAt: null,
                                            )
                                            : null,
                                    supplier:
                                        item.supplier != null
                                            ? Supplier(
                                              id: item.supplier!.id,
                                              firstName:
                                                  item.supplier!.firstName,
                                              lastName: item.supplier!.lastName,
                                              address1: item.supplier!.address1,
                                              address2: item.supplier!.address2,
                                              city: item.supplier!.city,
                                              stateOrProvince:
                                                  item
                                                      .supplier!
                                                      .stateOrProvince,
                                              zip: item.supplier!.zip,
                                              country: item.supplier!.country,
                                              comments: item.supplier!.comments,
                                              contact: item.supplier!.contact,
                                              email: item.supplier!.email,
                                              companyName:
                                                  item.supplier!.companyName,
                                              accountNo:
                                                  item.supplier!.accountNo,
                                              imagePath:
                                                  item.supplier!.imagePath,
                                              status: item.supplier!.status,
                                              createdAt:
                                                  item.supplier!.createdAt,
                                              updatedAt:
                                                  item.supplier!.updatedAt,
                                              type: item.supplier!.type,
                                              storeAccountBalance:
                                                  item
                                                      .supplier!
                                                      .storeAccountBalance,
                                              payAmount:
                                                  item.supplier!.payAmount,
                                              deletedAt:
                                                  item.supplier!.deletedAt,
                                              deletedBy:
                                                  item.supplier!.deletedBy,
                                            )
                                            : null,
                                    packSize:
                                        item.packSize != null
                                            ? PackSize(
                                              id: item.packSize!.id,
                                              productId:
                                                  item.packSize!.productId,
                                              name: item.packSize!.name,
                                              quantity: item.packSize!.quantity,
                                              tp: item.packSize!.tp,
                                              vatPercent:
                                                  item.packSize!.vatPercent,
                                              vat: item.packSize!.vat,
                                              sellingPrice:
                                                  item.packSize!.sellingPrice,
                                              defaultUnit:
                                                  item.packSize!.defaultUnit,
                                              createdAt:
                                                  item.packSize!.createdAt,
                                              updatedAt:
                                                  item.packSize!.updatedAt,
                                              deletedAt:
                                                  item.packSize!.deletedAt,
                                            )
                                            : null,
                                    productVariationAttributes:
                                        item.productVariationAttributes ?? [],
                                    productVariations:
                                        item.productVariations ?? [],
                                    productPrices:
                                        item.productPrices != null
                                            ? ProductPrices(
                                              id: item.productPrices!.id,
                                              productId:
                                                  item.productPrices!.productId,
                                              costPriceWithoutTax:
                                                  item
                                                      .productPrices!
                                                      .costPriceWithoutTax,
                                              sellingPrice:
                                                  item
                                                      .productPrices!
                                                      .sellingPrice,
                                              tradePrice:
                                                  item
                                                      .productPrices!
                                                      .tradePrice,
                                              vat: item.productPrices!.vat,
                                              wholesale:
                                                  item.productPrices!.wholesale,
                                              wholesaleType:
                                                  item
                                                      .productPrices!
                                                      .wholesaleType,
                                              promoPrice:
                                                  item
                                                      .productPrices!
                                                      .promoPrice,
                                              promoStartDate:
                                                  item
                                                      .productPrices!
                                                      .promoStartDate,
                                              promoEndDate:
                                                  item
                                                      .productPrices!
                                                      .promoEndDate,
                                              disableFromPriceRules:
                                                  item
                                                      .productPrices!
                                                      .disableFromPriceRules,
                                              allowPriceOverrideRegardlessOfPermissions:
                                                  item
                                                      .productPrices!
                                                      .allowPriceOverrideRegardlessOfPermissions,
                                              pricesIncludeTax:
                                                  item
                                                      .productPrices!
                                                      .pricesIncludeTax,
                                              onlyAllowItemsToBeSoldInWholeNumbers:
                                                  item
                                                      .productPrices!
                                                      .onlyAllowItemsToBeSoldInWholeNumbers,
                                              changeCostPriceDuringSale:
                                                  item
                                                      .productPrices!
                                                      .changeCostPriceDuringSale,
                                              overrideDefaultCommission:
                                                  item
                                                      .productPrices!
                                                      .overrideDefaultCommission,
                                              overrideDefaultTax:
                                                  item
                                                      .productPrices!
                                                      .overrideDefaultTax,
                                              createdAt:
                                                  item.productPrices!.createdAt,
                                              updatedAt:
                                                  item.productPrices!.updatedAt,
                                              deletedAt:
                                                  item.productPrices!.deletedAt,
                                              isEditableInSale:
                                                  item
                                                      .productPrices!
                                                      .isEditableInSale,
                                              packQuantity: null,
                                              ecomDiscountPercentage: null,
                                              ecomDiscountAmount: null,
                                              ecomFinalSellingPrice: null,
                                            )
                                            : null,
                                    productInventories: null,
                                    productLocations: null,
                                    productImages:
                                        item.productImages
                                            ?.cast<ProductImage>() ??
                                        [],
                                    stockBatches: null,
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
                          final product =BestSellingModel.ProductData(
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
                              stateOrProvince:
                              item.supplier!.stateOrProvince,
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
                              storeAccountBalance:
                              item.supplier!.storeAccountBalance,
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
                            productVariationAttributes:
                            item.productVariationAttributes ?? [],
                            productVariations: item.productVariations ?? [],
                            productPrices:
                            item.productPrices != null
                                ? BestSellingModel.ProductPrices(
                              id: item.productPrices!.id,
                              productId: item.productPrices!.productId,
                              costPriceWithoutTax:
                              item.productPrices!.costPriceWithoutTax,
                              sellingPrice:
                              item.productPrices!.sellingPrice,
                              tradePrice: item.productPrices!.tradePrice,
                              vat: item.productPrices!.vat,
                              wholesale: item.productPrices!.wholesale,
                              wholesaleType:
                              item.productPrices!.wholesaleType,
                              promoPrice: item.productPrices!.promoPrice,
                              promoStartDate:
                              item.productPrices!.promoStartDate,
                              promoEndDate:
                              item.productPrices!.promoEndDate,
                              disableFromPriceRules:
                              item.productPrices!.disableFromPriceRules,
                              allowPriceOverrideRegardlessOfPermissions:
                              item
                                  .productPrices!
                                  .allowPriceOverrideRegardlessOfPermissions,
                              pricesIncludeTax:
                              item.productPrices!.pricesIncludeTax,
                              onlyAllowItemsToBeSoldInWholeNumbers:
                              item
                                  .productPrices!
                                  .onlyAllowItemsToBeSoldInWholeNumbers,
                              changeCostPriceDuringSale:
                              item
                                  .productPrices!
                                  .changeCostPriceDuringSale,
                              overrideDefaultCommission:
                              item
                                  .productPrices!
                                  .overrideDefaultCommission,
                              overrideDefaultTax:
                              item.productPrices!.overrideDefaultTax,
                              createdAt: item.productPrices!.createdAt,
                              updatedAt: item.productPrices!.updatedAt,
                              deletedAt: item.productPrices!.deletedAt,
                              isEditableInSale:
                              item.productPrices!.isEditableInSale
                                  ?.toString(),
                              packQuantity: null,
                              ecomDiscountPercentage: null,
                              ecomDiscountAmount: null,
                              ecomFinalSellingPrice: null,
                            )
                                : null,
                            productInventories:
                            item.productInventories != null
                                ? BestSellingModel.ProductInventories(
                              id: item.productInventories!.id,
                              productId: item.productInventories!.productId,
                              quantity: item.productInventories!.quantity,
                              recorderLevel: null,
                              createdAt: item.productInventories!.createdAt,
                              updatedAt: item.productInventories!.updatedAt,
                              replenishLevel: null,
                              daysExpairation: null,
                              damagedQuantity: null,
                              inventoryAddSubtract: null,
                              comments: null,
                              deletedAt: null,
                            )
                                : null,
                            productLocations:
                            null, // Different structure between models
                            productImages:
                            item.productImages != null &&
                                item.productImages!.isNotEmpty
                                ? item.productImages!
                                .map(
                                  (img) => BestSellingModel.ProductImage(
                                id: img is Map ? img['id'] : img.id,
                                productId:
                                img is Map
                                    ? img['product_id']
                                    : img.productId,
                                path:
                                img is Map ? img['path'] : img.path,
                                createdAt:
                                img is Map
                                    ? img['created_at']
                                    : img.createdAt,
                                updatedAt:
                                img is Map
                                    ? img['updated_at']
                                    : img.updatedAt,
                                deletedAt:
                                img is Map
                                    ? img['deleted_at']
                                    : img.deletedAt,
                              ),
                            )
                                .toList()
                                : [],
                            stockBatches:
                            null, // Complex model conversion - simplified
                          );
                          return ProductCard(product: product, index: index);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            Visibility(
              visible: false,
              // controller.categoryProducts.isNotEmpty &&
              //     !controller.fromSearch,
              child: Positioned(
                top: MediaQuery.of(context).size.height / 2 - 28,
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
              ),
            ),
          ],
        ),
      );
    });
  }
}
