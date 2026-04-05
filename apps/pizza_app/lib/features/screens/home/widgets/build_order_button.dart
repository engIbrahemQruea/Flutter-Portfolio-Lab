import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

class BuildOrderButton extends StatelessWidget {
  const BuildOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AbsorbPointer(
          absorbing: Provider.of<PizzaProvider>(context).isEnabled,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text("Place this order?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        Provider.of<PizzaProvider>(
                          context,
                          listen: false,
                        ).setIsEnabled(true);
                      },
                      child: const Text("Order Now"),
                    ),
                  ],
                ),
              );
            },
            child: const Text("Order Pizza"),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            // minimumSize: const Size(double.infinity, 50),
          ),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => AlertDialog(
                title: const Text("Confirm"),
                content: const Text("Place this order?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<PizzaProvider>(
                        context,
                        listen: false,
                      ).resetOrder();
                      Navigator.pop(ctx);
                    },
                    child: const Text("Reset Now"),
                  ),
                ],
              ),
            );
          },
          child: const Text("Reset Order"),
        ),
      ],
    );
  }
}
