import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:turi/app/core/widget/global_appbar.dart';

import '../controllers/transactions_controller.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context, 'Transaction History'),
      backgroundColor: const Color(0xFFF7F9FB),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
              color: const Color(0xFFE6F0F3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('RIFAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            SizedBox(height: 4),
                            Text('BALANCE', style: TextStyle(fontSize: 13, color: Colors.grey)),
                          ],
                        ),
                        // Replace with your logo asset
                        Image.asset('assets/png/logo.png', height: 32),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF158A7E),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFFFA726),
                          child: const Text('৳', style: TextStyle(fontSize: 22, color: Colors.white)),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('৳273', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 4),
                            Text('Cash (Usable)', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _transactionCard(
                  context,
                  type: 'Refund',
                  date: 'September 1, 2025 at 8:40 AM',
                  orderId: '#3150606',
                  txnId: 'R7388020',
                  amount: '+273',
                  isCredit: true,
                  tag: 'Withdraw',
                ),
                _transactionCard(
                  context,
                  type: 'Payment Used',
                  date: 'August 31, 2025 at 7:17 PM',
                  orderId: '#3150606',
                  txnId: 'PU7383561',
                  amount: '-1123',
                  isCredit: false,
                ),
                _transactionCard(
                  context,
                  type: 'Payment',
                  date: 'August 31, 2025 at 7:17 PM',
                  orderId: '#2139704',
                  txnId: 'P7383560',
                  amount: '+1123',
                  isCredit: true,
                ),
                _transactionCard(
                  context,
                  type: 'bonus used',
                  date: 'August 31, 2025 at 7:15 PM',
                  orderId: '#3150606',
                  txnId: 'ABU7383528',
                  amount: '-10',
                  isCredit: false,
                ),
                _transactionCard(
                  context,
                  type: 'bonus returned',
                  date: 'August 31, 2025 at 7:13 PM',
                  orderId: '#3150582',
                  txnId: 'ABR7383491',
                  amount: '+10',
                  isCredit: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF158A7E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Lab Test'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Beauty'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_services), label: 'Healthcare'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }

  Widget _transactionCard(
    BuildContext context, {
    required String type,
    required String date,
    required String orderId,
    required String txnId,
    required String amount,
    required bool isCredit,
    String? tag,
  }) {
    final icon = isCredit ? Icons.trending_up : Icons.trending_down;
    final iconColor = isCredit ? const Color(0xFFB2E3D3) : const Color(0xFFFDE2E2);
    final amountColor = isCredit ? const Color(0xFF158A7E) : const Color(0xFFD32F2F);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: iconColor,
              child: Icon(icon, color: isCredit ? Colors.teal : Colors.redAccent),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('ProductOrder ID $orderId', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                  Text('Txn Id: $txnId', style: const TextStyle(fontSize: 13, color: Colors.grey)),
                  Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  if (tag != null)
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE2B2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(tag, style: const TextStyle(color: Color(0xFFD68B00), fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('৳$amount', style: TextStyle(fontWeight: FontWeight.bold, color: amountColor, fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
