import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/licenses/licenses_core/domain/entities/read_entity/local_license_history_entity.dart';
import 'package:dvld/features/licenses/licenses_core/ui/control_widgets/license_history_widgets/ui/widgets/license_status_badge.dart';
import 'package:flutter/material.dart';

class LocalLicensesTab extends StatelessWidget {
  final List<LocalLicenseHistoryEntity> licenses;
  final void Function(int licenseId) onShowLicenseInfo;

  const LocalLicensesTab({
    super.key,
    required this.licenses,
    required this.onShowLicenseInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (licenses.isEmpty) {
      return const Center(child: Text('No local licenses found.'));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: licenses.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final l = licenses[i];
        return ListTile(
          leading: const Icon(Icons.badge_outlined),
          title: Text(
            l.className,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Wrap(
            runSpacing: 5,
            spacing: 24,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text('License ID : ${l.licenseEntity.licenseID}  '),
                  Text('Application ID : ${l.licenseEntity.applicationId}  '),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    'Issue Date : ${l.licenseEntity.issueDate.toFormattedDate}  ',
                  ),
                  Text(
                    'Expiration Date : ${l.licenseEntity.expirationDate.toFormattedDate}',
                  ),
                ],
              ),
            ],
          ),
          trailing: Wrap(
            runSpacing: 5,
            spacing: 24,
            children: [
              LicenseStatusBadge(
                isActive: l.licenseEntity.isActive,
                isExpired: l.isExpired,
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (_) =>
                    onShowLicenseInfo(l.licenseEntity.licenseID!),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'info',
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('View License Information'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
