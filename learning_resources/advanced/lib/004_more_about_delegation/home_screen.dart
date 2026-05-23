import 'package:advanced/004_more_about_delegation/Multicast_delegate/multicast_console_screen.dart';
import 'package:advanced/004_more_about_delegation/func_delegate/currency_converter_screen.dart';
import 'package:advanced/004_more_about_delegation/logger_example/logger_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('More About Delegate==Callback(StreamController)'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoggerScreen()),
              );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Logger Screen'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MulticastConsoleScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Multicast Console Screen'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrencyConverterScreen(),
                ),
              );
            },
            icon: Icon(Icons.arrow_forward),
            label: Text('Currency Converter Screen'),
          ),
        ],
      ),
    );
  }
}
