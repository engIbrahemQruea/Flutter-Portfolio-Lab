import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:pizza_app/features/screens/home/widgets/build_crust_type_group.dart';
import 'package:pizza_app/features/screens/home/widgets/build_note_field.dart';
import 'package:pizza_app/features/screens/home/widgets/build_order_button.dart';
import 'package:pizza_app/features/screens/home/widgets/build_size_group.dart';
import 'package:pizza_app/features/screens/home/widgets/build_summary_section.dart';
import 'package:pizza_app/features/screens/home/widgets/build_toppings_group.dart';
import 'package:pizza_app/features/screens/home/widgets/build_where_eat_group.dart';
import 'package:provider/provider.dart';

class PizzaOrderScreen extends StatelessWidget {
  const PizzaOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MAKE YOUR OWN PIZZA',
          style: TextStyle(
            color: Colors.red,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AbsorbPointer(
                    absorbing: Provider.of<PizzaProvider>(context).isEnabled,
                    child: Column(
                      children: [
                        const BuildSizeGroup(),
                        const SizedBox(height: 10),
                        const BuildToppingsGroup(),
                        const SizedBox(height: 10),
                        const BuildCrustTypeGroup(),
                        const SizedBox(height: 10),
                        const BuildWhereEatGroup(),
                        const SizedBox(height: 20),
                        const BuildNotesField(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const BuildOrderButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.grey[100],
              padding: const EdgeInsets.all(20),
              child: const BuildSummarySection(),
            ),
          ),
        ],
      ),
    );
  }
}
