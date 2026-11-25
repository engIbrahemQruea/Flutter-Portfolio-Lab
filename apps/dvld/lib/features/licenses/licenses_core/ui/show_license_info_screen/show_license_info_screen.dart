import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/licenses/licenses_core/ui/show_license_info_screen/widgets/bloc_builder_driver_license_info.dart';
import 'package:flutter/material.dart';

class ShowLicenseInfoScreen extends StatelessWidget {
  const ShowLicenseInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Driver License Info'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                BlocBuilderDriverLicenseInfo(),

                AppButton.icon(
                  label: 'Close',
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => context.pop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
