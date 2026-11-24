import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/domain/read_entity/local_application_menu_permissions_entity.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/helper_list_local_dr_li_app/local_application_menu_action.dart';
import 'package:dvld/features/applications/driving_license_services/new_driving_license/local_license/ui/screens/local_driving_license_applications_list/logic/local_driving_license_applications_list_screen_cubit/local_driving_license_applications_list_screen_cubit.dart';
import 'package:dvld/features/tests/schedule_test/domain/entities/schedule_test_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

extension LocalAppContextMenuX on BuildContext {
  Future<LocalApplicationMenuAction?> showLocalAppContextMenu(
    Offset position, {
    required LocalApplicationMenuPermissionsEntity permissions,
  }) async {
    final entries = <ContextMenuEntry<LocalApplicationMenuAction>>[
      const MenuHeader(text: "Local Application Menu"),
      MenuItem(
        enabled: permissions.canShowAppDetails,
        label: Text(LocalApplicationMenuAction.showAppDetails.label),
        value: LocalApplicationMenuAction.showAppDetails,
        icon: const Icon(Icons.person_search_outlined, color: Colors.blue),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(LocalApplicationMenuAction.editApp.label),
        enabled: permissions.canEdit,
        value: LocalApplicationMenuAction.editApp,
        icon: const Icon(Icons.edit, color: Colors.green),
      ),
      MenuItem(
        label: Text(LocalApplicationMenuAction.deleteApp.label),
        enabled: permissions.canDelete,
        value: LocalApplicationMenuAction.deleteApp,
        icon: const Icon(Icons.delete, color: Colors.red),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(LocalApplicationMenuAction.cancelApp.label),
        enabled: permissions.canCancel,
        value: LocalApplicationMenuAction.cancelApp,
        icon: const Icon(Icons.cancel, color: Colors.red),
      ),
      MenuItem.submenu(
        label: Text(LocalApplicationMenuAction.scheduleTests.label),
        enabled: permissions.canScheduleTests,
        icon: const Icon(Icons.calendar_month, color: Colors.blue),
        items: [
          MenuItem(
            label: Text(LocalApplicationMenuAction.scheduleVisionTest.label),
            enabled: permissions.canScheduleVisionTest,
            value: LocalApplicationMenuAction.scheduleVisionTest,
            icon: const Icon(Icons.visibility, color: Colors.blue),
          ),
          MenuItem(
            label: Text(LocalApplicationMenuAction.scheduleWriteTest.label),
            enabled: permissions.canScheduleWrittenTest,
            value: LocalApplicationMenuAction.scheduleWriteTest,
            icon: const Icon(Icons.description, color: Colors.blue),
          ),
          MenuItem(
            label: Text(LocalApplicationMenuAction.scheduleStreetTest.label),
            enabled: permissions.canScheduleStreetTest,
            value: LocalApplicationMenuAction.scheduleStreetTest,
            icon: const Icon(Icons.directions_car, color: Colors.blue),
          ),
        ],
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(LocalApplicationMenuAction.issueDLFirstTime.label),
        enabled: permissions.canIssueLicense,
        value: LocalApplicationMenuAction.issueDLFirstTime,
        icon: const Icon(Icons.badge_outlined, color: Colors.blue),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(LocalApplicationMenuAction.showLicense.label),
        enabled: permissions.canShowLicense,
        value: LocalApplicationMenuAction.showLicense,
        icon: const Icon(Icons.card_membership, color: Colors.blue),
      ),
      const MenuDivider(),
      MenuItem(
        label: Text(LocalApplicationMenuAction.showPersonLicenseHistory.label),
        enabled: permissions.canShowPersonLicenseHistory,
        value: LocalApplicationMenuAction.showPersonLicenseHistory,
        icon: const Icon(Icons.history, color: Colors.blue),
      ),
    ];

    final contextMenu = ContextMenu(
      entries: entries,
      position: position,
      padding: const EdgeInsets.all(8.0),
    );

    return showContextMenu<LocalApplicationMenuAction>(
      this,
      contextMenu: contextMenu,
    );
  }
}

Future<bool> handleLocalAppMenuAction(
  BuildContext context, {
  required LocalApplicationMenuAction action,
  required int localApplicationId,
  required int personId,
}) async {
  final cubit = context.read<LocalDrivingLicenseApplicationsListScreenCubit>();

  switch (action) {
    case LocalApplicationMenuAction.showAppDetails:
      final result = await context.pushNamed<bool>(
        DRoutes.showLocalDrLiApplicationsInfoScreen,
        queryParameters: {
          'localDrLiApplicationId': localApplicationId.toString(),
        },
      );
      return result ?? false;

    case LocalApplicationMenuAction.editApp:
      final result = await context.pushNamed<bool>(
        DRoutes.addUpdateLocalDrLiApplicationsScreen,
        queryParameters: {
          'localDrLiApplicationId': localApplicationId.toString(),
        },
      );
      return result ?? false;

    case LocalApplicationMenuAction.deleteApp:
      final confirmAction = await AppDialogs.showConfirmation(
        context: context,
        title: 'Delete Application',
        confirmColor: Colors.red,
        icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
        confirmText: 'Delete',
        cancelText: 'Cancel',
        message: 'Are you sure you want to delete this application?',
      );

      if (confirmAction != true || !context.mounted) return false;

      await cubit.deleteLocalDrivingLicenseApplication(
        localDriLiceApplicationId: localApplicationId,
      );
      if (!context.mounted) return false;

      final stateAfterDelete = cubit.state;
      if (stateAfterDelete.loadLocalAppStatus.isFailure) {
        await AppDialogs.showFailure(
          context: context,
          title: 'Error',
          buttonText: 'OK',
          message:
              stateAfterDelete.errorMessage ?? 'Failed to delete application.',
        );
        return false;
      }

      await AppDialogs.showSuccess(
        context: context,
        title: 'Success',
        buttonText: 'OK',
        message: 'Application Deleted Successfully',
      );
      return true;

    case LocalApplicationMenuAction.cancelApp:
      final confirmCancel = await AppDialogs.showConfirmation(
        context: context,
        title: 'Cancel Application',
        confirmColor: Colors.orange,
        icon: const Icon(Icons.cancel_outlined, color: Colors.orange),
        confirmText: 'Yes',
        cancelText: 'No',
        message: 'Are you sure you want to cancel this application?',
      );

      if (confirmCancel != true || !context.mounted) return false;

      await cubit.cancelApplication(
        localDriLiceApplicationId: localApplicationId,
      );
      if (!context.mounted) return false;

      final stateAfterCancel = cubit.state;
      if (stateAfterCancel.loadLocalAppStatus.isFailure) {
        await AppDialogs.showFailure(
          context: context,
          title: 'Error',
          buttonText: 'OK',
          message:
              stateAfterCancel.errorMessage ?? 'Failed to cancel application.',
        );
        return false;
      }

      await AppDialogs.showSuccess(
        context: context,
        title: 'Success',
        buttonText: 'OK',
        message: 'Application Cancelled Successfully',
      );
      return true;

    case LocalApplicationMenuAction.scheduleVisionTest:
    case LocalApplicationMenuAction.scheduleWriteTest:
    case LocalApplicationMenuAction.scheduleStreetTest:
    case LocalApplicationMenuAction.scheduleTests:
      final testType = switch (action) {
        LocalApplicationMenuAction.scheduleVisionTest =>
          ScheduleTestType.vision,
        LocalApplicationMenuAction.scheduleWriteTest =>
          ScheduleTestType.written,
        LocalApplicationMenuAction.scheduleStreetTest =>
          ScheduleTestType.street,
        _ => null,
      };

      final result = await context.pushNamed<bool>(
        DRoutes.listTestAppointmentsScreen,
        extra: testType,
        queryParameters: {
          'localDrLiApplicationId': localApplicationId.toString(),
        },
      );
      return result ?? false;

    case LocalApplicationMenuAction.issueDLFirstTime:
      final result = await context.pushNamed<bool>(
        DRoutes.issueFirstLicenseScreen,
        queryParameters: {
          'localDrLiApplicationId': localApplicationId.toString(),
        },
      );
      return result ?? false;

    case LocalApplicationMenuAction.showLicense:
      final result = await context.pushNamed<bool>(
        DRoutes.showLicenseInfoScreen,
        queryParameters: {
          'localDrLiApplicationId': localApplicationId.toString(),
          'licenseId': 0.toString(),
        },
      );
      return result ?? false;

    case LocalApplicationMenuAction.showPersonLicenseHistory:
      await context.pushNamed(
        DRoutes.showPersonLicenseHistoryScreen,
        queryParameters: {'personId': personId.toString()},
      );
      return false;
  }
}
