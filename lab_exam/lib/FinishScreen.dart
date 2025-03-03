import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FinishPage extends StatelessWidget {
  final String recipientName;
  final String accountType;
  final String phoneNumber;
  final String message;
  final String date;
  final String transactionId;
  final double fee;
  final double totalAmount;
  final double walletBalance;

  const FinishPage({
    super.key,
    required this.recipientName,
    required this.accountType,
    required this.phoneNumber,
    required this.message,
    required this.date,
    required this.transactionId,
    required this.fee,
    required this.totalAmount,
    required this.walletBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'ทำรายการสำเร็จ',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Icon(
              LucideIcons.checkCircle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 10),
            const Text(
              'โอนเงินให้',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '฿${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey.shade300, thickness: 1),
            _infoRow('ประเภทบัญชี', accountType),
            _infoRow('เบอร์โทรศัพท์', phoneNumber),
            _infoRow('ข้อความ', message),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade300, thickness: 1),
            _infoRow('วันที่-เวลา', date),
            _infoRow('เลขที่อ้างอิง', transactionId),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade300, thickness: 1),
            _paymentMethodSection(),
            const Spacer(),
            Text(
              'เงินคงเหลือ ฿${walletBalance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('กลับหน้าหลัก', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ช่องทางชำระเงิน',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('ทรูมันนี่ วอลเล็ท', style: TextStyle(fontSize: 16)),
              Text('ยอดเงินในวอลเล็ท: ฿${walletBalance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 5),
          const Text('ฟรี! ค่าธรรมเนียม', style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
