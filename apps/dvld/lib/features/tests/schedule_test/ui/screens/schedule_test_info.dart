// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:flutter/material.dart';

class ScheduleTestInfo extends StatelessWidget {
  const ScheduleTestInfo({super.key, this.info});

  final ScheduleTestInfoEntity? info;

  @override
  Widget build(BuildContext context) {
    final previousScreenData = info?.localApplicationDetailsReadEntity;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        InfoItem(
          label: 'D.L.App ID',
          value:
              previousScreenData?.localApplicationEntity.localDrLiAppId
                  ?.toString() ??
              'N/A',
        ),
        InfoItem(
          label: 'D Classes',
          value: previousScreenData?.licenseClassEntity.className ?? 'N/A',
        ),
        InfoItem(
          label: 'Name',
          value: previousScreenData?.personEntity.fullName ?? 'N/A',
        ),
        InfoItem(label: 'Trial', value: info?.trialNumber.toString() ?? 'N/A'),
        InfoItem(
          label: 'Date',
          value:
              info?.testAppointment?.appointmentDate.toFormattedDate ?? 'N/A',
        ),
        InfoItem(label: 'Fees', value: info?.testFees.toString() ?? 'N/A'),
      ],
    );
  }
}
