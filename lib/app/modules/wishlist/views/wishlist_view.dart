import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/wishlist_controller.dart';

class WishlistView extends GetView<WishlistController> {
  const WishlistView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WishlistView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WishlistView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
