import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/style/app_colors.dart';
import 'package:turi/app/core/widget/global_appbar.dart';

import '../../../core/widget/common_textfield.dart';
import '../../../data/remote/model/checkout/area_response.dart';
import '../../../data/remote/model/checkout/country_response.dart';
import '../../../data/remote/model/checkout/city_response.dart';
import '../../../data/remote/model/checkout/payment_method_response.dart';
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
                  commonTextField(
                    labelText: 'Your Name',
                    icon: Icons.person,
                    controller: controller.name.value,
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    labelText: 'Mobile Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    controller: controller.mobile.value,
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    labelText: 'Email',
                    controller: controller.email.value,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppWidgets().gapH8(),
                  // Country Dropdown
                  SizedBox(
                    height: 40.h,
                    child: Obx(
                      () => DropdownButtonFormField<CountryResponse>(
                        padding: EdgeInsets.zero,
                        iconEnabledColor: AppColors.primaryColor,
                        iconDisabledColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 5),
                          labelText: 'Country',
                          prefixIcon: Icon(
                            Icons.public,
                            color: AppColors.primaryColor,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        value: controller.selectedCountry.value,
                        hint: Text('Select Country'),
                        items:
                            controller.countryList.map((country) {
                              return DropdownMenuItem<CountryResponse>(
                                value: country,
                                child: Text(country.name ?? ''),
                              );
                            }).toList(),
                        onChanged: (CountryResponse? newValue) {
                          controller.selectedCountry.value = newValue;
                          if (newValue != null) {
                            controller.getCitiesByCountry(newValue.id!);
                            printLog('Selected country ID: ${newValue.id}');
                          }
                        },
                      ),
                    ),
                  ),
                  AppWidgets().gapH8(),
                  // City Dropdown
                  SizedBox(
                    height: 40.h,
                    child: Obx(
                      () => DropdownButtonFormField<CityResponse>(
                        padding: EdgeInsets.zero,
                        iconEnabledColor: AppColors.primaryColor,
                        iconDisabledColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(right: 5),
                          labelText: 'City',
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: AppColors.primaryColor,
                          ),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 2,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                        value: controller.selectedCity.value,
                        hint: Text(
                          controller.cityList.isEmpty
                              ? 'Select Country First'
                              : 'Select City',
                        ),
                        items:
                            controller.cityList.map((CityResponse city) {
                              return DropdownMenuItem<CityResponse>(
                                value: city,
                                child: Text(city.name ?? ''),
                              );
                            }).toList(),
                        onChanged:
                            controller.cityList.isEmpty
                                ? null
                                : (CityResponse? newValue) {
                                  controller.selectedCity.value = newValue;
                                  if (newValue != null) {
                                    controller.city.value =
                                        newValue.id.toString();
                                    printLog(
                                      'Selected city ID: ${newValue.id}',
                                    );
                                  }
                                },
                      ),
                    ),
                  ),
                  AppWidgets().gapH8(),
                  // Area Dropdown
               // Area Dropdown
               SizedBox(
                 height: 40.h,
                 child: Obx(
                   () => DropdownButtonFormField<AreaResponse>(
                     padding: EdgeInsets.zero,
                     iconEnabledColor: AppColors.primaryColor,
                     iconDisabledColor: AppColors.primaryColor,
                     decoration: InputDecoration(
                       contentPadding: EdgeInsets.only(right: 5),
                       labelText: 'Area',
                       prefixIcon: Icon(
                         Icons.map,
                         color: AppColors.primaryColor,
                       ),
                       floatingLabelStyle: TextStyle(
                         color: AppColors.primaryColor,
                         fontSize: 14.sp,
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                         borderSide: BorderSide(
                           width: 2,
                           color: AppColors.primaryColor,
                         ),
                       ),
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                         borderSide: BorderSide(
                           width: 1,
                           color: AppColors.primaryColor,
                         ),
                       ),
                     ),
                     value: controller.selectedArea.value,
                     hint: Text(
                       controller.areaList.isEmpty ? 'Select City First' : 'Select Area',
                     ),
                     items: controller.areaList.map((area) {
                       return DropdownMenuItem<AreaResponse>(
                         value: area,
                         child: Text(area.name ?? ''),
                       );
                     }).toList(),
                     onChanged: controller.areaList.isEmpty
                         ? null
                         : (AreaResponse? newValue) {
                             controller.selectedArea.value = newValue;
                             if (newValue != null) {
                               controller.area.value = newValue.id.toString();
                               printLog('Selected area ID: ${newValue.id}');
                             }
                           },
                   ),
                 ),
               ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    controller: controller.address.value,
                    labelText: 'Address',
                    icon: Icons.location_on,
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
                          controller: controller.coupon.value,
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
                          minimumSize: Size(75, 40.h),
                          // Set minimum size to zero
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: Text('Apply'),
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
                    () => Column(
                      children: [
                        // Cash on Delivery - Hardcoded shipping method
                        RadioListTile<String>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          fillColor: MaterialStateProperty.all<Color>(
                            AppColors.primaryColor,
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Inside Dhaka',
                                style: TextStyle(fontSize: 14),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  '60 BDT',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          value: 'Inside Dhaka',
                          groupValue: controller.selectedShippingMethod.value,
                          onChanged: (value) {
                            controller.selectedShippingMethod.value = value!;
                            controller.delivery.value = 60.0;
                            // Set a default shipping ID for cash on delivery
                            controller.shippingId.value = 0;
                            printLog(
                              'Selected shipping: Cash on Delivery - 60 BDT',
                            );
                          },
                        ),
                        // Dynamic shipping methods from API
                        ...controller.shippingInfo.map((shipping) {
                          return RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            fillColor: MaterialStateProperty.all<Color>(
                              AppColors.primaryColor,
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  shipping.title.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    '${shipping.price} BDT',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            value: shipping.title.toString(),
                            groupValue: controller.selectedShippingMethod.value,
                            onChanged: (value) {
                              controller.selectedShippingMethod.value = value!;
                              controller.delivery.value = double.parse(
                                shipping.price.toString(),
                              );
                              controller.shippingId.value = int.parse(
                                shipping.id.toString(),
                              );
                              printLog('Selected shipping id: ${shipping.id}');
                            },
                          );
                        }).toList(),
                      ],
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
                      Text(
                        '${controller.subTotal.value.toStringAsFixed(2)} BDT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping', style: TextStyle(fontSize: 14)),
                      Text(
                        '${controller.delivery.value} BDT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Coupon', style: TextStyle(fontSize: 14)),
                      Text(
                        '${controller.couponAmount.value} BDT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        '${(controller.subTotal.value + controller.delivery.value - controller.couponAmount.value).toStringAsFixed(2)} BDT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
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
                    () => Column(
                      children:
                          controller.paymentMethods.map((
                            PaymentMethodResponse paymentMethod,
                          ) {
                            return RadioListTile<String>(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              fillColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                paymentMethod.name ?? '',
                                style: TextStyle(fontSize: 14),
                              ),
                              value: paymentMethod.name ?? '',
                              groupValue:
                                  controller.selectedPaymentMethod.value,
                              onChanged: (value) {
                                controller.selectedPaymentMethod.value = value!;
                                printLog(
                                  'Selected payment method: ${paymentMethod.name}',
                                );
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          AppWidgets().gapH8(),

          ElevatedButton(
            onPressed: () {
              controller.setShippingInfo();
            },
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
