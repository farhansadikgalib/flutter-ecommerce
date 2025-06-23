import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/helper/app_helper.dart';
import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/core/style/app_colors.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.person,
        'title': 'Personal Information',
        'onTap': () => Get.toNamed('/personal-info'),
      },
      {
        'icon': Icons.location_on,
        'title': 'Address',
        'onTap': () => Get.toNamed('/address'),
      },
      {
        'icon': Icons.payment,
        'title': 'Payment Methods',
        'onTap': () => Get.toNamed('/payment'),
      },
      {
        'icon': Icons.notifications,
        'title': 'Notifications',
        'onTap': () => Get.toNamed('/notifications'),
      },
      {
        'icon': Icons.help_outline,
        'title': 'Help & Support',
        'onTap': () => Get.toNamed('/help'),
      },
      {
        'icon': Icons.logout,
        'title': 'Logout',
        'onTap': () => AppHelper().logout(),
      },
    ];

    return Scaffold(
      body: Column(
        children: [
          // User info section
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  userName.$,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail.$,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          const Divider(),

          // Menu items - dynamically generated from the list
          Expanded(
            child: ListView.separated(
              itemCount: menuItems.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return ListTile(
                  leading: Icon(
                    item['icon'],
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text(item['title']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: item['onTap'],
                );
              },
            ),
          ),

          // Logout button at the bottom
        ],
      ),
    );
  }
}
