import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:turi/app/core/widget/global_appbar.dart';
import 'package:turi/app/modules/order/controllers/order_controller.dart';

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
              const SizedBox(height: 24),
              _buildDeliveryDetails(trackData),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOrderSummary(TrackOrderData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${data.id ?? "N/A"}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Ordered on: ${_formatDate(data.createdAt)}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              'Status: ${data.status ?? "Processing"}',
              style: TextStyle(
                color: _getStatusColor(data.status.toString()),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingTimeline(TrackOrderData data) {
    // Define all possible statuses in order
    final allStatuses = ['Ordered', 'Processing', 'Shipped', 'Out for Delivery', 'Delivered'];

    // Determine current status index (default to "Processing" if status is null)
    final currentStatus = data.status ?? 'Processing';
    final currentIndex = 2;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipment Progress',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            for (int i = 0; i < allStatuses.length; i++)
              _buildTimelineItem(
                status: allStatuses[i],
                isCompleted: i <= currentIndex,
                isLast: i == allStatuses.length - 1,
                date: i == currentIndex ? _formatDate(data.updatedAt) : null,
              ),
          ],
        ),
      ),
    );
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

  Widget _buildDeliveryDetails(TrackOrderData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            _buildDetailItem(
              icon: Icons.person,
              title: 'Recipient',
              value: 'N/A',
            ),
            _buildDetailItem(
              icon: Icons.location_on,
              title: 'Delivery Address',
              value: 'N/A',
            ),
            _buildDetailItem(
              icon: Icons.local_shipping,
              title: 'Shipping Method',
              value: 'Standard Delivery',
            ),
            if (data.order != null)
              _buildDetailItem(
                icon: Icons.numbers,
                title: 'Tracking Number',
                value: 'processing',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}