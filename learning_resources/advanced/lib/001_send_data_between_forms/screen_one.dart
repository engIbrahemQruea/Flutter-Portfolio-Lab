import 'package:advanced/001_send_data_between_forms/screen_tow.dart';
import 'package:flutter/material.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen One'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(child: Text('This is Screen One')),
          ElevatedButton(
            onPressed: () {
              //الشاشة المر - عند الضغط على زر مثلاً:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsScreenTow(userId: 101, userName: 'Ibrahim'),
                ),
              );
            },
            child: Text('Send Data Using Counstractor'),
          ),
        ],
      ),
    );
  }
}
