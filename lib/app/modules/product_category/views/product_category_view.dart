import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_category_controller.dart';

class ProductCategoryView extends GetView<ProductCategoryController> {
  const ProductCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductCategoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductCategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
