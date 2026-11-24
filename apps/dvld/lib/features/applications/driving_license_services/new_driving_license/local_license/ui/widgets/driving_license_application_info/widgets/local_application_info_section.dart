// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/info_card_widget.dart';
import 'package:dvld/core/widgets/info_link_button.dart';
import 'package:dvld/core/widgets/info_tile.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/license_class_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/entities/local_driving_license_application_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/widgets/driving_license_application_info/widgets/tests_progress_bar.dart';
import 'package:flutter/material.dart';

class DrivingLicenseApplicationInfoSection extends StatelessWidget {
  const DrivingLicenseApplicationInfoSection({
    super.key,
    required this.localDrLiAppEntity,
    required this.licenseClassEntity,
    required this.passedTestCount,
  });

  final LocalDrivingLicenseApplicationEntity? localDrLiAppEntity;
  final LicenseClassEntity? licenseClassEntity;
  final int passedTestCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // spacing: 5,
      children: [
        InfoCardWidget(
          icon: '📝',
          title: 'Driving License Application Info',
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 5.4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  InfoTile(
                    label: 'D.L.App ID ',
                    value: '${localDrLiAppEntity?.localDrLiAppId}' ?? ' ??? ',
                  ),
                  InfoTile(
                    label: 'Applied For License ',
                    value: licenseClassEntity?.className ?? ' ??? ',
                  ),
                ],
              ),
              verticalSpace(14),
              TestsProgressBar(passed: passedTestCount, total: 3),
              verticalSpace(12),
              InfoLinkButton(
                label: 'Show License Info',
                onTap: () => context.pushNamed(
                  DRoutes.showLicenseInfoScreen,
                  queryParameters: {
                    'localDrLiApplicationId': localDrLiAppEntity?.localDrLiAppId
                        .toString(),
                    'licenseId': 0.toString(),
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
