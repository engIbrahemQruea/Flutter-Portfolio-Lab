// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/core/widgets/text_rich_link_show_info.dart';
import 'package:dvld/features/applications/application_types/domain/entity/application_type_entity.dart';
import 'package:dvld/features/applications/applications_core/application_helper/extention_application_status.dart';
import 'package:dvld/features/applications/applications_core/domain/entities/application_entity.dart';
import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:flutter/material.dart';

class ApplicationBasicInfo extends StatelessWidget {
  const ApplicationBasicInfo({
    super.key,
    required this.application,
    required this.person,
    required this.applicationType,
    required this.createdByUser,
  });

  final ApplicationEntity? application;
  final PeopleEntity? person;
  final ApplicationTypeEntity? applicationType;
  final UserEntity? createdByUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        const Text(
          'Application Basic Info',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Card(
          child: Padding(
            padding: const .symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    InfoItem(
                      label: 'ID',
                      value: '${application?.applicationId}' ?? ' ??? ',
                    ),
                    InfoItem(
                      label: 'Status',
                      value:
                          '${application?.applicationStatus.englishName}' ??
                          ' ??? ',
                    ),
                    InfoItem(
                      label: 'Fees',
                      value: '${application?.paidFees}' ?? ' ??? ',
                    ),
                    InfoItem(
                      label: 'Type',
                      value: applicationType?.applicationTypeTitle ?? ' ??? ',
                      //  value: 'New Local Driving License Service' ?? ' ??? ',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    InfoItem(
                      label: 'Applicant',
                      value: person?.fullName ?? ' ??? ',
                    ),
                    InfoItem(
                      label: 'Date',
                      value:
                          application?.applicationDate.toFormattedDate ??
                          ' [??/??/???] ',
                    ),
                    InfoItem(
                      label: 'Status Date',
                      // value: '09/Oct/2022' ?? ' [??/??/???] ',
                      value:
                          application?.lastStatusDate.toFormattedDate ??
                          ' [??/??/???] ',
                    ),
                    InfoItem(
                      label: 'Created By',
                      value: createdByUser?.userName ?? ' ??? ',
                    ),
                    TextRichLinkShowInfo(text: 'View Person Info'),
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
