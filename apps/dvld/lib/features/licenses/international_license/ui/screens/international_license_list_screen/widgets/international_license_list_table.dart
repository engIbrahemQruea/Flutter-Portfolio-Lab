import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/features/licenses/international_license/domain/entities/international_license_entity.dart';
import 'package:dvld/features/licenses/international_license/ui/screens/international_license_list_screen/widgets/international_license_list_enums.dart';
import 'package:flutter/material.dart';

class InternationalLicenseListTable extends StatelessWidget {
  final List<InternationalLicenseEntity> entries;
  final void Function(InternationalLicenseEntity, InternationalLicenseRowAction)
  onAction;

  const InternationalLicenseListTable({
    super.key,
    required this.entries,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: entries.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final e = entries[i];
        return ListTile(
          leading: StatusIcon(isActive: e.isActive),
          title: Text(
            ' e.fullName',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.badge, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    ' Internal ID : ${e.internationalLicenseId}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'License ID : ${e.issuedUsingLocalLicenseId}  |  Application ID : ${e.applicationId}  |  Driver ID : ${e.driverId}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Issue Date : ${e.issueDate.toFormattedDateTime}  |  Expiration Date : ${e.expirationDate.toFormattedDateTime}  ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReleaseBadge(isActive: e.isActive),
              PopupMenuButton<InternationalLicenseRowAction>(
                icon: const Icon(Icons.more_vert),
                onSelected: (a) => onAction(e, a),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: InternationalLicenseRowAction.personDetails,
                    child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Show Person Details'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: InternationalLicenseRowAction.licenseDetails,
                    child: ListTile(
                      leading: Icon(Icons.badge_outlined),
                      title: Text('Show License Details'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: InternationalLicenseRowAction.licenseHistory,
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('Show License History '),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  // PopupMenuItem(
                  //   value: InternationalLicenseRowAction.release,
                  //   enabled: e.isReleased == false,
                  //   child: const ListTile(
                  //     leading: Icon(Icons.lock_open),
                  //     title: Text('Release Detained License'),
                  //     contentPadding: EdgeInsets.zero,
                  //   ),
                  //),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReleaseBadge extends StatelessWidget {
  const ReleaseBadge({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFFDECEE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Active' : 'Not Active',
        style: TextStyle(
          color: isActive ? Color(0xFF1E9E5A) : Color(0xFFD33F49),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );

    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
    //   decoration: BoxDecoration(
    //     color: const Color(0xFFE7F8EE),
    //     borderRadius: BorderRadius.circular(20),
    //   ),
    //   child: Text(
    //     'Active ${releaseDate != null ? releaseDate.toFormattedDate : ''}',
    //     style: const TextStyle(
    //       color: Color(0xFF1E9E5A),
    //       fontWeight: FontWeight.w700,
    //       fontSize: 12,
    //     ),
    //   ),
    // );
  }
}

class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) => CircleAvatar(
    backgroundColor: isActive
        ? const Color(0xFFE7F8EE)
        : const Color(0xFFFDECEE),
    child: Icon(
      isActive ? Icons.lock_open : Icons.lock_outline,
      size: 20,
      color: isActive ? const Color(0xFF1E9E5A) : const Color(0xFFD33F49),
    ),
  );
}
