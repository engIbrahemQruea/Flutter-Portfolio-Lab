import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:flutter/material.dart';

import 'license_status_badge.dart';

class InternationalLicensesTab extends StatelessWidget {
  final List<InternationalLicenseEntity> licenses;
  final void Function(int internationalLicenseId) onShowInternationalInfo;

  const InternationalLicensesTab({
    super.key,
    required this.licenses,
    required this.onShowInternationalInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (licenses.isEmpty) {
      return const Center(child: Text('No international licenses found.'));
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: licenses.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final l = licenses[i];
        return ListTile(
          leading: const Icon(Icons.public),
          title: Text(
            'International License ID : ${l.internationalLicenseId}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Wrap(
            runSpacing: 5,
            spacing: 24,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text('License ID : ${l.issuedUsingLocalLicenseId}  '),
                  Text('Application ID : ${l.applicationId}  '),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text('Issue Date : ${l.issueDate.toFormattedDate}  '),
                  Text('Expiration Date : ${l.expirationDate.toFormattedDate}'),
                ],
              ),
            ],
          ),
          trailing: Wrap(
          runSpacing: 5,
            spacing: 24,
            children: [
              LicenseStatusBadge(
                isActive: l.isActive,
                isExpired: l.isExpiredDate,
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (_) =>
                    onShowInternationalInfo(l.internationalLicenseId!),
                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: 'info',
                    child: ListTile(
                      leading: Icon(Icons.info_outline),
                      title: Text('View International License Information'),
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
