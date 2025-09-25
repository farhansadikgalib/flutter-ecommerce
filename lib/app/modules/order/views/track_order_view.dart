import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/style/app_colors.dart';
import '../../../data/remote/model/order/track_order_response.dart';
import 'package:ousadbazar/app/core/widget/global_appbar.dart';
import 'package:ousadbazar/app/modules/order/controllers/order_controller.dart';

class TrackOrderView extends StatelessWidget {
  final OrderController controller = Get.find<OrderController>();

  TrackOrderView({super.key});

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.blue;
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
      case 'out for delivery':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Track Your Order'),
      body: Obx(() {
        if (controller.trackOrderData.isEmpty) {
          return const Center(child: Text('No tracking information available'));
        }
        final TrackOrderData data = controller.trackOrderData[0];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Order Summary Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Order #${data.id ?? "N/A"}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      const Divider(height: 25),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Ordered on: ${_formatDate(data.createdAt)}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            'Total:  ৳ ${data.total ?? "N/A"}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Centered Timeline for Order Status in a Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Order Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Divider(height: 25),
                      const SizedBox(height: 6),
                      _OrderTimeline(
                        status: data.verifyStatus,
                        createdAt: data.createdAt,
                        shippedAt: data.updatedAt,
                        deliveredAt: data.deliveredAt,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Delivery Address
              if (data.billingAddress != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(data.billingAddress?.fullName ?? 'Recipient'),
                    subtitle: Text(
                      data.billingAddress?.address ?? 'No address',
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class _OrderTimeline extends StatelessWidget {
  final String? status;
  final String? createdAt;
  final String? shippedAt;
  final String? deliveredAt;

  const _OrderTimeline({
    this.status,
    this.createdAt,
    this.shippedAt,
    this.deliveredAt,
  });

  int get currentStep {
    // Handle both string and integer status values
    String statusStr = '';
    if (status != null) {
      // Check if it's a number (verifyStatus or deliveryStatus from API)
      if (int.tryParse(status!) != null) {
        int statusCode = int.parse(status!);

        // Handle deliveryStatus: 3=delivered, 2=shipped, 1=confirmed, 0=pending
        if (statusCode == 3) {
          statusStr = 'delivered';
        } else if (statusCode == 2) {
          statusStr = 'shipped';
        } else if (statusCode == 1) {
          statusStr = 'confirmed';
        } else if (statusCode == 0) {
          statusStr = 'pending';
        } else {
          // Fallback for other status codes
          switch (statusCode) {
            case 0:
              statusStr = 'pending';
              break;
            case 1:
              statusStr = 'confirmed';
              break;
            case 2:
              statusStr = 'shipped'; // Updated mapping
              break;
            case 3:
              statusStr = 'delivered'; // Updated mapping
              break;
            default:
              statusStr = 'pending';
          }
        }
      } else {
        statusStr = status!.toLowerCase();
      }
    }

    switch (statusStr) {
      case 'delivered':
        return 4;
      case 'shipped':
      case 'out for delivery':
        return 3;
      case 'confirmed':
      case 'processing':
        return 2;
      case 'pending':
        return 1;
      case 'cancelled':
      case 'cancel':
        return -1; // Special case for cancelled orders
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle cancelled orders differently
    if (currentStep == -1) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.cancel, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            'Order Cancelled',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order has been cancelled',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      );
    }

    final steps = [
      _TimelineStep(
        title: 'Order Placed',
        subtitle:
            createdAt != null
                ? DateFormat('MMM dd, yyyy').format(DateTime.parse(createdAt!))
                : '',
        icon: Icons.shopping_cart,
        isActive: currentStep >= 0,
        isDone: currentStep > 0,
      ),
      _TimelineStep(
        title: 'Pending',
        subtitle: 'Awaiting confirmation',
        icon: Icons.hourglass_empty,
        isActive: currentStep >= 1,
        isDone: currentStep > 1,
      ),
      _TimelineStep(
        title: 'Confirmed',
        subtitle: 'Order confirmed & processing',
        icon: Icons.check_circle_outline,
        isActive: currentStep >= 2,
        isDone: currentStep > 2,
      ),
      _TimelineStep(
        title: 'Shipped',
        subtitle:
            shippedAt != null
                ? DateFormat('MMM dd, yyyy').format(DateTime.parse(shippedAt!))
                : 'Out for delivery',
        icon: Icons.local_shipping,
        isActive: currentStep >= 3,
        isDone: currentStep > 3,
      ),
      _TimelineStep(
        title: 'Delivered',
        subtitle:
            deliveredAt != null
                ? DateFormat(
                  'MMM dd, yyyy',
                ).format(DateTime.parse(deliveredAt!))
                : '',
        icon: Icons.check_circle,
        isActive: currentStep >= 4,
        isDone: currentStep > 4,
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timeline icon and line column
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color:
                          step.isActive
                              ? AppColors.primaryColor
                              : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      step.icon,
                      color: step.isActive ? Colors.white : Colors.grey[500],
                      size: 22,
                    ),
                  ),
                  if (i < steps.length - 1)
                    Container(
                      width: 2,
                      height: 50,
                      color:
                          step.isDone
                              ? AppColors.primaryColor
                              : Colors.grey[300],
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // Text content aligned with icon center
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                  ), // Align with icon center
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              step.isActive
                                  ? AppColors.primaryColor
                                  : Colors.grey[600],
                          fontSize: 16,
                        ),
                      ),
                      if (step.subtitle.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            step.subtitle,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _TimelineStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;
  final bool isDone;
  _TimelineStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
    required this.isDone,
  });
}
