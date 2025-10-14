import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/base/base_view.dart';
import 'package:ousadbazar/app/core/helper/app_helper.dart';
import 'package:ousadbazar/app/core/helper/shared_value_helper.dart';
import 'package:ousadbazar/app/core/style/app_colors.dart';
import '../../../core/helper/app_widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends BaseView<ProfileController> {
  ProfileView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 40.h),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 50.sp,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // User name
                  Text(
                    userName.$,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Phone
                  Text(
                    userPhone.$,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey[600]),
                  ),
                  // Email
                  if (userEmail.$.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      userEmail.$,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Menu Items Section - Account Settings
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // _buildMenuItem(
                  //   icon: Icons.person_outline,
                  //   title: 'Personal Information',
                  //   onTap: () => Get.toNamed('/personal-info'),
                  //   isFirst: true,
                  // ),
                  // Divider(height: 1, indent: 68.w, color: Colors.grey[200]),
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    title: 'My Addresses',
                    onTap: () => Get.toNamed(Routes.ADDRESS),
                    isFirst: true,
                  ),
                  Divider(height: 1, indent: 68.w, color: Colors.grey[200]),
                  _buildMenuItem(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () => AppWidgets().getSnackBar(
                      title: 'Info',
                      message: 'This feature is coming soon!',
                    ),
                  ),
                  Divider(height: 1, indent: 68.w, color: Colors.grey[200]),
                  GetBuilder<ProfileController>(
                    builder: (controller) {
                      return _buildMenuItem(
                        icon: Icons.notifications_outlined,
                        title: 'Notifications',
                        subtitle: notificationsEnabled.$ ? 'Enabled' : 'Disabled',
                        onTap: () => _showNotificationSettingsDialog(context, controller),
                        isLast: true,
                      );
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Support Section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    onTap: () => AppWidgets().getSnackBar(
                      title: 'Info',
                      message: 'This feature is coming soon!',
                    ),
                    isFirst: true,
                  ),
                  Divider(height: 1, indent: 68.w, color: Colors.grey[200]),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () => AppHelper().logout(),
                    isLast: true,
                    isLogout: true,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    bool isFirst = false,
    bool isLast = false,
    bool isLogout = false,
  }) {
    final itemColor = isLogout ? Colors.red[600]! : AppColors.primaryColor;
    final textColor = isLogout ? Colors.red[600]! : Colors.black87;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(16.r) : Radius.zero,
          bottom: isLast ? Radius.circular(16.r) : Radius.zero,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, color: itemColor, size: 24.sp),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: isLogout ? FontWeight.w600 : FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: subtitle == 'Enabled' ? Colors.green[600] : Colors.grey[500],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isLogout)
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14.sp,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationSettingsDialog(BuildContext context, ProfileController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ProfileController>(
          builder: (controller) {
            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              title: Padding(
                padding: EdgeInsets.all(20.w),
                child: Text(
                  'Notification Settings',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(height: 1, color: Colors.grey[300]),

                    // Main Toggle
                    _buildSimpleToggleItem(
                      title: 'Enable All Notifications',
                      icon: Icons.notifications_active,
                      value: notificationsEnabled.$,
                      onChanged: (value) => controller.toggleNotifications(value),
                      isMain: true,
                    ),

                    // Show individual toggles only when notifications are enabled
                    if (notificationsEnabled.$) ...[
                      Divider(height: 1, indent: 20.w, endIndent: 20.w, color: Colors.grey[200]),

                      _buildSimpleToggleItem(
                        title: 'Order Updates',
                        icon: Icons.shopping_bag_outlined,
                        value: orderNotifications.$,
                        onChanged: (value) => controller.toggleOrderNotifications(value),
                      ),

                      Divider(height: 1, indent: 20.w, endIndent: 20.w, color: Colors.grey[200]),

                      _buildSimpleToggleItem(
                        title: 'Delivery Updates',
                        icon: Icons.local_shipping_outlined,
                        value: deliveryNotifications.$,
                        onChanged: (value) => controller.toggleDeliveryNotifications(value),
                      ),

                      Divider(height: 1, indent: 20.w, endIndent: 20.w, color: Colors.grey[200]),

                      _buildSimpleToggleItem(
                        title: 'Promotional Offers',
                        icon: Icons.local_offer_outlined,
                        value: promotionalNotifications.$,
                        onChanged: (value) => controller.togglePromotionalNotifications(value),
                      ),

                      Divider(height: 1, indent: 20.w, endIndent: 20.w, color: Colors.grey[200]),

                      _buildSimpleToggleItem(
                        title: 'New Arrivals',
                        icon: Icons.new_releases_outlined,
                        value: newArrivalsNotifications.$,
                        onChanged: (value) => controller.toggleNewArrivalsNotifications(value),
                      ),
                    ],

                    SizedBox(height: 8.h),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  ),
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildSimpleToggleItem({
    required String title,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool isMain = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: value ? AppColors.primaryColor : Colors.grey[400],
            size: 22.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isMain ? 16.sp : 15.sp,
                fontWeight: isMain ? FontWeight.w600 : FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildDialogNotificationToggle({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: value ? AppColors.primaryColor.withOpacity(0.05) : Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: value ? AppColors.primaryColor.withOpacity(0.2) : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: value
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: value ? AppColors.primaryColor : Colors.grey[400],
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: value ? Colors.black87 : Colors.grey[700],
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: value ? Colors.grey[600] : Colors.grey[500],
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.white,
              activeTrackColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }
}
