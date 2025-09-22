import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/widget/global_appbar.dart';

import '../../../core/style/app_colors.dart';
import '../../../core/style/app_style.dart';
import '../../../data/remote/model/address/shipping_address_response.dart';
import '../controllers/address_controller.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: globalAppBar(context, 'Addresses', showBackButton: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        if (controller.shippingAddressList.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: controller.getAllShippingAddress,
          color: AppColors.primaryColor,
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.shippingAddressList.length,
            itemBuilder: (context, index) {
              final address = controller.shippingAddressList[index];
              return _buildEnhancedAddressCard(address, index);
            },
          ),
        );
      }),
      floatingActionButton: _buildSimpleFAB(),
    );
  }

  Widget _buildLoadingState() {
    return const Center(child: SizedBox.shrink());
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_off_outlined,
              size: 64.sp,
              color: AppColors.gray,
            ),
            SizedBox(height: 24.h),
            Text(
              'No Addresses Found',
              style: textHeaderStyle(fontSize: 20, color: AppColors.black),
            ),
            SizedBox(height: 8.h),
            Text(
              'Add your first address to get started',
              textAlign: TextAlign.center,
              style: textRegularStyle(fontSize: 14, color: AppColors.textColor),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () => _showAddressDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Add Address', style: textButtonStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedAddressCard(AddressResponse address, int index) {
    final isDefault =
        address.addressResponseDefault == "1" ||
        address.addressResponseDefault == "true";
    final isSelected = controller.selectedAddressId.value == address.id;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected ? AppColors.primaryColor : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => controller.selectAddress(address.id),
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and default badge
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.title ?? 'Address ${index + 1}',
                          style: textAppBarStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isDefault)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.white, size: 12.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'DEFAULT',
                            style: textRegularStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (isSelected && !isDefault)
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                ],
              ),

              SizedBox(height: 16.h),

              // Address details
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAddressDetailRow(
                      icon: Icons.home_outlined,
                      label: 'Address',
                      value: address.address ?? 'Not specified',
                    ),
                    if (address.area?.name != null) ...[
                      SizedBox(height: 8.h),
                      _buildAddressDetailRow(
                        icon: Icons.location_city_outlined,
                        label: 'Area',
                        value: address.area!.name!,
                      ),
                    ],
                    if (address.city?.name != null) ...[
                      SizedBox(height: 8.h),
                      _buildAddressDetailRow(
                        icon: Icons.location_city,
                        label: 'City',
                        value: address.city!.name!,
                      ),
                    ],
                    if (address.country?.name != null) ...[
                      SizedBox(height: 8.h),
                      _buildAddressDetailRow(
                        icon: Icons.public,
                        label: 'Country',
                        value: address.country!.name!,
                      ),
                    ],
                  ],
                ),
              ),

              // Notes section
              if (address.notes?.isNotEmpty == true) ...[
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: Colors.blue.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.note_outlined,
                        color: Colors.blue.shade600,
                        size: 16.sp,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notes',
                              style: textRegularStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue.shade600,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              address.notes!,
                              style: textRegularStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Action buttons
              Row(
                children: [
                  if (!isDefault)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed:
                            () => controller.setDefaultAddress(address.id!),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primaryColor),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.star_outline,
                          color: AppColors.primaryColor,
                          size: 16.sp,
                        ),
                        label: Text(
                          'Default',
                          style: textRegularStyle(
                            fontSize: 12,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  if (!isDefault) SizedBox(width: 8.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showAddressDialog(address: address),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: Icon(
                        Icons.edit_outlined,
                        color: Colors.grey.shade600,
                        size: 16.sp,
                      ),
                      label: Text(
                        'Edit',
                        style: textRegularStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          () => controller.showDeleteConfirmation(
                            address.id!,
                            address.title ?? 'Address ${index + 1}',
                          ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade300),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red.shade600,
                        size: 16.sp,
                      ),
                      label: Text(
                        'Delete',
                        style: textRegularStyle(
                          fontSize: 12,
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 14.sp),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: textRegularStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: textRegularStyle(fontSize: 12, color: AppColors.textColor),
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  Widget _buildSimpleFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _showAddressDialog(),
      backgroundColor: AppColors.primaryColor,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text('Add Address', style: textButtonStyle(fontSize: 14)),
    );
  }

  void _showAddressDialog({AddressResponse? address}) {
    final isEditing = address != null;
    final titleController = TextEditingController();
    final addressController = TextEditingController();

    // Pre-fill with existing data if editing, otherwise use defaults
    if (isEditing) {
      titleController.text = address.title ?? '';
      addressController.text = address.address ?? '';

      // Set selected values for editing
      if (address.countryId != null) {
        final country = controller.countryList.firstWhereOrNull(
          (c) => c.id.toString() == address.countryId,
        );
        if (country != null) {
          controller.selectedCountry.value = country;
        }
      }

      if (address.cityId != null) {
        final city = controller.cityList.firstWhereOrNull(
          (c) => c.id.toString() == address.cityId,
        );
        if (city != null) {
          controller.selectedCity.value = city;
        }
      }

      if (address.areaId != null) {
        final area = controller.areaList.firstWhereOrNull(
          (a) => a.id.toString() == address.areaId,
        );
        if (area != null) {
          controller.selectedArea.value = area;
        }
      }
    } else {
      titleController.text = 'Home';
      addressController.text = 'Comilla';
    }

    Get.to(
      () => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.close, color: AppColors.black),
            onPressed: () => Get.back(),
          ),
          title: Text(
            isEditing ? 'Edit Address' : 'Add New Address',
            style: textAppBarStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    addressController.text.trim().isEmpty ||
                    controller.selectedCountry.value == null ||
                    controller.selectedCity.value == null ||
                    controller.selectedArea.value == null) {
                  Get.snackbar(
                    'Error',
                    'Please fill in all required fields and select location',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                if (isEditing) {
                  controller.editAddress(
                    addressId: address.id!,
                    title: titleController.text.trim(),
                    address: addressController.text.trim(),
                    notes: '',
                    countryId:
                        controller.selectedCountry.value?.id?.toString() ??
                        address.countryId ??
                        '1',
                    cityId:
                        controller.selectedCity.value?.id?.toString() ??
                        address.cityId ??
                        '1',
                    areaId:
                        controller.selectedArea.value?.id?.toString() ??
                        address.areaId ??
                        '1',
                  );
                } else {
                  controller.createAddress(
                    title: titleController.text.trim(),
                    address: addressController.text.trim(),
                    notes: '',
                    countryId:
                        controller.selectedCountry.value?.id?.toString() ?? '1',
                    cityId:
                        controller.selectedCity.value?.id?.toString() ?? '1',
                    areaId:
                        controller.selectedArea.value?.id?.toString() ?? '1',
                  );
                }

                Get.back();
              },
              child: Text(
                'SAVE',
                style: textRegularStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Title Field
              _buildSimpleField(
                controller: titleController,
                label: 'Title',
                icon: Icons.label_outline,
              ),
              SizedBox(height: 20.h),

              // Country Dropdown
              Obx(
                () => _buildSimpleDropdownField(
                  label: 'Country',
                  value:
                      controller.selectedCountry.value?.name ??
                      'Select Country',
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
              SizedBox(height: 20.h),

              // City Dropdown
              Obx(
                () => _buildSimpleDropdownField(
                  label: 'City',
                  value: controller.selectedCity.value?.name ?? 'Select City',
                  icon: Icons.location_city,
                  items:
                      controller.cityList
                          .map((city) => city.name ?? '')
                          .toList(),
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
              SizedBox(height: 20.h),

              // Area Dropdown
              Obx(
                () => _buildSimpleDropdownField(
                  label: 'Area',
                  value: controller.selectedArea.value?.name ?? 'Select Area',
                  icon: Icons.location_city_outlined,
                  items:
                      controller.areaList
                          .map((area) => area.name ?? '')
                          .toList(),
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
              SizedBox(height: 20.h),

              // Street Address Field (moved to end)
              _buildSimpleField(
                controller: addressController,
                label: 'Street Address',
                icon: Icons.location_on_outlined,
                maxLines: 3,
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildEnhancedField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textRegularStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textRegularStyle(
              fontSize: 14,
              color: AppColors.textColor.withOpacity(0.6),
            ),
            prefixIcon: Container(
              padding: EdgeInsets.all(12.w),
              child: Icon(icon, color: AppColors.primaryColor, size: 20.sp),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textRegularStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textRegularStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              hint: Row(
                children: [
                  Icon(icon, color: AppColors.primaryColor, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    value,
                    style: textRegularStyle(
                      fontSize: 14,
                      color:
                          value.startsWith('Select')
                              ? AppColors.textColor.withOpacity(0.6)
                              : AppColors.black,
                    ),
                  ),
                ],
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
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: AppColors.primaryColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            item,
                            style: textRegularStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnhancedDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textRegularStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              hint: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      icon,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    value,
                    style: textRegularStyle(
                      fontSize: 14,
                      color:
                          value.startsWith('Select')
                              ? AppColors.textColor.withOpacity(0.6)
                              : AppColors.black,
                    ),
                  ),
                ],
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
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            child: Icon(
                              icon,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            item,
                            style: textRegularStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFunctionalDropdownField({
    required String label,
    required String value,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textRegularStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : null,
              hint: Row(
                children: [
                  Icon(icon, color: AppColors.primaryColor, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    value,
                    style: textRegularStyle(
                      fontSize: 14,
                      color: AppColors.black,
                    ),
                  ),
                ],
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
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            color: AppColors.primaryColor,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            item,
                            style: textRegularStyle(
                              fontSize: 14,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
