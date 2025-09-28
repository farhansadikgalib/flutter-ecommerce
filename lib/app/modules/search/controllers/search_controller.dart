import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/debounce_helper.dart';
import '../../../data/remote/model/search/search_response.dart';
import '../../../data/remote/repository/category/category_repository.dart';

class SearchController extends GetxController {
  final FocusNode searchFocusNode = FocusNode(canRequestFocus: true);
  final searchController = TextEditingController().obs;
  final searchProductList = <SearchProducts>[];
  final DebounceHelper debounceHelper = DebounceHelper();

  // Add loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  @override
  void onClose() {
    searchFocusNode.dispose();
    super.onClose();
  }

  void searchProducts(String query) async {
    if (query.isNotEmpty) {
      isLoading.value = true; // Start loading
      searchProductList.clear();

      try {
        var response = await CategoryRepository().getSearchItems(query);
        searchProductList.addAll(response.products ?? []);
        searchProductList.reactive;
        searchController.refresh();
      } catch (e) {
        // Handle error if needed
        print('Search error: $e');
      } finally {
        isLoading.value = false; // Stop loading
      }
    } else {
      isLoading.value = false; // Stop loading if query is empty
    }
  }
}
