// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:flutter/material.dart';

class RetakeTestInfo extends StatelessWidget {
  const RetakeTestInfo({super.key, this.testAppointment});

  final ScheduleTestInfoEntity? testAppointment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        InfoItem(
          label: 'R App Fees',
          value: testAppointment?.retakeFees.toString() ?? '',
        ),
        InfoItem(
          label: 'Total Fees ',
          value: testAppointment?.totalFees.toString() ?? 'N/A',
        ),
        InfoItem(
          label: 'R Test App ID',
          value:
              testAppointment?.testAppointment?.retakeTestApplicationID
                  .toString() ??
              'N/A',
        ),
      ],
    );
  }
}
