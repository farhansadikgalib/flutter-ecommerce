import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/routes/app_pages.dart';
import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/cart_controller.dart';

class CartView extends BaseView<CartController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return globalAppBar(context, 'Cart');
  }

  @override
  Widget? floatingActionButton() {
    return Get.find<HomeController>().cartCount.value > 0
        ? Container(
          width: Get.width,
          margin: REdgeInsets.only(left: 26),
          padding: REdgeInsets.symmetric(horizontal: 8),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Total: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => Text(
                  '${controller.totalPrice.value.toStringAsFixed(2)} BDT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              Spacer(),

              ElevatedButton(
                onPressed: ()=>Get.toNamed(Routes.CHECKOUT),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: Text(
                  'Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )
        : SizedBox();
  }

  @override
  Widget body(BuildContext context) {
    controller.cartCalculation();

    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: Get.height / 3,),
      children: [
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            padding: REdgeInsets.symmetric(horizontal: 16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.cartProducts.length,
            itemBuilder: (context, index) {
              final product = controller.cartProducts[index];
              return Dismissible(
                key: Key(product.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  controller.cartProducts.removeAt(index);
                  Get.find<HomeController>().cartCount.value--;
                  product.addToCart = true;
                  Get.find<HomeController>().cartCount.refresh();
                  Get.find<HomeController>().homeElements.refresh();
                },
                child: Container(
                  margin: REdgeInsets.only(bottom: 6),
                  padding: REdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 1,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AnyImageView(
                          height: 50.h,
                          width: 50.h,
                          boxFit: BoxFit.cover,
                          imagePath: AppConfig.imageBasePath + product.image!,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title!,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              '${product.selling} BDT',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          InkWell(
                            onTap: () {
                              if (product.quantity! > 1) {
                                product.quantity = product.quantity! - 1;
                              } else {
                                product.addToCart = true;
                                controller.cartProducts.removeAt(index);
                                Get.find<HomeController>().cartCount.value--;
                              }
                              Get.find<HomeController>().homeElements.refresh();
                              Get.find<HomeController>().cartCount.refresh();
                              controller.update();
                            },
                            child: Container(
                              padding: REdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FaIcon(
                                product.quantity == 1
                                    ? FontAwesomeIcons.trash
                                    : FontAwesomeIcons.minus,
                                color: AppColors.primaryColor,
                                size: 14,
                              ),
                            ),
                          ),

                          Text(
                            product.quantity!.toString(),
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              product.quantity = product.quantity! + 1;
                              Get.find<HomeController>().homeElements.refresh();
                              Get.find<HomeController>().cartCount.refresh();
                              controller.update();
                            },
                            child: Container(
                              padding: REdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppColors.primaryColor,
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 1,
                                    offset: Offset(0, 1),
                                    // changes position of shadow
                                  ),
                                ],
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                color: AppColors.primaryColor,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        if (Get.find<HomeController>().cartCount.value == 0)
          Column(
            children: [
              SizedBox(height: Get.height/2.5,),
              Text(
                'No products in cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          )


      ],
    );
  }
}
