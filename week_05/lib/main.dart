import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class Expense {
  String id;
  String title;
  String category;
  double amount;
  DateTime date_time;

  Expense(
      {required this.title,
      required this.category,
      required this.amount,
      required this.date_time})
      : id = const Uuid().v4();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpenseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpenseScreenState();
  }
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final expense_list = [
    Expense(
        title: 'dinner',
        category: 'food',
        amount: 500,
        date_time: DateTime(2024, 12, 10)),
    Expense(
        title: 'MRT',
        category: 'transport',
        amount: 120,
        date_time: DateTime(2024, 12, 11)),
    Expense(
        title: 'gift',
        category: 'shopping',
        amount: 499.99,
        date_time: DateTime(2024, 12, 12)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.add, color: Colors.white)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Total Expense: ',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${calculate_total()} THB',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: expense_list.length,
                itemBuilder: (context, index) {
                  final expense = expense_list[index];
                  return Card(
                    child: ListTile(
                      title: Text('${expense.title}, ${expense.category}'),
                      subtitle: Text(
                          '${DateFormat('dd/MM/yy').format(expense.date_time)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('${expense.amount.toStringAsFixed(2)} THB'),
                          SizedBox(width: 5),
                          Icon(Icons.money, color: Colors.green),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculate_total() {
    return expense_list.fold(0.0, (sum, expense) => sum + expense.amount);
  }
}
