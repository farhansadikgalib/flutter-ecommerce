import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/style/app_colors.dart';
import '../../../data/remote/model/address/shipping_address_response.dart';
import '../controllers/address_controller.dart';

class AddressFormView extends GetView<AddressController> {
  final AddressResponse? address;
  final bool isEditing;

  const AddressFormView({super.key, this.address})
    : isEditing = address != null;

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final addressController = TextEditingController();

    // Pre-fill with existing data if editing, otherwise use defaults
    if (isEditing) {
      titleController.text = address!.title ?? '';
      addressController.text = address!.address ?? '';

      // Set selected values for editing
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (address!.countryId != null) {
          final country = controller.countryList.firstWhereOrNull(
            (c) => c.id.toString() == address!.countryId,
          );
          if (country != null) {
            controller.selectedCountry.value = country;
          }
        }

        if (address!.cityId != null) {
          final city = controller.cityList.firstWhereOrNull(
            (c) => c.id.toString() == address!.cityId,
          );
          if (city != null) {
            controller.selectedCity.value = city;
          }
        }

        if (address!.areaId != null) {
          final area = controller.areaList.firstWhereOrNull(
            (a) => a.id.toString() == address!.areaId,
          );
          if (area != null) {
            controller.selectedArea.value = area;
          }
        }
      });
    } else {
      titleController.text = '';
      addressController.text = '';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: -10,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isEditing ? 'Edit Address' : 'Add Address',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            // Title Field
            _buildStyledField(
              controller: titleController,
              label: 'Title',
              icon: Icons.label_outline,
              hintText: 'Enter address title (e.g., Home, Office)',
            ),
            SizedBox(height: 4.h),

            // Country Dropdown
            Obx(
              () => _buildStyledDropdownField(
                label: 'Country',
                value: controller.selectedCountry.value?.name ?? 'Bangladesh',
                icon: Icons.public,
                items:
                    controller.countryList
                        .map((country) => country.name ?? '')
                        .toList(),
                onChanged: (value) {
                  final selectedCountry = controller.countryList
                      .firstWhereOrNull((country) => country.name == value);
                  if (selectedCountry != null) {
                    controller.selectedCountry.value = selectedCountry;
                    controller.selectedCity.value = null;
                    controller.selectedArea.value = null;
                    controller.getCityList();
                  }
                },
              ),
            ),
            SizedBox(height: 4.h),

            // City Dropdown
            Obx(
              () => _buildStyledDropdownField(
                label: 'City',
                value: controller.selectedCity.value?.name ?? 'Dhaka',
                icon: Icons.location_city,
                items:
                    controller.cityList.map((city) => city.name ?? '').toList(),
                onChanged: (value) {
                  final selectedCity = controller.cityList.firstWhereOrNull(
                    (city) => city.name == value,
                  );
                  if (selectedCity != null) {
                    controller.selectedCity.value = selectedCity;
                    controller.selectedArea.value = null;
                    controller.getAreaList();
                  }
                },
              ),
            ),
            SizedBox(height: 4.h),

            // Area Dropdown
            Obx(
              () => _buildStyledDropdownField(
                label: 'Area',
                value: controller.selectedArea.value?.name ?? 'Aftab Nagar',
                icon: Icons.location_city_outlined,
                items:
                    controller.areaList.map((area) => area.name ?? '').toList(),
                onChanged: (value) {
                  final selectedArea = controller.areaList.firstWhereOrNull(
                    (area) => area.name == value,
                  );
                  if (selectedArea != null) {
                    controller.selectedArea.value = selectedArea;
                  }
                },
              ),
            ),
            SizedBox(height: 4.h),

            // Street Address Field
            _buildStyledField(
              controller: addressController,
              label: 'Address',
              icon: Icons.location_on,
              hintText: 'Enter your detailed address',
              maxLines: 1,
            ),

            SizedBox(height: 4.h),

            // Save Button
            Container(
              width: double.infinity,
              height: 42.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty ||
                      addressController.text.trim().isEmpty ||
                      controller.selectedCountry.value == null ||
                      controller.selectedCity.value == null ||
                      controller.selectedArea.value == null) {
                    Get.snackbar(
                      'Error',
                      'Please fill all fields',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }

                  if (isEditing) {
                    controller.editAddress(
                      addressId: address!.id!,
                      title: titleController.text.trim(),
                      address: addressController.text.trim(),
                      notes: '',
                      countryId:
                          controller.selectedCountry.value?.id?.toString() ??
                          address!.countryId ??
                          '1',
                      cityId:
                          controller.selectedCity.value?.id?.toString() ??
                          address!.cityId ??
                          '1',
                      areaId:
                          controller.selectedArea.value?.id?.toString() ??
                          address!.areaId ??
                          '1',
                    );
                  } else {
                    controller.createAddress(
                      title: titleController.text.trim(),
                      address: addressController.text.trim(),
                      notes: '',
                      countryId:
                          controller.selectedCountry.value?.id?.toString() ??
                          '1',
                      cityId:
                          controller.selectedCity.value?.id?.toString() ?? '1',
                      areaId:
                          controller.selectedArea.value?.id?.toString() ?? '1',
                    );
                  }

                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isEditing ? 'Update Address' : 'Save Address',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hintText,
    int maxLines = 1,
  }) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText ?? 'Enter your $label',
          prefixIcon: Icon(icon, size: 18.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
        ),
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
      ),
    );
  }

  Widget _buildStyledDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return SizedBox(
      height: 50.h,
      child: DropdownButtonFormField<String>(
        value: items.contains(value) ? value : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, size: 18.sp),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 10.h,
          ),
        ),
        style: TextStyle(fontSize: 14.sp, color: Colors.black),
        items:
            (() {
              // Create a new list with the current value first, then the rest
              List<String> reorderedItems = [];
              if (items.contains(value) && value.isNotEmpty) {
                reorderedItems.add(value);
                reorderedItems.addAll(items.where((item) => item != value));
              } else {
                reorderedItems = items;
              }

              return reorderedItems.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                );
              }).toList();
            })(),
        onChanged: onChanged,
        isExpanded: true,
      ),
    );
  }
}
