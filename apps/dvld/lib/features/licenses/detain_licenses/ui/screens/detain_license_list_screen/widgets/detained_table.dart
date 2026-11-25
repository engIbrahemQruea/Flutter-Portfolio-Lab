// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/helpers/extensions_x/extensions_x.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';
import 'package:dvld/features/licenses/detain_licenses/ui/screens/detain_license_list_screen/widgets/detained_licenses_list_enums.dart';
import 'package:flutter/material.dart';

class DetainedTable extends StatelessWidget {
  final List<DetainLicenseItemEntity> entries;
  final void Function(DetainLicenseItemEntity, DetainedRowAction) onAction;

  const DetainedTable({
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
          leading: StatusIcon(isReleased: e.isReleased),
          title: Text(
            e.fullName,
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
                    ' National No : ${e.nationalNo}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Detain ID : ${e.detainID}  |  License ID : ${e.licenseID}  |  Fine Fees : ${e.fineFees}',
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
              ReleaseBadge(
                isReleased: e.isReleased,
                releaseDate: e.releaseDate,
              ),
              PopupMenuButton<DetainedRowAction>(
                icon: const Icon(Icons.more_vert),
                onSelected: (a) => onAction(e, a),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: DetainedRowAction.personDetails,
                    child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('Show Person Details'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: DetainedRowAction.licenseDetails,
                    child: ListTile(
                      leading: Icon(Icons.badge_outlined),
                      title: Text('Show License Details'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuItem(
                    value: DetainedRowAction.licenseHistory,
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('Show License History '),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  PopupMenuItem(
                    value: DetainedRowAction.release,
                    enabled: e.isReleased == false,
                    child: const ListTile(
                      leading: Icon(Icons.lock_open),
                      title: Text('Release Detained License'),
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

class ReleaseBadge extends StatelessWidget {
  const ReleaseBadge({
    super.key,
    required this.isReleased,
    required this.releaseDate,
  });

  final bool isReleased;
  final DateTime? releaseDate;

  @override
  Widget build(BuildContext context) {
    if (!isReleased) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFFDECEE),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          'Detained',
          style: TextStyle(
            color: Color(0xFFD33F49),
            fontWeight: FontWeight.w700,
            fontSize: 12,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F8EE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Released ${releaseDate != null ? releaseDate.toFormattedDate : ''}',
        style: const TextStyle(
          color: Color(0xFF1E9E5A),
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}

class StatusIcon extends StatelessWidget {
  const StatusIcon({super.key, required this.isReleased});

  final bool isReleased;

  @override
  Widget build(BuildContext context) => CircleAvatar(
    backgroundColor: isReleased
        ? const Color(0xFFE7F8EE)
        : const Color(0xFFFDECEE),
    child: Icon(
      isReleased ? Icons.lock_open : Icons.lock_outline,
      size: 20,
      color: isReleased ? const Color(0xFF1E9E5A) : const Color(0xFFD33F49),
    ),
  );
}
