import 'package:flutter/material.dart';
import 'package:pizza_app/features/screens/home/logic/pizza_provider.dart';
import 'package:provider/provider.dart';

class BuildNotesField extends StatelessWidget {
  const BuildNotesField({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextField(
          maxLength: 100,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Special Instructions",
            hintText: "e.g. No onions, extra spicy...",
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            Provider.of<PizzaProvider>(context, listen: false).setNotes(value);
          },
        ),
      ),
    );
  }
}
