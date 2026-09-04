import 'package:dvld/core/widgets/app_button.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/driving_license_application_info.dart';
import 'package:flutter/material.dart';

class ShowLocalDrivingLicenseApplicationInfoScreen extends StatelessWidget {
  const ShowLocalDrivingLicenseApplicationInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Driving License Application Info'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: .end,
            spacing: 10,
            children: [
              const DrivingLicenseApplicationInfo(),
              AppButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                label: 'Close',
                icon: const Icon(Icons.close, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
