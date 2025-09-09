import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/data/remote/model/checkout/area_response.dart';
import 'package:turi/app/data/remote/model/checkout/city_response.dart';
import 'package:turi/app/data/remote/model/checkout/country_response.dart';
import 'package:turi/app/data/remote/model/checkout/payment_method_response.dart';
import 'package:turi/app/modules/cart/controllers/cart_controller.dart';
import 'package:turi/app/routes/app_pages.dart';

import '../../../data/remote/model/checkout/order_place_request.dart';
import '../../../data/remote/model/checkout/shipping_info_response.dart';
import '../../../data/remote/repository/checkout/checkout_repository.dart';
import '../../../data/remote/model/home/best_selling_product_response.dart';

class CheckoutController extends BaseController {
  final selectedShippingMethod = ''.obs;
  final selectedPaymentMethod = ''.obs;
  final name = TextEditingController().obs;
  final mobile = TextEditingController().obs;
  final email = TextEditingController().obs;
  final address = TextEditingController().obs;
  final coupon = TextEditingController().obs;
  final city = ''.obs;
  final area = ''.obs;

  // Country and City Selection
  final selectedCountry = Rx<CountryResponse?>(null);
  final selectedCity = Rx<CityResponse?>(null);
  final selectedArea = Rx<AreaResponse?>(null);

  final shippingInfo = <ShippingInfo>[].obs;

  final paymentMethods = <PaymentMethodResponse>[].obs;
  final countryList = <CountryResponse>[].obs;
  final cityList = <CityResponse>[].obs;
  final areaList = <AreaResponse>[].obs;

  final args = Get.arguments;
  final cartProducts = <ProductData>[].obs;
  final subTotal = 0.0.obs;
  final delivery = 0.0.obs;
  final couponAmount = 0.0.obs;
  final shippingId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (args != null) {
      cartProducts.addAll(args['cartProducts']);
      subTotal.value = args['subTotal'];
    }

    if (kDebugMode) {
      name.value.text = 'Test User';
      mobile.value.text = '1234567890';
      email.value.text = 'test@gmail.com';
      address.value.text = 'Test Address';
    }

    Future.microtask(() async {
      await getCountryList();
      await getCityList();
      await getAreaList();
      getPaymentMethods();
    });
  }

  Future<void> getPaymentMethods() async {
    var response = await CheckoutRepository().paymentMethods();
    paymentMethods.clear();
    paymentMethods.addAll(response);
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
    if (mobile.value.text.length != 11 || !RegExp(r'^\d{11}\$').hasMatch(mobile.value.text)) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Mobile number must be exactly 11 digits',
      );
      return;
    }
    if (address.value.text.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your address',
      );
      return;
    }
    if (city.value.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select your city',
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

    placeOrder();
  }

  void placeOrder() async {
    printLog('place order');

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
        address: address.value.text,
        countryId: selectedCountry.value?.id.toString(),
        cityId: selectedCity.value?.id.toString(),
        areaId: selectedArea.value?.id.toString(),
        notes: '',
      ),
      paymentMethodId: 1,
      // Assuming 1 for Cash on Delivery
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

  // Method to fetch cities by country ID
  Future<void> getCitiesByCountry(int countryId) async {
    try {
      showLoading();
      cityList.clear();
      selectedCity.value = null;

      var response = await CheckoutRepository().getCity(countryId.toString());
      printLog(response);
      cityList.addAll(response);
    } catch (e) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Failed to load cities: $e',
      );
    } finally {
      hideLoading();
    }
  }
}
