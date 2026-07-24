import 'package:dvld/features/people/presentation/shared_widgets/person_selector/person_selector.dart';
import 'package:flutter/material.dart';

class FindPersonScreen extends StatelessWidget {
  const FindPersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find  Person Screen '), centerTitle: true),
      body: PersonSelector(),
    );
  }
}
