// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/core/widgets/info_card_widget.dart';
import 'package:dvld/core/widgets/info_link_button.dart';
import 'package:dvld/core/widgets/info_tile.dart';
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // spacing: 5,
      children: [
        InfoCardWidget(
          icon: '👤',
          title: 'Application Basic Info',
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
                    label: 'ID',
                    value: '${application?.applicationId}' ?? ' ??? ',
                  ),
                  InfoTile(
                    label: 'Status',
                    value:
                        '${application?.applicationStatus.englishName}' ??
                        ' ??? ',
                  ),

                  InfoTile(
                    label: 'Applicant',
                    value: person?.fullName ?? ' ??? ',
                  ),
                  InfoTile(
                    label: 'Type',
                    value: applicationType?.applicationTypeTitle ?? ' ??? ',
                    //  value: 'New Local Driving License Service' ?? ' ??? ',
                  ),

                  InfoTile(
                    label: 'Date',
                    value:
                        application?.applicationDate.toFormattedDate ??
                        ' [??/??/???] ',
                  ),
                  InfoTile(
                    label: 'Status Date',
                    //                   // value: '09/Oct/2022' ?? ' [??/??/???] ',
                    value:
                        application?.lastStatusDate.toFormattedDate ??
                        ' [??/??/???] ',
                  ),

                  InfoTile(
                    label: 'Created By',
                    value: createdByUser?.userName ?? ' ??? ',
                  ),
                  InfoTile(
                    label: 'Fees',
                    valueColor: const Color(0xFF1E9E5A),
                    value: '${application?.paidFees}' ?? ' ??? ',
                  ),
                ],
              ),

              InfoLinkButton(
                label: 'View Person Info',
                onTap: () => context.pushNamed(
                  DRoutes.personDetailsScreen,
                  queryParameters: {'personId': person?.personId.toString()},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
