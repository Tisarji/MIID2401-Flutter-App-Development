import 'package:flutter/material.dart';
import 'package:lab_exam/FinishScreen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  String expectedOtp = "";

  @override
  Widget build(BuildContext context) {
    String recipientName = "Jirasit Karunwong";
    String accountType = "True Money Wallet";
    String phoneNumber = "0955281872";
    String message = "Test Example";
    double fee = 20.00;
    double totalAmount = 3100.00;
    double walletBalance = 200.00;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('ยืนยันรหัส OTP', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'กรุณากรอกรหัส OTP ที่ส่งไปยังเบอร์ของคุณ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: 'รหัส OTP',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                counterText: '',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (otpController.text == expectedOtp) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinishPage(
                        recipientName: recipientName,
                        accountType: accountType,
                        phoneNumber: phoneNumber,
                        message: message,
                        fee: fee,
                        totalAmount: totalAmount,
                        walletBalance: walletBalance,
                        date: "04/10/2017 14:28", // Example date
                        transactionId: "50000096570978", // Example transaction ID
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid OTP')),
                  );
                }
              },
              child: const Text('ยืนยัน', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

