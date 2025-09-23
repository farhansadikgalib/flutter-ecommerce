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
            SizedBox(height: 16.h),

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
            SizedBox(height: 16.h),

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
            SizedBox(height: 16.h),

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
            SizedBox(height: 16.h),

            // Street Address Field
            _buildStyledField(
              controller: addressController,
              label: 'Address',
              icon: Icons.location_on,
              hintText: 'Enter your detailed address',
              maxLines: 1,
            ),

            SizedBox(height: 24.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
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
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  isEditing ? 'Update Address' : 'Save Address',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),
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
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText ?? label,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
        prefixIcon: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: items.contains(value) ? value : null,
                hint: Text(
                  label,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryColor,
                  size: 20.sp,
                ),
                isExpanded: true,
                items:
                    items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
