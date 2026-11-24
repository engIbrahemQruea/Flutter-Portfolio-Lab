// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_creation_mode.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:flutter/material.dart';

class RetakeTestInfo extends StatelessWidget {
  const RetakeTestInfo({super.key, this.info});

  final ScheduleTestInfoEntity? info;

  @override
  Widget build(BuildContext context) {
    final isRetake =
        (info!.scheduleTestCreationMode == ScheduleTestCreationMode.retake);
    return IgnorePointer(
      ignoring: isRetake,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isRetake ? 1 : 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            InfoItem(
              label: 'R Test App ID',
              value:
                  info?.testAppointment?.retakeTestApplicationID.toString() ??
                  'N/A',
            ),
            InfoItem(
              label: 'Total Fees ',
              value: info?.totalFees.toString() ?? 'N/A',
            ),
            InfoItem(
              label: 'R App Fees',
              value: info?.retakeFees.toString() ?? '',
            ),
          ],
        ),
      ),
    );
  }
}
