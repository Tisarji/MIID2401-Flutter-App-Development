import 'package:flutter/material.dart';
import 'ConfirmTransferScreen.dart';

void main() {
  runApp(const TrueMoneyApp());
}

class TrueMoneyApp extends StatelessWidget {
  const TrueMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrueMoney Clone',
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('TrueMoney', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _topMenuBar(context),
        ],
      ),
    );
  }

  Widget _topMenuBar(BuildContext context) {
    return Container(
      color: Colors.orange,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _topMenuButton(context, Icons.account_balance_wallet, 'เติมเงินเข้าบัญชี'),
          _topMenuButton(context, Icons.swap_horiz, 'โอนเงิน', navigateTo: TransferScreen()),
          _topMenuButton(context, Icons.qr_code_scanner, 'สแกน'),
          _topMenuButton(context, Icons.payment, 'จ่ายเงิน'),
        ],
      ),
    );
  }

  Widget _topMenuButton(BuildContext context, IconData icon, String label, {Widget? navigateTo}) {
    return GestureDetector(
      onTap: () {
        if (navigateTo != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => navigateTo));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$label clicked')),
          );
        }
      },
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final double availableBalance = 144.42;

  String selectedCategory = 'TrueMoney';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('โอนเงิน', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'ยอดเงินในวอลเล็ท: ฿$availableBalance',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _categoryButton('TrueMoney'),
                _categoryButton('PromptPay'),
              ],
            ),
            const SizedBox(height: 20),
            _styledInputField(phoneController, 'เบอร์โทรศัพท์มือถือผู้รับ', TextInputType.phone),
            _styledInputField(amountController, 'ใส่จำนวนเงิน', TextInputType.number),
            _styledInputField(messageController, 'ข้อความถึงผู้รับ', TextInputType.text),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(
                      phone: phoneController.text,
                      amount: amountController.text,
                      message: messageController.text,
                      balance: availableBalance,
                    ),
                  ),
                );
              },
              child: const Text('โอนเงิน', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton(String category) {
    final isSelected = category == selectedCategory;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.orange),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _styledInputField(TextEditingController controller, String hint, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
