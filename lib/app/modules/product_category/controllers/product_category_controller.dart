import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/data/remote/model/search/search_response.dart';
import 'package:turi/app/data/remote/repository/category/category_repository.dart';

import '../../../core/helper/debounce_helper.dart';
import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/category/categorywiseproducts_response.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductCategoryController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final DebounceHelper debounceHelper = DebounceHelper();
  final priceRange = RangeValues(0, 1000).obs;
  final category = <Category>[].obs;
  final brands = <Brand>[].obs;
  final collections = <Brand>[].obs;
  final deliveryType = <Brand>[].obs;
  final categorySlug = Get.arguments['slug'];
  final categoryName = Get.arguments['name'];
  final brandId = Get.arguments['brandId'];
  final fromSearch = Get.arguments['fromSearch'];
  final categoryProducts = <CategoryProducts>[].obs;

  final isLoading = false.obs;

  //search
  final FocusNode searchFocusNode = FocusNode(canRequestFocus: true);
  final searchController = TextEditingController().obs;
  final searchProductList = <SearchProducts>[];
  //search

  @override
  void onInit() {
    super.onInit();
    if (fromSearch == false) {
      getCategoryWiseProducts(categorySlug, brandId, '', '', '');
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus(); // Request focus to show the keyboard
    });

  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    super.onClose();
  }

  getCategoryWiseProducts(
    String categorySlug,
    String brandId,
    String deliveryId,
    minPrice,
    maxPrice,
  ) async {
    isLoading.value = true;
    var response = await CategoryRepository().getCategoryWiseProduct(
      categorySlug,
      brandId,
      deliveryId,
      minPrice,
      maxPrice,
    );
    if (response.status == 200) {
      categoryProducts.clear();
      category.clear();
      brands.clear();
      collections.clear();
      deliveryType.clear();
      categoryProducts.addAll(response.data?.result?.data ?? []);
      collections.addAll(response.data?.collections ?? []);
      category.addAll(response.data?.category ?? []);
      brands.addAll(response.data?.brands ?? []);
      deliveryType.addAll(response.data?.shipping ?? []);
    } else {
      printLog(response.message);
    }
    isLoading.value = false;
  }

  void filterProducts() async {
    final selectedBrandIds = brands
        .where((brand) => brand.isSelected == true)
        .map((brand) => brand.id.toString())
        .join(', ');
    printLog(selectedBrandIds);

    final selectedCategoryIds = category
        .where((category) => category.isSelected == true)
        .map((category) => category.id.toString())
        .join(', ');
    printLog(selectedCategoryIds);
    final selectedCollectionIds = collections
        .where((collection) => collection.isSelected == true)
        .map((collection) => collection.id.toString())
        .join(', ');
    printLog(selectedCollectionIds);
    final selectedDeliveryTypeIds = deliveryType
        .where((deliveryType) => deliveryType.isSelected == true)
        .map((deliveryType) => deliveryType.id.toString())
        .join(', ');
    printLog(selectedDeliveryTypeIds);
    final selectedPriceRange =
        '${priceRange.value.start} - ${priceRange.value.end}';
    printLog(selectedPriceRange);
    getCategoryWiseProducts(
      selectedCategoryIds,
      selectedBrandIds,
      selectedDeliveryTypeIds,
      priceRange.value.start.toString(),
      priceRange.value.end.toString(),
    );
  }

  void searchProducts(String query) async {
    if (query.isNotEmpty) {
      var response = await CategoryRepository().getSearchItems(query);
      if (response.status == 200) {
        categoryProducts.clear();
        response.data?.product?.forEach((element) {
              categoryProducts.add(CategoryProducts(
                id: element.id,
                title: element.title,
                image: element.image,
                price: element.price,
                rating: element.rating,
                slug: element.slug,
                addToCart: true,
                reviewCount: element.reviewCount,
                quantity: 0,
                selling: element.selling,
                offered: element.offered,
              ));
        });


        printLog(categoryProducts.length);

      } else {
        printLog(response);
      }
    } else {
      categoryProducts.value =
          categoryProducts
              .where(
                (product) =>
                    product.title?.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ??
                    false,
              )
              .toList();
    }
  }

}
