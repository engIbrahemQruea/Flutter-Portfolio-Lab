// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/features/licenses/licenses_core/ui/license_history_screen/ui/screens/widgets/person_license_history_content.dart';
import 'package:flutter/material.dart';

class PersonLicenseHistoryScreen extends StatelessWidget {
  const PersonLicenseHistoryScreen({super.key, this.personId});

  final int? personId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('License History'), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: SingleChildScrollView(
            child: PersonLicenseHistoryContent(personID: personId ),
          ),
        ),
      ),
    );
  }
}
