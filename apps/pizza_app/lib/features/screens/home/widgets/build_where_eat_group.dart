import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

enum WhereToEat { dineIn, takeOut, delivery }

class BuildWhereEatGroup extends StatelessWidget {
  const BuildWhereEatGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Where to Eat",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          RadioGroup<WhereToEat>(
            groupValue: Provider.of<PizzaProvider>(context).selectedWhereToEat,
            onChanged: (value) {
              Provider.of<PizzaProvider>(
                context,
                listen: false,
              ).setSelectedWhereToEat(value!);
            },
            child: Column(
              children: WhereToEat.values
                  .map(
                    (option) => RadioListTile<WhereToEat>(
                      title: Text(
                        option.toString().split('.').last.toUpperCase(),
                      ),
                      value: option,
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
