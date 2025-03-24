import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_search_controller.dart';

class ProductSearchView extends GetView<ProductSearchController> {
  const ProductSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductSearchView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductSearchView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
