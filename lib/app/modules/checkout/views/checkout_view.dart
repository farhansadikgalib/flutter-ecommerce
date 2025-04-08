import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/style/app_colors.dart';
import 'package:turi/app/core/widget/global_appbar.dart';

import '../../../core/widget/common_textfield.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends BaseView<CheckoutController> {
  CheckoutView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return globalAppBar(context, 'Checkout');
  }

  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(color: AppColors.primaryColor),
                  commonTextField(labelText: 'Your Name', icon: Icons.person),
                  AppWidgets().gapH8(),
                  commonTextField(
                    labelText: 'Mobile Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    labelText: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    labelText: 'Address',
                    icon: Icons.location_on,
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(labelText: 'City', icon: Icons.location_city),
                  AppWidgets().gapH8(),
                ],
              ),
            ),
          ),

          AppWidgets().gapH8(),

          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Coupon',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(color: AppColors.primaryColor),
                  Row(
                    children: [
                      Expanded(
                        child: commonTextField(
                          labelText: 'Coupon Code',
                          icon: Icons.card_giftcard,
                        ),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Add coupon apply logic here
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(75, 40.h), // Set minimum size to zero
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),

          AppWidgets().gapH8(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shipping Method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(color: AppColors.primaryColor),

                  AppWidgets().gapH8(),
                  Obx(
                    () => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Inside Manama City (0.50 BD)',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: 'Inside Manama City',
                      groupValue: controller.selectedShippingMethod.value,
                      onChanged: (value) {
                        controller.selectedShippingMethod.value = value!;
                      },
                    ),
                  ),
                  Obx(
                    () => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Outside Manama City (1.00 BD)',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: 'Outside Manama City',
                      groupValue: controller.selectedShippingMethod.value,
                      onChanged: (value) {
                        controller.selectedShippingMethod.value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          AppWidgets().gapH8(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Details',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(color: AppColors.primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total', style: TextStyle(fontSize: 14)),
                      Text('3.05 BD', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: TextStyle(fontSize: 14)),
                      Text('0.50 BD', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Coupon', style: TextStyle(fontSize: 14)),
                      Text('0.00 BD', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Divider(color: AppColors.primaryColor),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '3.55 BD',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          AppWidgets().gapH8(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Divider(color: AppColors.primaryColor),
                  AppWidgets().gapH8(),
                  Obx(
                    () => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Cash on delivery',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: 'Cash on delivery',
                      groupValue: controller.selectedPaymentMethod.value,
                      onChanged: (value) {
                        controller.selectedPaymentMethod.value = value!;
                      },
                    ),
                  ),
                  Obx(
                    () => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Pay with Stripe',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: 'Pay with Stripe',
                      groupValue: controller.selectedPaymentMethod.value,
                      onChanged: (value) {
                        controller.selectedPaymentMethod.value = value!;
                      },
                    ),
                  ),
                  Obx(
                    () => RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      fillColor: MaterialStateProperty.all<Color>(
                        AppColors.primaryColor,
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        'Pay with Paypal',
                        style: TextStyle(fontSize: 14),
                      ),
                      value: 'Pay with Paypal',
                      groupValue: controller.selectedPaymentMethod.value,
                      onChanged: (value) {
                        controller.selectedPaymentMethod.value = value!;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          AppWidgets().gapH8(),

          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 40.h),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }
}
