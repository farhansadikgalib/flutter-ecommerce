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
      searchProductList.clear();
      var response = await CategoryRepository().getSearchItems(query);
      searchProductList.addAll(response.products ?? []);
      searchProductList.reactive;
      searchController.refresh();
    }
  }
}
