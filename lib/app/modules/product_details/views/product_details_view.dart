// import 'package:any_image_view/any_image_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:turi/app/core/base/base_view.dart';
// import 'package:turi/app/core/helper/app_widgets.dart';
// import 'package:turi/app/core/widget/global_appbar.dart';
// import 'package:turi/app/modules/home/controllers/home_controller.dart';
// import 'package:turi/app/modules/product_details/controllers/product_details_controller.dart';
//
// import '../../../core/config/app_config.dart';
// import '../../../core/style/app_colors.dart';
// import '../../cart/controllers/cart_controller.dart';
//
// class ProductDetailsView extends BaseView<ProductDetailsController> {
//   ProductDetailsView({super.key});
//
//   @override
//   PreferredSizeWidget? appBar(BuildContext context) {
//     return null;
//   }
//
//   @override
//   Widget body(BuildContext context) {
//     return Obx(() {
//       return Scaffold(
//         appBar: globalAppBar(context, 'Product Details'),
//         body: Stack(
//           children: [
//             ListView(
//               children: [
//                 // Product Image Carousel
//                 SizedBox(
//                   height: 300,
//                   child: Stack(
//                     children: [
//                       PageView.builder(
//                         controller: controller.pageController,
//                         itemCount: controller.imageList.length,
//                         onPageChanged: (index) {
//                           controller.currentPage.value = index;
//                         },
//                         itemBuilder: (BuildContext context, int index) {
//                           return AnyImageView(
//                             imagePath:
//                                 '${AppConfig.imageBasePath}${controller.imageList[index].image}',
//                             width: double.infinity,
//                             height: 300,
//                           );
//                         },
//                       ),
//                       Positioned(
//                         bottom: 10,
//                         left: 0,
//                         right: 0,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             controller.imageList.length, //
//                             // Number of
//                             // images
//                             (index) => AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               margin: const EdgeInsets.symmetric(horizontal: 4),
//                               width:
//                                   controller.currentPage.value == index
//                                       ? 12
//                                       : 8,
//                               height: 8,
//                               decoration: BoxDecoration(
//                                 color:
//                                     controller.currentPage.value == index
//                                         ? AppColors.primaryColor
//                                         : AppColors.secondaryColor,
//                                 borderRadius: BorderRadius.circular(4),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Product Info Section
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         controller.product.title.toString(),
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Text(
//                             '${controller.product.offered.toString()} BDT',
//                             style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             '${controller.product.selling.toString()} BDT',
//                             style: const TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                               decoration: TextDecoration.lineThrough,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       int.parse(controller.product.reviewCount.toString()) > 0
//                           ? Row(
//                             children: List.generate(
//                               int.parse(
//                                 controller.product.reviewCount.toString(),
//                               ),
//                               (index) => const Icon(
//                                 Icons.star,
//                                 color: Colors.amber,
//                                 size: 16,
//                               ),
//                             ),
//                           )
//                           : Row(
//                             children: List.generate(
//                               5,
//                               (index) => const Icon(
//                                 Icons.star,
//                                 color: Colors.grey,
//                                 size: 16,
//                               ),
//                             ),
//                           ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Shipping Info
//                 Container(
//                   color: Colors.grey[100],
//                   padding: const EdgeInsets.all(16),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Ships to:',
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                           Text(
//                             'Worldwide',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'Delivery:',
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                           Text(
//                             '5-10 Business Days',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Expandable Sections
//                 ExpansionTile(
//                   textColor: AppColors.black,
//                   iconColor: AppColors.black,
//                   title: const Text('Specifications'),
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.all(16.0),
//                       child: Text(
//                           controller.productDetails.isEmpty?'':
//                         controller.productDetails.first.metaDescription
//                             .toString(),
//                         style: TextStyle(fontSize: 14, color: Colors.grey),
//                       ),
//                     ),
//                   ],
//                 ),
//                 ExpansionTile(
//                   textColor: AppColors.black,
//                   iconColor: AppColors.black,
//                   title: const Text('Reviews & Ratings'),
//                   children: [
//                     Text(
//                       'No Review Found',
//                       style: TextStyle(fontSize: 14, color: Colors.grey),
//                     ),
//                     /*
//
//                     ListTile(
//                       leading: const CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           'https://via.placeholder.com/50',
//                         ),
//                       ),
//                       title: const Text('John Doe'),
//                       subtitle: const Text('Great product! Highly recommend.'),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: List.generate(
//                           5,
//                           (index) => const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                             size: 16,
//                           ),
//                         ),
//                       ),
//                     ),
// */
//                   ],
//                 ),
//               ],
//             ),
//
//             // Floating Action Buttons at the Bottom
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       /*child: ElevatedButton(
//                         onPressed: () {
//                           // Add to cart logic
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.orange,
//                         ),
//                         child: const Text('Add to Cart'),
//                       ),*/
//                       child: Visibility(
//                         visible: controller.product.addToCart!,
//                         replacement: Container(
//                           margin: REdgeInsets.symmetric(horizontal: 14),
//                           height: 30.h,
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: AppColors.primaryColor,
//                               width: 1,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 spreadRadius: 1,
//                                 blurRadius: 2,
//                                 offset: Offset(0, 1),
//                                 // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   if (controller.product.quantity! > 1) {
//                                     controller.product.quantity =
//                                         controller.product.quantity! - 1;
//
//                                     Get.find<CartController>().cartProducts
//                                         .forEach((element) {
//                                           if (element.id ==
//                                               controller.product.id) {
//                                             element.quantity =
//                                                 controller.product.quantity;
//                                           }
//                                         });
//
//                                     Get.find<HomeController>().homeElements
//                                         .refresh();
//                                   } else {
//                                     controller.product.addToCart = true;
//                                     Get.find<HomeController>().homeElements
//                                         .refresh();
//                                     Get.find<HomeController>()
//                                         .cartCount
//                                         .value--;
//
//                                     Get.find<CartController>().cartProducts
//                                         .removeAt(
//                                           Get.find<CartController>()
//                                               .cartProducts
//                                               .indexWhere(
//                                                 (element) =>
//                                                     element.id ==
//                                                     controller.product.id,
//                                               ),
//                                         );
//
//                                     Get.find<HomeController>().cartCount
//                                         .refresh();
//                                   }
//                                 },
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.minus,
//                                   color: AppColors.primaryColor,
//                                   size: 14,
//                                 ),
//                               ),
//
//                               Text(
//                                 controller.product.quantity!.toString(),
//                                 style: TextStyle(
//                                   color: AppColors.primaryColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//
//                               IconButton(
//                                 onPressed: () {
//                                   controller.product.quantity =
//                                       controller.product.quantity! + 1;
//
//                                   Get.find<CartController>().cartProducts
//                                       .forEach((element) {
//                                         if (element.id ==
//                                             controller.product.id) {
//                                           element.quantity =
//                                               controller.product.quantity;
//                                         }
//                                       });
//                                   Get.find<HomeController>().homeElements
//                                       .refresh();
//                                 },
//                                 icon: FaIcon(
//                                   FontAwesomeIcons.plus,
//                                   color: AppColors.primaryColor,
//                                   size: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             controller.product.quantity = 1;
//                             controller.product.addToCart = false;
//                             Get.find<HomeController>().cartCount.value++;
//                             Get.find<CartController>().cartProducts.add(
//                               controller.product,
//                             );
//                             Get.find<HomeController>().cartCount.refresh();
//                             Get.find<HomeController>().homeElements.refresh();
//
//                             AppWidgets().getSnackBar(message: 'Added to cart!'
//                                 ' View your cart or continue shopping.',);
//
//                           },
//                           child: Text(
//                             'Add to Bag',
//                             style: TextStyle(color: AppColors.primaryColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

import 'package:any_image_view/any_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:turi/app/core/base/base_view.dart';
import 'package:turi/app/core/helper/app_widgets.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/modules/home/controllers/home_controller.dart';
import 'package:turi/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:turi/app/modules/wishlist/controllers/wishlist_controller.dart';

import '../../../core/config/app_config.dart';
import '../../../core/style/app_colors.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsView extends BaseView<ProductDetailsController> {
  ProductDetailsView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return Scaffold(
        // appBar: globalAppBar(context, 'Product Details'),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 80.h),
              children: [
                // Product Image Carousel with improved styling

              Container(
                height: 350.h,
                color: Colors.white,
                child: Stack(
                  children: [
                    // Main image carousel
                    PageView.builder(
                      controller: controller.pageController,
                      itemCount: controller.imageList.length,
                      onPageChanged: (index) {
                        controller.currentPage.value = index;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Image viewer/zoomer functionality
                          },
                          child: Hero(
                            tag: 'product-${controller.product.id}',
                            child: AnyImageView(
                              imagePath: '${AppConfig.imageBasePath}${controller.imageList[index].image}',
                              width: double.infinity,
                              height: 350.h,
                              boxFit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),


                    Positioned(
                      bottom: 10.h,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 60.h,
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                controller.imageList.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    controller.pageController.animateToPage(
                                      index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: Container(
                                    width: 50.h,
                                    height: 50.h,
                                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: controller.currentPage.value == index
                                            ? AppColors.primaryColor
                                            : Colors.grey[300]!,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1.r),
                                      child: AnyImageView(
                                        imagePath: '${AppConfig.imageBasePath}${controller.imageList[index].image}',
                                        width: 46.w,
                                        height: 46.h,
                                        boxFit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Share and Wishlist buttons - Amazon places these in the bottom right
                  ],
                ),
              ),




              Container(
                padding: EdgeInsets.all(16.w),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product title with slightly smaller font than Amazon
                    Text(
                      controller.product.title.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Price section in Alibaba style (larger, with range format)
                    Text(
                      '৳${controller.product.offered} - ৳${(double.parse(controller.product.offered.toString()) * 1.05).toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE51A19), // Alibaba's red color
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Original price with slash
                    Row(
                      children: [
                        Text(
                          'Original Price: ',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '৳${controller.product.selling}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Alibaba-style promotion tags row
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF0E5),
                            border: Border.all(color: Color(0xFFFF6A00), width: 1),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Text(
                            '100% OFF',
                            // '${((int.parse(controller.product.selling.toString()) - int.parse(controller.product.offered.toString())) / int.parse(controller.product.selling.toString()) * 100).toStringAsFixed(0)}% OFF',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Color(0xFFFF6A00),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFE6F7FF),
                            border: Border.all(color: Color(0xFF1890FF), width: 1),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                          child: Text(
                            'Free Shipping',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: Color(0xFF1890FF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Alibaba-style trade info row
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    size: 16.sp,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Ships from Bangladesh',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_outlined,
                                    size: 16.sp,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Lead time: 5-10 days',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.receipt_long_outlined,
                                    size: 16.sp,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Returns accepted',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified_user_outlined,
                                    size: 16.sp,
                                    color: Colors.grey[700],
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                    'Verified Seller',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Order options - like Alibaba's options for quantity
                    Text(
                      'Options',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Quantity section in Alibaba style
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Decrease quantity logic
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                        child: Icon(
                                          Icons.remove,
                                          size: 16.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          left: BorderSide(color: Colors.grey[300]!),
                                          right: BorderSide(color: Colors.grey[300]!),
                                        ),
                                      ),
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Increase quantity logic
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                        child: Icon(
                                          Icons.add,
                                          size: 16.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'piece',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Rating and reviews in Alibaba style
                    Row(
                      children: [
                        Text(
                          'Ratings:',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < int.parse(controller.product.reviewCount.toString())
                                  ? Icons.star
                                  : Icons.star_border,
                              color: index < int.parse(controller.product.reviewCount.toString())
                                  ? Color(0xFFFA6E18) // Alibaba's orange star color
                                  : Colors.grey[300],
                              size: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '(${controller.product.reviewCount})',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Color(0xFF1890FF), // Alibaba's link blue
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                SizedBox(height: 8.h),


/*                // Product Details Section
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    textColor: AppColors.primaryColor,
                    iconColor: AppColors.primaryColor,
                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    initiallyExpanded: true,
                    title: Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    children: [
                      controller.productDetails.isEmpty
                          ? Text(
                            'No specifications available',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          )
                          : Text(
                            controller.productDetails.first.metaDescription
                                .toString(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                              height: 1.5,
                            ),
                          ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Reviews Section
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    textColor: AppColors.primaryColor,
                    iconColor: AppColors.primaryColor,
                    title: Text(
                      'Ratings & Reviews',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child:
                            int.parse(
                                      controller.product.reviewCount.toString(),
                                    ) >
                                    0
                                ? Column(
                                  children: [
                                    // Sample review would go here
                                    Container(
                                      padding: EdgeInsets.all(12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Text(
                                        'Reviews will be displayed here',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.rate_review_outlined,
                                        size: 48.sp,
                                        color: Colors.grey[400],
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        'No reviews yet. Be the first to review!',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Suggested Products Section (This is a placeholder - you'd need to implement this feature)
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'You May Also Like',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        height: 180.h,
                        child: Center(
                          child: Text(
                            'Similar products would appear here',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),*/


              // Product details in Alibaba style - using tab layout instead of expansion tiles
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 8.h),
                child: Column(
                  children: [
                    // Tab header bar
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: AppColors.primaryColor, width: 2),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Product Details',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Center(
                                child: Text(
                                  'Specifications',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Center(
                                child: Text(
                                  'Reviews (${controller.product.reviewCount})',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content section
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Overview section title
                          Container(
                            padding: EdgeInsets.only(bottom: 8.h),
                            margin: EdgeInsets.only(bottom: 12.h),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 4.w,
                                  height: 16.h,
                                  color: Color(0xFFFF6A00),
                                  margin: EdgeInsets.only(right: 8.w),
                                ),
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Product details content
                          controller.productDetails.isEmpty
                            ? Text(
                              'No specifications available',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Alibaba usually has a structured format with key specs
                                // Key specifications in a table-like layout
                                Container(
                                  margin: EdgeInsets.only(bottom: 16.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[200]!),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Column(
                                    children: [
                                      // Row 1
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F5F5),
                                          border: Border(
                                            bottom: BorderSide(color: Colors.grey[200]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 120.w,
                                              padding: EdgeInsets.all(10.w),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(color: Colors.grey[200]!),
                                                ),
                                              ),
                                              child: Text(
                                                'Brand',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Text(
                                                  'Premium Quality',
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Row 2
                                      Row(
                                        children: [
                                          Container(
                                            width: 120.w,
                                            padding: EdgeInsets.all(10.w),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                right: BorderSide(color: Colors.grey[200]!),
                                              ),
                                            ),
                                            child: Text(
                                              'Origin',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(10.w),
                                              child: Text(
                                                'Bangladesh',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      // Row 3
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF5F5F5),
                                          border: Border(
                                            top: BorderSide(color: Colors.grey[200]!),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 120.w,
                                              padding: EdgeInsets.all(10.w),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(color: Colors.grey[200]!),
                                                ),
                                              ),
                                              child: Text(
                                                'Warranty',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(10.w),
                                                child: Text(
                                                  '1 Year',
                                                  style: TextStyle(
                                                    fontSize: 13.sp,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Description
                                Text(
                                  controller.productDetails.first.metaDescription.toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[700],
                                    height: 1.5,
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                // Alibaba often shows highlighted features
                                Container(
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFF8E1),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Product Highlights',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 14.sp,
                                            color: Color(0xFFFF6A00),
                                          ),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              'Premium quality materials',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 14.sp,
                                            color: Color(0xFFFF6A00),
                                          ),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              'Fast shipping worldwide',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle,
                                            size: 14.sp,
                                            color: Color(0xFFFF6A00),
                                          ),
                                          SizedBox(width: 6.w),
                                          Expanded(
                                            child: Text(
                                              'Extended warranty coverage',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Reviews section in Alibaba style
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reviews header with stats
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Customer Reviews',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '${controller.product.reviewCount}',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFF6A00),
                                ),
                              ),
                              Text(
                                '/5',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.star,
                                size: 14.sp,
                                color: Color(0xFFFF6A00),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Review filters (Alibaba style)
                    Container(
                      height: 32.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF6A00),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '5★',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '4★',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '3★',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'With Photos',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Reviews content
                    int.parse(controller.product.reviewCount.toString()) > 0
                      ? Column(
                          children: [
                            // This would be a ListView.builder in real implementation
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16.r,
                                        backgroundColor: Colors.grey[300],
                                        child: Text(
                                          'U',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'User****123',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: List.generate(
                                          5,
                                          (index) => Icon(
                                            Icons.star,
                                            size: 14.sp,
                                            color: Color(0xFFFF6A00),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Reviews will be displayed here',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Row(
                                    children: [
                                      Text(
                                        '2024-07-15',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.thumb_up_outlined,
                                            size: 14.sp,
                                            color: Colors.grey[500],
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'Helpful (0)',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(
                          padding: EdgeInsets.all(24.w),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5F5F5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.rate_review_outlined,
                                  size: 40.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                'No reviews yet',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Be the first to review this product',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),

              SizedBox(height: 8.h),

              // Related products in Alibaba style
              Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Similar Product',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'View more',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Color(0xFF1890FF),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      height: 220.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        itemCount: 1, // Replace with actual count
                        itemBuilder: (context, index) {
                          return Container(
                            width: 160.w,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120.h,
                                  color: Colors.grey[100],
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Product Image',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Similar products would appear here',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        "1",
                                        // '৳${(int.parse(controller.product.offered.toString()) * 0.9).toStringAsFixed(0)} - ৳${(int.parse(controller.product.offered.toString()) * 1.1).toStringAsFixed(0)}',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFE51A19),
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Min. Order: 1 piece',
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )


              ],
            ),

            // Bottom Add to Cart Bar with improved styling
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    // Chat button
                    SizedBox(width: 12.w),
                    // Add to Cart/Quantity buttons
                    Expanded(
                      child: Visibility(
                        visible: controller.product.addToCart!,
                        replacement: Container(
                          height: 42.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (controller.product.quantity! > 1) {
                                    controller.product.quantity =
                                        controller.product.quantity! - 1;
                                    Get.find<CartController>().cartProducts
                                        .forEach((element) {
                                          if (element.id ==
                                              controller.product.id) {
                                            element.quantity =
                                                controller.product.quantity;
                                          }
                                        });
                                    Get.find<HomeController>().homeElements
                                        .refresh();
                                  } else {
                                    controller.product.addToCart = true;
                                    Get.find<HomeController>().homeElements
                                        .refresh();
                                    Get.find<HomeController>()
                                        .cartCount
                                        .value--;
                                    Get.find<CartController>().cartProducts
                                        .removeAt(
                                          Get.find<CartController>()
                                              .cartProducts
                                              .indexWhere(
                                                (element) =>
                                                    element.id ==
                                                    controller.product.id,
                                              ),
                                        );
                                    Get.find<HomeController>().cartCount
                                        .refresh();
                                  }
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.minus,
                                  color: AppColors.primaryColor,
                                  size: 14.sp,
                                ),
                              ),
                              Text(
                                controller.product.quantity!.toString(),
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.product.quantity =
                                      controller.product.quantity! + 1;
                                  Get.find<CartController>().cartProducts
                                      .forEach((element) {
                                        if (element.id ==
                                            controller.product.id) {
                                          element.quantity =
                                              controller.product.quantity;
                                        }
                                      });
                                  Get.find<HomeController>().homeElements
                                      .refresh();
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.plus,
                                  color: AppColors.primaryColor,
                                  size: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            controller.product.quantity = 1;
                            controller.product.addToCart = false;
                            Get.find<HomeController>().cartCount.value++;
                            Get.find<CartController>().cartProducts.add(
                              controller.product,
                            );
                            Get.find<HomeController>().cartCount.refresh();
                            Get.find<HomeController>().homeElements.refresh();
                            AppWidgets().getSnackBar(
                              message:
                                  'Added to cart! View your cart or continue shopping.',
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'ADD TO CART',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Buy Now button
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: IconButton(
                        icon: Icon(
                          controller.wishlistItem.value
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              controller.wishlistItem.value
                                  ? Colors.red
                                  : AppColors.primaryColor,
                          size: 24.sp,
                        ),
                        onPressed: () {
                          Get.find<WishlistController>().wishlistAction(
                            controller.product.id.toString(),
                          );
                          controller.wishlistItem.value =
                              !controller.wishlistItem.value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
