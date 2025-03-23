import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
