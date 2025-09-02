import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TransactionsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TransactionsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
