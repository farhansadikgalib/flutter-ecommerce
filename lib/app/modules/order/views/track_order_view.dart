import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/modules/order/controllers/order_controller.dart';

import '../../../core/style/app_colors.dart';
import '../../../data/remote/model/order/track_order_response.dart';

class TrackOrderView extends StatelessWidget {
  final OrderController controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Track Your Order'),
      body: Obx(() {
        if (controller.trackOrderData.isEmpty) {
          return const Center(child: Text('No tracking information available'));
        }

        final trackData = controller.trackOrderData[0];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderSummary(trackData),
              const SizedBox(height: 24),
              _buildTrackingTimeline(trackData),
              // const SizedBox(height: 24),
              // _buildDeliveryDetails(trackData),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderSummary(TrackOrderData data) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.shopping_bag, color: AppColors.primaryColor),
                  const SizedBox(width: 12),
                  Text(
                    'Order #${data.id ?? "N/A"}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getStatusColor(data.status.toString())
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data.status.toString() ?? "Processing",
                      style: TextStyle(
                        color: _getStatusColor(data.status.toString()),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
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
                  const Icon(
                    Icons.access_time_rounded,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Estimated delivery: 3-5 business days',
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
    );
  }

  Widget _buildTrackingTimeline(TrackOrderData data) {
    // Define all possible statuses in order
    final allStatuses = [
      'Ordered',
      'Processing',
      'Shipped',
      'Out for Delivery',
      'Delivered'
    ];
    final statusIcons = [
      Icons.shopping_cart_outlined,
      Icons.inventory_2_outlined,
      Icons.local_shipping_outlined,
      Icons.delivery_dining_outlined,
      Icons.done_all_rounded,
    ];

    // Determine current status index (default to "Processing" if status is null)
    final currentStatus = data.status ?? 'Processing';
    final currentIndex = int.parse(currentStatus.toString());

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.local_shipping, color: AppColors.primaryColor),
                  const SizedBox(width: 12),
                  const Text(
                    'Shipment Progress',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              for (int i = 0; i < allStatuses.length; i++)
                _buildTimelineItem(
                  status: allStatuses[i],
                  icon: statusIcons[i],
                  isCompleted: i <= currentIndex,
                  isLast: i == allStatuses.length - 1,
                  isActive: i == currentIndex,
                  date: i == currentIndex ? _formatDate(data.updatedAt) : null,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String status,
    required IconData icon,
    required bool isCompleted,
    required bool isLast,
    required bool isActive,
    String? date,
  }) {
    final primaryColor = AppColors.primaryColor;
    final lightColor = primaryColor.withOpacity(0.15);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isCompleted ? primaryColor : Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: isActive ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  )
                ] : null,
                border: isActive
                    ? Border.all(color: primaryColor, width: 2)
                    : null,
              ),
              child: Icon(
                icon,
                color: isCompleted ? Colors.white : Colors.grey[400],
                size: 18,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [primaryColor, primaryColor.withOpacity(0.7)],
                  )
                      : null,
                  color: isCompleted ? null : Colors.grey[200],
                ),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                  color: isCompleted ? Colors.black87 : Colors.grey[500],
                ),
              ),
              if (date != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: lightColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      date,
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  ),
                )
              else
                const SizedBox(height: 16),
              if (isActive)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _getStatusDescription(status),
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusDescription(String status) {
    switch (status) {
      case 'Ordered':
        return 'Your order has been received.';
      case 'Processing':
        return 'We\'re preparing your order for shipment.';
      case 'Shipped':
        return 'Your order is on the way to your location.';
      case 'Out for Delivery':
        return 'Your order is out for delivery today.';
      case 'Delivered':
        return 'Your order has been delivered successfully.';
      default:
        return '';
    }
  }

}
  Widget _buildTimelineItem({
    required String status,
    required bool isCompleted,
    required bool isLast,
    String? date,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.blue : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: isCompleted
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? Colors.blue : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCompleted ? Colors.black : Colors.grey,
                ),
              ),
              if (date != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 16),
                  child: Text(
                    date,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                )
              else
                const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }


/*Widget _buildDeliveryDetails(TrackOrderData data) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.delivery_dining, color: AppColors.primaryColor),
                const SizedBox(width: 12),
                const Text(
                  'Delivery Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 0.5,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(height: 30),
            _buildDetailItem(
              icon: Icons.person_outline_rounded,
              title: 'Recipient',
              value: 'N/A',
              iconColor: Colors.indigo,
            ),
            _buildDetailItem(
              icon: Icons.location_on_outlined,
              title: 'Delivery Address',
              value: 'N/A',
              iconColor: Colors.red,
            ),
            _buildDetailItem(
              icon: Icons.local_shipping_outlined,
              title: 'Shipping Method',
              value: 'Standard Delivery',
              iconColor: Colors.green,
            ),
            if (data.order != null)
              _buildDetailItem(
                icon: Icons.qr_code,
                title: 'Tracking Number',
                value: 'processing',
                iconColor: Colors.deepPurple,
                isCopyable: true,
              ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDetailItem({
  required IconData icon,
  required String title,
  required String value,
  Color iconColor = Colors.grey,
  bool isCopyable = false,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(0.05),
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (isCopyable)
          IconButton(
            icon: const Icon(Icons.copy, size: 18),
            color: Colors.grey[600],
            onPressed: () {
              // Add copy functionality here
            },
            tooltip: 'Copy to clipboard',
          ),
      ],
    ),
  );
}*/

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