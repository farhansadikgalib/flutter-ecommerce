import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_controller.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/helper/print_log.dart';
import 'package:turi/app/core/helper/shared_value_helper.dart';
import 'package:turi/app/routes/app_pages.dart';

import '../../../data/remote/model/cart/cart_items_response.dart';
import '../../../data/remote/model/checkout/order_place_request.dart';
import '../../../data/remote/model/checkout/shipping_info_response.dart';
import '../../../data/remote/model/home/home_response.dart';
import '../../../data/remote/repository/checkout/checkout_repository.dart';

class CheckoutController extends BaseController {
  final selectedShippingMethod = ''.obs;
  final selectedPaymentMethod = ''.obs;
  final name = TextEditingController().obs;
  final mobile = TextEditingController().obs;
  final email = TextEditingController().obs;
  final address = TextEditingController().obs;
  final coupon = TextEditingController().obs;
  final city = ''.obs;

  final shippingInfo = <ShippingInfo>[].obs;

  final cityList = [
    "Manama",
    "Muharraq",
    "Riffa",
    "Zallaq",
    "Tubli",
    "Abu Saiba",
    "A'Ali",
    "Sitra",
    "'Hamad Town'",
    "Al Budayyi",
    "ISA Town",
  ];

  final args = Get.arguments;
  final cartProducts = <CartProducts>[].obs;
  final subTotal = 0.0.obs;
  final delivery = 0.0.obs;
  final couponAmount = 0.0.obs;
  final shippingId = 0.obs;


  @override
  void onInit() {
    super.onInit();
    city.value =cityList.first;
    getShippingInfo();
    if (args != null) {
      cartProducts.addAll(args['cartProducts']);
      subTotal.value = args['subTotal'];
    }

    if(kDebugMode){
      name.value.text = 'Test User';
      mobile.value.text = '1234567890';
      email.value.text = 'test@gmail.com';
      address.value.text = 'Test Address';
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


  Future<void> setShippingInfo()async{

    if(name.value.text.isEmpty){
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your name',
      );
      return;
    }
    if(email.value.text.isEmpty){
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your email',
      );
      return;
    }
    if(mobile.value.text.isEmpty){
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your mobile number',
      );
      return;
    }
    if(address.value.text.isEmpty){
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please enter your address',
      );
      return;
    }
    if(city.value.isEmpty){
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select your city',
      );
      return;
    }
    if(selectedPaymentMethod.value.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select payment method',
      );
      return;
    }

    if(selectedShippingMethod.value.isEmpty) {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Please select shipping method',
      );
      return;
    }


    var response = await CheckoutRepository().setShippingAddress(
      name.value.text,
      email.value.text,
      mobile.value.text,
      address.value.text,
      city.value,
    );
    if (response.status == 200) {
      placeOrder();
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message.toString(),
      );
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message.toString(),
      );
    }
  }

  void placeOrder() async {

    printLog('place order');

    if(selectedPaymentMethod.value != 'Cash On Delivery') {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: 'Method not available',
      );
      printLog('sm methods');

      return;
    }


    OderPlaceRequest orderRequest = OderPlaceRequest(
      orderMethod: 1,
      userAddressId: shippingId.value,
      productId: cartProducts.map((product) => product.id!).toList(),
      quantity: cartProducts.map((product) => product.quantity!).toList(),
      shippingPlaceId: List.generate(cartProducts.length, (index) => shippingId.value),
      shippingType: List.generate(cartProducts.length, (index) => shippingId.value),
      guestEmail: null,
      userId: userId.$
    );

    var response = await CheckoutRepository().placeAnOrder(
      orderRequest.toJson(),
    );
    printLog(response);

    Get.offAllNamed(Routes.DASHBOARD);
    AppWidgets().getSnackBar(
      title: 'Info',
      message: response.toString(),
    );


/*    if (response.status == 200) {
      AppWidgets().getSnackBar(
        title: 'Success',
        message: response.message.toString(),
      );
    } else {
      AppWidgets().getSnackBar(
        title: 'Error',
        message: response.message.toString(),
      );*/
    //}
  }

}
