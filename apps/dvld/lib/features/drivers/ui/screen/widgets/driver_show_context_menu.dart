import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/drivers/ui/screen/widgets/driver_actions_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

extension DriverContextMenuX on BuildContext {
  Future<DriverMenuAction?> showDriverContextMenu(Offset position) async {
    final entries = <ContextMenuEntry<DriverMenuAction>>[
      const MenuHeader(text: "Driver Menu"),
      MenuItem(
        //  enabled: permissions.canShowAppDetails,
        label: Text(DriverMenuAction.showPersonInfo.label),
        value: DriverMenuAction.showPersonInfo,
        icon: const Icon(Icons.person_search_outlined, color: Colors.blue),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(DriverMenuAction.showPersonLicensesHistory.label),
        // enabled: permissions.canEdit,
        value: DriverMenuAction.showPersonLicensesHistory,
        icon: const Icon(Icons.edit, color: Colors.green),
      ),
    ];

    final contextMenu = ContextMenu(
      entries: entries,
      position: position,
      padding: const EdgeInsets.all(8.0),
    );

    return showContextMenu<DriverMenuAction>(this, contextMenu: contextMenu);
  }
}

Future<bool> handleDriverMenuAction(
  BuildContext context,
  DriverMenuAction action,
  int personId,
) async {
  bool isOperationSuccess = false;
  switch (action) {
    case DriverMenuAction.showPersonInfo:
      final result = await context.pushNamed<bool>(
        DRoutes.personDetailsScreen,
        queryParameters: {'personId': personId.toString()},
      );
      isOperationSuccess = result ?? false;
      break;
    case DriverMenuAction.showPersonLicensesHistory:
      final result = await context.pushNamed<bool>(
        DRoutes.showPersonLicenseHistoryScreen,
        queryParameters: {'personId': personId.toString()},
      );
      isOperationSuccess = result ?? false;
      break;
  }
  return isOperationSuccess;
}
