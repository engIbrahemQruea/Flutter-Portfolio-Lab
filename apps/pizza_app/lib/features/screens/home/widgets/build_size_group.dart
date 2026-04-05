import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

enum PizzaSize { small, medium, large }

class BuildSizeGroup extends StatelessWidget {
  const BuildSizeGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Size", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioGroup<PizzaSize>(
            groupValue: Provider.of<PizzaProvider>(context).selectedSize,
            onChanged: (value) {
              Provider.of<PizzaProvider>(
                context,
                listen: false,
              ).setSelectedSize(value!);
            },
            child: Column(
              children: PizzaSize.values
                  .map(
                    (size) => RadioListTile<PizzaSize>(
                      title: Text(
                        size.toString().split('.').last.toUpperCase(),
                      ),
                      value: size,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
