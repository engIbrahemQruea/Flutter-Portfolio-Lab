import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:pizza_app/features/screens/home/pizza_order_screen.dart';
import 'package:provider/provider.dart';


class PizzaMain extends StatelessWidget {
  const PizzaMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza App', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: ChangeNotifierProvider(
        create: (context) => PizzaProvider(),
        child: const PizzaOrderScreen(),
      ),
    );
  }
}
