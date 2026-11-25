// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/license_details_entity.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/driver_license_info/widgets/status_pill_widget.dart';
import 'package:flutter/material.dart';

class DriverLicenseInfo extends StatelessWidget {
  const DriverLicenseInfo({super.key, required this.licenseDetails});

  final LicenseDetailsEntity licenseDetails;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: licenseDetails.isExpired
                    ? [Colors.red, Colors.redAccent]
                    : [Color(0xFF4C3FB5), Color(0xFF6A5AE0)],
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.badge, color: Colors.white),
                horizontalSpace(6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        'Driver License Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        ' License ID: ${licenseDetails.licenseID}',
                        style: TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 96,
                      height: 112,
                      decoration: BoxDecoration(
                        color: Color(0xFFE9E6FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: licenseDetails.imagePath != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.file(
                                File(licenseDetails.imagePath!),
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: 40,
                              color: Color(0xFF6A5AE0),
                            ),
                    ),
                    verticalSpace(16),
                    StatusPillWidget(
                      text: licenseDetails.isActive
                          ? 'Is Active ✓ '
                          : 'Not Active',
                      ok: licenseDetails.isActive,
                    ),
                  ],
                ),
                horizontalSpace(16),
                Expanded(
                  child: Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: [
                      InfoTileWidget(
                        label: 'Class',
                        value: licenseDetails.className,
                        wide: true,
                      ),
                      InfoTileWidget(
                        label: 'Name',
                        value: licenseDetails.fullName,
                        wide: true,
                      ),
                      InfoTileWidget(
                        label: 'Driver ID',
                        value: licenseDetails.driverID.toString(),
                      ),
                      InfoTileWidget(
                        label: 'National No',
                        value: licenseDetails.nationalNo,
                      ),
                      InfoTileWidget(
                        label: 'Issued Date',
                        value: licenseDetails.issueDate.toFormattedDate,
                      ),
                      InfoTileWidget(
                        label: 'Expiry Date',
                        value: licenseDetails.expirationDate.toFormattedDate,
                      ),
                      InfoTileWidget(
                        label: 'Gender',
                        value: licenseDetails.gender == 0 ? 'Male' : 'Female',
                      ),
                      InfoTileWidget(
                        label: 'Place Of Birth',
                        value: licenseDetails.dateOfBirth.toFormattedDate,
                      ),
                      InfoTileWidget(
                        label: 'Issue Reason',
                        value: IssueReason.fromValue(
                          licenseDetails.issueReason,
                        ).name,
                      ),
                      InfoTileWidget(
                        label: 'Note',
                        value: licenseDetails.notes ?? '',
                      ),
                      InfoTileWidget(
                        label: 'Is Detained',
                        value: licenseDetails.isDetained == true ? 'Yes' : 'No',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
