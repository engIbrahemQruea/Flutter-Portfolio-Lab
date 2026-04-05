import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

class BuildSummarySection extends StatelessWidget {
  const BuildSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PizzaProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Summary",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        const Divider(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Size: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: provider.selectedSize.name.toUpperCase(),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Crust: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: provider.selectedCrust.name.toUpperCase(),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Toppings: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: provider.toppings.entries
                    .where((e) => e.value)
                    .map((e) => e.key)
                    .join(", "),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Where to Eat: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              TextSpan(
                text: provider.selectedWhereToEat.name,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          "Total Price: \$${provider.calculateTotal}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
