// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_info_entity.dart';
import 'package:dvld/features/tests/schedule_test/ui/logic/schedule_test/schedule_test_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScheduleTestInfo extends StatelessWidget {
  const ScheduleTestInfo({super.key, this.info});

  final ScheduleTestInfoEntity? info;

  DateTime _resolveMinDate(ScheduleTestInfoEntity info) {
    if (info.testAppointment == null) return DateTime.now();
    final apptDate = info.testAppointment!.appointmentDate;
    return DateTime.now().isBefore(apptDate) ? DateTime.now() : apptDate;
  }

  @override
  Widget build(BuildContext context) {
    final currentInfo = info;
    final previousScreenData = currentInfo?.localApplicationDetailsReadEntity;
    final canEdit = currentInfo?.canSchedule ?? false;

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
        InfoItem(
          label: 'Trial',
          value: currentInfo?.trialNumber.toString() ?? 'N/A',
        ),
        Row(
          mainAxisSize: .min,
          children: [
            const Text('Date :  '),
            OutlinedButton.icon(
              onPressed: !canEdit
                  ? null
                  : () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            currentInfo?.testAppointment?.appointmentDate ??
                            DateTime.now(),
                        firstDate: _resolveMinDate(currentInfo!),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null && context.mounted) {
                        context.read<ScheduleTestCubit>().updateSelectedDate(
                          picked,
                        );
                      }
                    },
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_drop_down_outlined, size: 30),
              label: Text(
                (currentInfo?.testAppointment?.appointmentDate ??
                        DateTime.now())
                    .toFormattedDate,
              ),
            ),
          ],
        ),

        InfoItem(
          label: 'Fees',
          value: currentInfo?.testFees.toString() ?? 'N/A',
        ),
      ],
    );
  }
}
