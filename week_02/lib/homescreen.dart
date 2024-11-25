import 'package:flutter/material.dart';
import 'package:week_02/widget/mytext.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.heart_broken),
            MyText('Count Click: $counter'),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    counter++,
                  });
                },
                child: Text('Submit'),
            )
          ],
        )
    );
  }
}
