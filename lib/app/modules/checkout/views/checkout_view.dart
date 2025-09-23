import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/base/base_view.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
import 'package:ousadbazar/app/core/style/app_colors.dart';
import 'package:ousadbazar/app/core/widget/global_appbar.dart';
import 'package:ousadbazar/app/routes/app_pages.dart';

import '../../../core/style/app_style.dart';
import '../../../core/widget/common_textfield.dart';
import '../../../data/remote/model/checkout/area_response.dart';
import '../../../data/remote/model/checkout/country_response.dart';
import '../../../data/remote/model/checkout/city_response.dart';
import '../../../data/remote/model/checkout/payment_method_response.dart';
import '../../../data/remote/model/address/shipping_address_response.dart';
import '../../address/views/address_form_view.dart';
import '../../address/controllers/address_controller.dart';
import '../controllers/checkout_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
                  _buildAddressSection(),

                  // Country Dropdown (read-only)
                  /*           SizedBox(
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
                        initialValue: controller.selectedCountry.value,
                        items:
                            controller.countryList.isNotEmpty
                                ? [
                                  DropdownMenuItem<CountryResponse>(
                                    value: controller.selectedCountry.value,
                                    child: Text(
                                      controller.selectedCountry.value?.name ??
                                          '',
                                    ),
                                  ),
                                ]
                                : [],
                        onChanged: null, // disables dropdown
                        disabledHint: Text(
                          controller.selectedCountry.value?.name ?? '',
                        ),
                      ),
                    ),
                  ),
                  AppWidgets().gapH8(),
                  // City Dropdown (read-only)
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
                        initialValue: controller.selectedCity.value,
                        items:
                            controller.cityList.isNotEmpty
                                ? [
                                  DropdownMenuItem<CityResponse>(
                                    value: controller.selectedCity.value,
                                    child: Text(
                                      controller.selectedCity.value?.name ?? '',
                                    ),
                                  ),
                                ]
                                : [],
                        onChanged: null, // disables dropdown
                        disabledHint: Text(
                          controller.selectedCity.value?.name ?? '',
                        ),
                      ),
                    ),
                  ),
                  AppWidgets().gapH8(),
                  // Area Dropdown (read-only)
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
                        initialValue: controller.selectedArea.value,
                        items:
                            controller.areaList.isNotEmpty
                                ? [
                                  DropdownMenuItem<AreaResponse>(
                                    value: controller.selectedArea.value,
                                    child: Text(
                                      controller.selectedArea.value?.name ?? '',
                                    ),
                                  ),
                                ]
                                : [],
                        onChanged: null, // disables dropdown
                        disabledHint: Text(
                          controller.selectedArea.value?.name ?? '',
                        ),
                      ),
                    ),
                  ),
                  AppWidgets().gapH8(),
                  commonTextField(
                    controller: controller.address.value,
                    labelText: 'Address',
                    icon: Icons.location_on,
                  ),*/
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
                          fillColor: WidgetStateProperty.all<Color>(
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
                                  'Free',
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          value: '0', // Use ID as string
                          groupValue: controller.selectedShippingMethod.value,
                          onChanged: (value) {
                            controller.selectedShippingMethod.value = value!;
                            controller.delivery.value = 60.0;
                            controller.shippingId.value = 0;
                            printLog(controller.selectedShippingMethod.value);
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
                            fillColor: WidgetStateProperty.all<Color>(
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
                            value: shipping.id.toString(), // Use ID as string
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
                        }),
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
                              fillColor: WidgetStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(
                                paymentMethod.name ?? '',
                                style: TextStyle(fontSize: 14),
                              ),
                              value:
                                  paymentMethod.id
                                      .toString(), // Use ID as string
                              groupValue:
                                  controller.selectedPaymentMethod.value,
                              onChanged: (value) {
                                controller.selectedPaymentMethod.value = value!;
                                printLog(
                                  controller.selectedShippingMethod.value,
                                );
                                printLog(
                                  'Selected payment method id: ${paymentMethod.id}',
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

  Widget _buildAddressSection() {
    return Obx(() {
      final addressController = Get.find<AddressController>();

      // Show loading skeleton if address controller is loading
      if (addressController.isLoading.value) {
        return _buildAddressSkeletonLoader();
      }

      // Sync address list if checkout controller is empty but address controller has data
      // Sync address list if checkout controller is out of sync with address controller
      if (controller.shippingAddressList.length !=
          addressController.shippingAddressList.length) {
        print(
          'CheckoutView: Address lists out of sync (${controller.shippingAddressList.length} vs ${addressController.shippingAddressList.length}) - refreshing',
        );
        controller.shippingAddressList.clear();
        controller.shippingAddressList.addAll(
          addressController.shippingAddressList,
        );
      }

      if (controller.shippingAddressList.isEmpty) {
        return _buildEmptyAddressState();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Shipping Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Spacer(),
              TextButton.icon(
                onPressed: () => _navigateToAddressForm(),
                icon: Icon(
                  Icons.add,
                  size: 16.sp,
                  color: AppColors.primaryColor,
                ),
                label: Text(
                  'Add New',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Divider(color: AppColors.primaryColor),
          SizedBox(height: 8.h),
          _buildSelectedAddress(),
          if (controller.shippingAddressList.length > 1) ...[
            SizedBox(height: 8.h),
            TextButton.icon(
              onPressed: () => _showAddressSelectionDialog(),
              icon: Icon(
                Icons.swap_horiz,
                size: 16.sp,
                color: AppColors.primaryColor,
              ),
              label: Text(
                'Change Address',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ],
      );
    });
  }

  Widget _buildAddressSkeletonLoader() {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        duration: const Duration(milliseconds: 1000),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Shipping Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              Spacer(),
              Bone.button(width: 80.w, height: 28.h),
            ],
          ),
          Divider(color: AppColors.primaryColor),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.primaryColor, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Bone.square(size: 16.sp),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(child: Bone.text(words: 2)),
                    Bone.button(width: 50.w, height: 20.h),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Bone.square(size: 10.sp),
                          SizedBox(width: 4.w),
                          Bone.text(words: 1),
                          SizedBox(width: 4.w),
                          Expanded(child: Bone.text(words: 4)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Bone.square(size: 10.sp),
                          SizedBox(width: 4.w),
                          Bone.text(words: 1),
                          SizedBox(width: 4.w),
                          Expanded(child: Bone.text(words: 2)),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Bone.square(size: 10.sp),
                          SizedBox(width: 4.w),
                          Bone.text(words: 1),
                          SizedBox(width: 4.w),
                          Expanded(child: Bone.text(words: 2)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAddressState() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:40.w,vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 48.sp,
              color: AppColors.gray,
            ),
            SizedBox(height: 12.h),
            Text(
              'No Address Found',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Please add a shipping address to continue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.sp, color: AppColors.textColor),
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddressForm(),
              icon: Icon(Icons.add, size: 16.sp),
              label: Text('Add Address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedAddress() {
    return Obx(() {
      final addressController = Get.find<AddressController>();

      // Try to get selected address, then default, then first available
      AddressResponse? selectedAddress;

      if (addressController.selectedAddressId.value != null) {
        selectedAddress = controller.shippingAddressList.firstWhereOrNull(
          (addr) => addr.id == addressController.selectedAddressId.value,
        );
      }

      selectedAddress ??= addressController.defaultAddress;
      selectedAddress ??=
          controller.shippingAddressList.isNotEmpty
              ? controller.shippingAddressList.first
              : null;

      if (selectedAddress == null) {
        return _buildEmptyAddressState();
      }

      return Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.primaryColor, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.primaryColor,
                    size: 16.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    selectedAddress.title ?? 'Address',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ),
                if ((selectedAddress.addressResponseDefault == "1" ||
                    selectedAddress.addressResponseDefault == "true"))
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      'DEFAULT',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedAddress.address?.isNotEmpty == true)
                    _buildAddressDetailRow(
                      icon: Icons.home_outlined,
                      label: 'Address',
                      value: selectedAddress.address!,
                    ),
                  if (selectedAddress.area?.name != null) ...[
                    SizedBox(height: 4.h),
                    _buildAddressDetailRow(
                      icon: Icons.location_city_outlined,
                      label: 'Area',
                      value: selectedAddress.area!.name!,
                    ),
                  ],
                  if (selectedAddress.city?.name != null) ...[
                    SizedBox(height: 4.h),
                    _buildAddressDetailRow(
                      icon: Icons.location_city,
                      label: 'City',
                      value: selectedAddress.city!.name!,
                    ),
                  ],
                  if (selectedAddress.country?.name != null) ...[
                    SizedBox(height: 4.h),
                    _buildAddressDetailRow(
                      icon: Icons.public,
                      label: 'Country',
                      value: selectedAddress.country!.name!,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAddressDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 10.sp),
        SizedBox(width: 4.w),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 10.sp, color: AppColors.textColor),
          ),
        ),
      ],
    );
  }

  void _navigateToAddressForm({AddressResponse? address}) {
    Get.to(
      () => AddressFormView(address: address),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    )?.then((_) {
      // Refresh address list when returning from form
      _refreshAddressList();
    });
  }

  Future<void> _refreshAddressList() async {
    await controller.refreshAddressList();
  }

  void _showAddressSelectionDialog() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Address',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(Icons.close, size: 20.sp),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                itemCount: controller.shippingAddressList.length,
                itemBuilder: (context, index) {
                  final address = controller.shippingAddressList[index];
                  final addressController = Get.find<AddressController>();
                  final isSelected =
                      address.id == addressController.selectedAddressId.value;

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.primaryColor.withOpacity(0.1)
                              : Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color:
                            isSelected
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        addressController.selectAddress(address.id);
                        Get.back();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.primaryColor,
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  address.title ?? 'Address ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: AppColors.primaryColor,
                                  size: 20.sp,
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            addressController.getFullAddress(address),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
