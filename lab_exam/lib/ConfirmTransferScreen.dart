import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_exam/OtpScreen.dart';

class ConfirmationScreen extends StatelessWidget {
  final String phone;
  final String amount;
  final String message;
  final double balance;

  const ConfirmationScreen({
    super.key,
    required this.phone,
    required this.amount,
    required this.message,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('ยืนยันการทำรายการ', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _transferDetails(context),
            const SizedBox(height: 20),
            _paymentMethodSection(),
            const Spacer(),
            _confirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _transferDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Replace the user image with an icon
              const Icon(Icons.person, size: 40, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('โอนเงิน', style: TextStyle(fontSize: 16)),
                    Text('฿$amount', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Action to edit the amount
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('เปลี่ยนแปลงยอดชำระ')),
                  );
                },
                child: const Text(
                  'เปลี่ยนแปลงยอดชำระ',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _detailRow('ชื่อผู้รับ', 'Jirasit Karunwong'),
          _detailRow('ประเภทบัญชี', 'ทรูมันนี่ วอลเล็ท'),
          _detailRow('เบอร์โทรศัพท์', phone),
          _detailRow('ข้อความ', message.isNotEmpty ? message : 'ค่าชำรอกลางวัน'),
          _detailRow('ค่าธรรมเนียม', '฿0.00'),
          const Divider(),
          _detailRow('ยอดรวมทั้งหมด', '฿$amount', isBold: true),
        ],
      ),
    );
  }

  /// Payment method section
  Widget _paymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ช่องทางชำระเงิน', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _paymentOption(),
        ],
      ),
    );
  }

  Widget _paymentOption() {
    return Row(
      children: [
        const Icon(Icons.radio_button_checked, color: Colors.orange),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ทรูมันนี่ วอลเล็ท', style: TextStyle(fontSize: 16)),
              Text('ยอดเงินในวอลเล็ท: ฿$balance',
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'เติมเงิน',
            style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _confirmButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OtpScreen(),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('ยืนยันการชำระเงิน', style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      ],
    );
  }
}
