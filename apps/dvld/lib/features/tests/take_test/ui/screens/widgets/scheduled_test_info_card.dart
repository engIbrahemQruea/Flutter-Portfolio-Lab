import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/core/widgets/info_item_row_widget.dart';
import 'package:dvld/features/login/presentation/screens/widgets/login_widgets.dart';
import 'package:dvld/features/tests/take_test/domain/entities/take_test_info_read_entity.dart';

class ScheduledTestInfoCard extends StatelessWidget {
  const ScheduledTestInfoCard({
    super.key,
    // required this.appointment,
    // required this.previousScreenData,
    // required this.info,
    required this.takeTestInfo,
  });

  final TakeTestInfoReadEntity takeTestInfo;

  //  IconData get _testIcon => switch (takeTestInfo.localAppDetailsReadEntity.) {
  //       TestType.vision => Icons.visibility,
  //       TestType.written => Icons.edit_note,
  //       TestType.street => Icons.drive_eta,
  //     };

  @override
  Widget build(BuildContext context) {
    final localAppDetailsReadEntity = takeTestInfo.localAppDetailsReadEntity;
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: .center,
          spacing: 5,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(
                  'Scheduled Test Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Divider(height: 14),
            InfoItem(
              label: 'D.L.App ID',
              value:
                  localAppDetailsReadEntity
                      .localApplicationEntity
                      .localDrLiAppId
                      .toString() ??
                  'N/A',
            ),
            InfoItem(
              label: 'D Classes',
              value:
                  localAppDetailsReadEntity.licenseClassEntity.className ??
                  'N/A',
            ),
            InfoItem(
              label: 'Name',
              value: localAppDetailsReadEntity.personEntity.fullName ?? 'N/A',
            ),
            InfoItem(
              label: 'Trial',
              value: takeTestInfo.trialNumber.toString() ?? 'N/A',
            ),
            InfoItem(
              label: 'Date',
              value:
                  takeTestInfo
                      .testAppointmentEntity
                      .appointmentDate
                      .toFormattedDate ??
                  'N/A',
            ),
            InfoItem(
              label: 'Fees',
              value:
                  localAppDetailsReadEntity
                      .applicationTypeEntity
                      .applicationTypeFees
                      .toString() ??
                  'N/A',
            ),
            InfoItem(
              label: 'Test ID',
              value: takeTestInfo.isTaken
                  ? takeTestInfo.testAppointmentEntity.testTypeID.toString()
                  : 'Not Taken Yet',
            ),
          ],
        ),
      ),
    );
  }
}
