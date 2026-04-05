import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

enum CrustType { thin, thick }

class BuildCrustTypeGroup extends StatelessWidget {
  const BuildCrustTypeGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Crust Type",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          RadioGroup<CrustType>(
            groupValue: Provider.of<PizzaProvider>(context).selectedCrust,
            onChanged: (value) {
              Provider.of<PizzaProvider>(
                context,
                listen: false,
              ).setSelectedCrust(value!);
            },
            child: Column(
              children: CrustType.values
                  .map(
                    (crust) => RadioListTile<CrustType>(
                      title: Text(
                        crust.toString().split('.').last.toUpperCase(),
                      ),
                      value: crust,
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
