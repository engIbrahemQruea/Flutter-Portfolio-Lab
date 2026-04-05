import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

class BuildToppingsGroup extends StatelessWidget {
  const BuildToppingsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              "Toppings",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Wrap(
            children: Provider.of<PizzaProvider>(context).toppings.keys
                .map(
                  (topping) => SizedBox(
                    width: 200,
                    child: CheckboxListTile(
                      title: Text(topping),
                      minLeadingWidth: 20,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: Provider.of<PizzaProvider>(
                        context,
                      ).toppings[topping],
                      onChanged: (val) => {
                        Provider.of<PizzaProvider>(
                          context,
                          listen: false,
                        ).setTopping(topping, val!),
                      },
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
