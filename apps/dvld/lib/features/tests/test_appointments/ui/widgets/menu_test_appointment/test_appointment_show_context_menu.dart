import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/tests/test_appointments/ui/widgets/menu_test_appointment/test_appointment_menu_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

extension TestAppointmentContextMenuX on BuildContext {
  Future<TestAppointmentMenuAction?> showTestAppointmentContextMenu(
    Offset position,
  ) async {
    final entries = <ContextMenuEntry<TestAppointmentMenuAction>>[
      const MenuHeader(text: "Test Appointment Menu"),
      MenuItem(
        //  enabled: permissions.canShowAppDetails,
        label: Text(TestAppointmentMenuAction.editApp.label),
        value: TestAppointmentMenuAction.editApp,
        icon: const Icon(Icons.person_search_outlined, color: Colors.blue),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(TestAppointmentMenuAction.takeTest.label),
        // enabled: permissions.canEdit,
        value: TestAppointmentMenuAction.takeTest,
        icon: const Icon(Icons.edit, color: Colors.green),
      ),
    ];

    final contextMenu = ContextMenu(
      entries: entries,
      position: position,
      padding: const EdgeInsets.all(8.0),
    );

    return showContextMenu<TestAppointmentMenuAction>(
      this,
      contextMenu: contextMenu,
    );
  }
}

Future<bool> handleTestAppointmentMenuAction(
  BuildContext context,
  TestAppointmentMenuAction action,
  int testAppointmentId,
) async {
  bool isOperationSuccess = false;
  switch (action) {
    case TestAppointmentMenuAction.editApp:
      // Handle edit appointment action
      return true;
    case TestAppointmentMenuAction.takeTest:
      final result = await context.pushNamed<bool>(
        DRoutes.takeTestScreen,
        queryParameters: {'testAppointmentId': testAppointmentId.toString()},
      );
      isOperationSuccess = result ?? false;
      break;
  }
  return isOperationSuccess;
}
