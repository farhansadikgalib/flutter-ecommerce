import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';

import '../../../core/helper/print_log.dart';
import '../../../data/remote/model/address/shipping_address_response.dart';
import '../../../data/remote/model/checkout/area_response.dart';
import '../../../data/remote/model/checkout/city_response.dart';
import '../../../data/remote/model/checkout/country_response.dart';
import '../../../data/remote/repository/address/address_repository.dart';
import '../../../data/remote/repository/checkout/checkout_repository.dart';

class AddressController extends GetxController {
  final shippingAddressList = <AddressResponse>[].obs;
  final isLoading = false.obs;
  final selectedAddressId = Rxn<int>();

  final countryList = <CountryResponse>[].obs;
  final cityList = <CityResponse>[].obs;
  final areaList = <AreaResponse>[].obs;
  final selectedCountry = Rx<CountryResponse?>(null);
  final selectedCity = Rx<CityResponse?>(null);
  final selectedArea = Rx<AreaResponse?>(null);

  @override
  void onInit() {
    super.onInit();
    getAllShippingAddress();
    Future.microtask(() async {
      await getCountryList();
      await getCityList();
      await getAreaList();
    });
  }

  Future<void> getCountryList() async {
    var response = await CheckoutRepository().getCountry();
    countryList.clear();
    countryList.addAll(response);
    // Auto-select the first country and prevent user changes
    if (countryList.isNotEmpty) {
      selectedCountry.value = countryList.first;
    }
  }

  Future<void> getCityList() async {
    var response = await CheckoutRepository().getCity(
      countryList.first.id.toString(),
    );
    printLog(response);
    cityList.clear();
    cityList.addAll(response);
    // Auto-select the first city and prevent user changes
    if (cityList.isNotEmpty) {
      selectedCity.value = cityList.first;
    }
  }

  Future<void> getAreaList() async {
    var response = await CheckoutRepository().getArea(
      cityList.first.id.toString(),
    );
    printLog(response);
    areaList.clear();
    areaList.addAll(response);
    // Auto-select the first area and prevent user changes
    if (areaList.isNotEmpty) {
      selectedArea.value = areaList.first;
    }
  }

  Future<void> getAllShippingAddress() async {
    try {
      isLoading.value = true;
      var response = await AddressRepository().getShippingAddress();
      printLog(
        'AddressController: Loaded ${response.length} addresses from API',
      );

      if (response.isNotEmpty) {
        shippingAddressList.value = response;
        printLog(
          'AddressController: Updated shippingAddressList with ${shippingAddressList.length} addresses',
        );

        // Set the first default address as selected if no address is currently selected
        if (selectedAddressId.value == null) {
          final defaultAddress = response.firstWhereOrNull(
            (address) =>
                address.addressResponseDefault == "1" ||
                address.addressResponseDefault == "true",
          );
          if (defaultAddress != null) {
            selectedAddressId.value = defaultAddress.id;
            printLog(
              'AddressController: Set default address as selected: ${defaultAddress.id}',
            );
          } else if (response.isNotEmpty) {
            // If no default, select the first address
            selectedAddressId.value = response.first.id;
            printLog(
              'AddressController: Set first address as selected: ${response.first.id}',
            );
          }
        } else {
          // Verify that the currently selected address still exists
          final stillExists = response.any(
            (addr) => addr.id == selectedAddressId.value,
          );
          if (!stillExists) {
            // If selected address was deleted, select default or first available
            final defaultAddress = response.firstWhereOrNull(
              (address) =>
                  address.addressResponseDefault == "1" ||
                  address.addressResponseDefault == "true",
            );
            selectedAddressId.value = defaultAddress?.id ?? response.first.id;
            printLog(
              'AddressController: Selected address no longer exists, switched to: ${selectedAddressId.value}',
            );
          }
        }
      } else {
        shippingAddressList.clear();
        selectedAddressId.value = null;
        printLog(
          'AddressController: No addresses found, cleared list and selection',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load addresses',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectAddress(int? addressId) {
    selectedAddressId.value = addressId;
  }

  Future<void> setDefaultAddress(int addressId) async {
    var response = await AddressRepository().defaultAddress(
      addressId.toString(),
    );
    if (response.status == "success") {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address deleted successfully',
      );
      getAllShippingAddress();
    } else {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address deleted successfully',
      );
    }
  }

  Future<void> deleteAddress(int addressId) async {
    var response = await AddressRepository().deleteAddress(
      addressId.toString(),
    );
    if (response.status == "success") {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address deleted successfully',
      );
      getAllShippingAddress();
    } else {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address deleted successfully',
      );
    }
  }

  Future<void> createAddress({
    required String title,
    required String address,
    required String notes,
    required String countryId,
    required String cityId,
    required String areaId,
  }) async {
    var response = await AddressRepository().createAddress(
      title,
      address,
      countryId,
      cityId,
      areaId,
    );
    if (response.status == "success") {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address created successfully',
      );
      await getAllShippingAddress();

      // Select the newly created address (usually the last one if no ID is returned)
      if (shippingAddressList.isNotEmpty) {
        // Try to find the most recently created address or select the last one
        selectedAddressId.value = shippingAddressList.last.id;
        printLog(
          'AddressController: Selected newly created address: ${selectedAddressId.value}',
        );
      }
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message ?? 'Failed to create address',
      );
    }
  }

  Future<void> editAddress({
    required int addressId,
    required String title,
    required String address,
    required String notes,
    required String countryId,
    required String cityId,
    required String areaId,
  }) async {
    var response = await AddressRepository().updateAddress(
      addressId.toString(),
      title,
      address,
      countryId,
      cityId,
      areaId,
    );
    if (response.status == "success") {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message ?? 'Address updated successfully',
      );

      // Keep the edited address selected
      selectedAddressId.value = addressId;
      await getAllShippingAddress();
      printLog('AddressController: Kept edited address selected: $addressId');
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message ?? 'Failed to update address',
      );
    }
  }

  void showDeleteConfirmation(int addressId, String addressTitle) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Are you sure you want to delete "$addressTitle"?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              deleteAddress(addressId);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  AddressResponse? get defaultAddress {
    return shippingAddressList.firstWhereOrNull(
      (address) =>
          address.addressResponseDefault == "1" ||
          address.addressResponseDefault == "true",
    );
  }

  String getFullAddress(AddressResponse address) {
    List<String> addressParts = [];

    if (address.address?.isNotEmpty == true) {
      addressParts.add(address.address!);
    }
    if (address.area?.name?.isNotEmpty == true) {
      addressParts.add(address.area!.name!);
    }
    if (address.city?.name?.isNotEmpty == true) {
      addressParts.add(address.city!.name!);
    }
    if (address.country?.name?.isNotEmpty == true) {
      addressParts.add(address.country!.name!);
    }

    return addressParts.join(', ');
  }
}
