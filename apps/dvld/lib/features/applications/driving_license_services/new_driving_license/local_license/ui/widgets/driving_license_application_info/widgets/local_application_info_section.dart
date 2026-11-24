// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/core/widgets/text_rich_link_show_info.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:flutter/material.dart';

class DrivingLicenseApplicationInfoSection extends StatelessWidget {
  const DrivingLicenseApplicationInfoSection({
    super.key,
    required this.localDrLiAppEntity,
    required this.licenseClassEntity,
  });

  final LocalDrivingLicenseApplicationEntity? localDrLiAppEntity;
  final LicenseClassEntity? licenseClassEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        const Text(
          'Driving License Application Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          child: Padding(
            padding: const .symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  spacing: 10,
                  children: [
                    InfoItem(
                      label: 'D.L.App ID ',
                      value: '${localDrLiAppEntity?.localDrLiAppId}' ?? ' ??? ',
                    ),
                    InfoItem(
                      label: 'Passed Tests ',
                      value: 'يتم برمجتها/3' ?? ' ??? ',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  spacing: 10,
                  children: [
                    InfoItem(
                      label: 'Applied For License ',
                      value: licenseClassEntity?.className ?? ' ??? ',
                    ),
                    // InfoItem(label: 'Show License Info', value: '1' ?? ' ??? '),
                    TextRichLinkShowInfo(text: 'Show License Info'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
