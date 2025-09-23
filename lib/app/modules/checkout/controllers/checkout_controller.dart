import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ousadbazar/app/core/base/base_controller.dart';
import 'package:ousadbazar/app/core/helper/app_widgets.dart';
import 'package:ousadbazar/app/core/helper/print_log.dart';
import 'package:ousadbazar/app/core/helper/shared_value_helper.dart';
import 'package:ousadbazar/app/data/remote/model/checkout/area_response.dart';
import 'package:ousadbazar/app/data/remote/model/checkout/city_response.dart';
import 'package:ousadbazar/app/data/remote/model/checkout/country_response.dart';
import 'package:ousadbazar/app/data/remote/model/checkout/payment_method_response.dart';
import 'package:ousadbazar/app/modules/address/controllers/address_controller.dart';
import 'package:ousadbazar/app/modules/cart/controllers/cart_controller.dart';
import 'package:ousadbazar/app/routes/app_pages.dart';

import '../../../data/remote/model/address/shipping_address_response.dart';
import '../../../data/remote/model/checkout/order_place_request.dart';
import '../../../data/remote/model/checkout/shipping_info_response.dart';
import '../../../data/remote/repository/checkout/checkout_repository.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';

class CheckoutController extends BaseController {
  final selectedShippingMethod = '0'.obs;
  final selectedPaymentMethod = ''.obs;
  final name = TextEditingController().obs;
  final mobile = TextEditingController().obs;
  final email = TextEditingController().obs;
  final coupon = TextEditingController().obs;

  final shippingInfo = <ShippingInfo>[].obs;

  final paymentMethods = <PaymentMethodResponse>[].obs;

  final args = Get.arguments;
  final cartProducts = <ProductData>[].obs;
  final subTotal = 0.0.obs;
  final delivery = 0.0.obs;
  final couponAmount = 0.0.obs;
  final shippingId = 0.obs;
  final shippingAddressList = <AddressResponse>[].obs;

  @override
  void onInit() {
    super.onInit();
    name.value.text = userName.$;
    email.value.text = userEmail.$;
    mobile.value.text = userPhone.$;

    loadAddressData();

    // Listen to address controller changes
    final addressController = Get.find<AddressController>();
    ever(addressController.shippingAddressList, (addresses) {
      printLog('CheckoutController: Address list changed, syncing...');
      shippingAddressList.clear();
      shippingAddressList.addAll(addresses);
    });

    if (args != null) {
      cartProducts.addAll(args['cartProducts']);
      subTotal.value = args['subTotal'];
    }
    getPaymentMethods();
  }

  Future<void> loadAddressData() async {
    try {
      var addressController = Get.find<AddressController>();

      if (addressController.shippingAddressList.isEmpty) {
        await addressController.getAllShippingAddress();
      }

      shippingAddressList.clear();
      shippingAddressList.addAll(addressController.shippingAddressList);

      printLog('Loaded ${shippingAddressList.length} addresses in checkout');
    } catch (e) {
      printLog('Error loading address data: $e');
    }
  }

  Future<void> refreshAddressList() async {
    try {
      var addressController = Get.find<AddressController>();
      await addressController.getAllShippingAddress();
      shippingAddressList.clear();
      shippingAddressList.addAll(addressController.shippingAddressList);
      printLog(
        'CheckoutController: Refreshed address list - ${shippingAddressList.length} addresses',
      );
    } catch (e) {
      printLog('CheckoutController: Error refreshing address data: $e');
    }
  }

  Future<void> getPaymentMethods() async {
    var response = await CheckoutRepository().paymentMethods();
    paymentMethods.clear();
    paymentMethods.addAll(response);
    selectedPaymentMethod.value = '1';
  }

  Future<void> getShippingInfo() async {
    var response = await CheckoutRepository().getShippingInfo();
    if (response.status == 200) {
      shippingInfo.clear();
      shippingInfo.addAll(response.data!);
    } else {
      printLog(response.message);
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message.toString(),
      );
    }
  }

  Future<void> setShippingInfo() async {
    if (name.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your name',
      );
      return;
    }
    if (email.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your email',
      );
      return;
    }
    if (mobile.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your mobile number',
      );
      return;
    }
    // Mobile number must be exactly 11 digits and numeric
    if (mobile.value.text.length != 11) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Mobile number must be exactly 11 digits',
      );
      return;
    }

    if (selectedPaymentMethod.value.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select payment method',
      );
      return;
    }

    if (selectedShippingMethod.value.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select shipping method',
      );
      return;
    }

    // Validate address selection
    if (shippingAddressList.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please add a shipping address',
      );
      return;
    }

    final addressController = Get.find<AddressController>();
    if (addressController.selectedAddressId.value == null &&
        addressController.defaultAddress == null) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select a shipping address',
      );
      return;
    }

    placeOrder();
  }

  void placeOrder() async {
    printLog('place order');

    // Get the selected address data
    final addressController = Get.find<AddressController>();
    AddressResponse? selectedAddress;

    if (addressController.selectedAddressId.value != null) {
      selectedAddress = shippingAddressList.firstWhereOrNull(
        (addr) => addr.id == addressController.selectedAddressId.value,
      );
    }

    selectedAddress ??= addressController.defaultAddress;
    selectedAddress ??=
        shippingAddressList.isNotEmpty ? shippingAddressList.first : null;

    printLog(
      'Selected address for order: ${selectedAddress?.id} - ${selectedAddress?.title}',
    );
    printLog(
      'Address details: ${selectedAddress?.address}, ${selectedAddress?.city?.name}',
    );

    OderPlaceRequest orderRequest = OderPlaceRequest(
      saleProducts:
          cartProducts.map((product) {
            final price =
                double.tryParse(
                  product.packSize?.sellingPrice?.toString() ??
                      product.productPrices?.sellingPrice?.toString() ??
                      '0',
                ) ??
                0.0;
            final quantity = product.quantity ?? 1;
            final packQuantity =
                int.tryParse(product.packSize?.quantity?.toString() ?? '1') ??
                1;

            return SaleProduct(
              productId: product.id.toString(),
              productName: product.name,
              price: price.toString(),
              quantity: quantity.toString(),
              packSizeId: product.packSize?.id.toString(),
              packSizeQuantity: packQuantity.toString(),
              totalQuantity: (quantity * packQuantity).toString(),
              total: (price * quantity).toString(),
            );
          }).toList(),
      subTotal: subTotal.value.toInt(),
      total: (subTotal.value + delivery.value - couponAmount.value).toInt(),
      shippingCost: delivery.value.toInt(),
      billingAddress: BillingAddress(
        fullName: name.value.text,
        mobile: mobile.value.text,
        address: selectedAddress?.address ?? '',
        countryId: selectedAddress?.countryId.toString(),
        cityId: selectedAddress?.cityId.toString(),
        areaId: selectedAddress?.areaId.toString(),
        customerAddressId: selectedAddress?.id?.toString(),
        notes: selectedAddress?.notes ?? '',
      ),
      paymentMethodId: int.tryParse(selectedPaymentMethod.value) ?? 1,
      customerId: int.tryParse(userId.$) ?? 0,
    );

    var response = await CheckoutRepository().placeAnOrder(orderRequest);

    if (response.status == 'success') {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message.toString(),
      );
      Get.find<CartController>().allCartProducts.clear();
      Get.find<CartController>().cartCount.value = 0;
      Get.offAllNamed(Routes.DASHBOARD);
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message.toString(),
      );
    }
  }
}
