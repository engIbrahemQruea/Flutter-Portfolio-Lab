// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/widgets/info_tile_widget.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/read_entity/international_license_details_read_entity.dart';
import 'package:dvld/core/widgets/person_avatar.dart';
import 'package:flutter/material.dart';

class DriverInternationalLicenseInfo extends StatelessWidget {
  const DriverInternationalLicenseInfo({
    super.key,
    this.internationalLicenseDetails,
  });

  final InternationalLicenseDetailsReadEntity? internationalLicenseDetails;

  @override
  Widget build(BuildContext context) {
    final internationalLicense =
        internationalLicenseDetails?.internationalLicenseEntity;
    final licenseDetails = internationalLicenseDetails?.licenseDetailsEntity;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: licenseDetails?.isExpired ?? false
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
                        'Driver International License Information',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),

                      Text(
                        ' International License ID: ${internationalLicense?.internationalLicenseId ?? '???'}',
                        style: TextStyle(color: Colors.white70, fontSize: 11.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(10),

          Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonAvatar(
                  imagePath: licenseDetails?.imagePath,
                  gender: licenseDetails?.gender,
                ),
                horizontalSpace(16),
                Expanded(
                  child: Wrap(
                    spacing: 9,
                    runSpacing: 9,
                    children: [
                      InfoTileWidget(
                        label: 'Name',
                        value: licenseDetails?.fullName ?? '???',
                        wide: true,
                      ),
                      // InfoTileWidget(
                      //   label: 'International License ID',
                      //   value: licenseDetails.className,
                      // ),
                      InfoTileWidget(
                        label: 'License ID',
                        value:
                            internationalLicense?.issuedUsingLocalLicenseId
                                .toString() ??
                            '???',
                      ),
                      InfoTileWidget(
                        label: 'Driver ID',
                        value:
                            internationalLicense?.driverId.toString() ?? '???',
                      ),
                      InfoTileWidget(
                        label: 'National No',
                        value: licenseDetails?.nationalNo ?? '???',
                      ),
                      InfoTileWidget(
                        label: 'Issued Date',
                        value:
                            internationalLicense?.issueDate.toFormattedDate ??
                            '???',
                      ),
                      InfoTileWidget(
                        label: 'Expiry Date',
                        valueColor: internationalLicense?.isActive == true
                            ? Colors.green[700]
                            : null,

                        value:
                            internationalLicense
                                ?.expirationDate
                                .toFormattedDate ??
                            '???',
                      ),
                      InfoTileWidget(
                        label: 'Gender',
                        value: licenseDetails?.gender == 0 ? 'Male' : 'Female',
                      ),
                      InfoTileWidget(
                        label: 'Date Of Birth',
                        value:
                            licenseDetails?.dateOfBirth.toFormattedDate ??
                            '???',
                      ),
                      InfoTileWidget(
                        label: 'Application ID',
                        value:
                            internationalLicense?.applicationId.toString() ??
                            '???',
                      ),
                      InfoTileWidget(
                        label: 'Is Active',
                        value: internationalLicense?.isActive == true
                            ? '✓ Active '
                            : 'Not Active',
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
