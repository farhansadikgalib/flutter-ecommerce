import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';

import '../controllers/cart_controller.dart';

class CartView extends BaseView<CartController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('CartView'),
      centerTitle: true,
    );
  }

  @override
  Widget body(BuildContext context) {
    return ListView(
      children: [



      ],
    );
  }

}
