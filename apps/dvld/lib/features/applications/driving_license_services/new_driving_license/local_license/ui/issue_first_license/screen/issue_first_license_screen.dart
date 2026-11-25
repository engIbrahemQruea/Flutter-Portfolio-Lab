import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/widgets/bloc_listener_save_close_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/issue_first_license/widgets/card_note_widget.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/driving_license_application_info.dart';
import 'package:flutter/material.dart';

class IssueFirstLicenseScreen extends StatelessWidget {
  const IssueFirstLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue First License'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            spacing: 20,
            children: [
              DrivingLicenseApplicationInfo(),

              CardNoteWidget(),
              BlocListenerSaveCloseWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
