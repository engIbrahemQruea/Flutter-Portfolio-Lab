import 'package:dvld/core/helpers/app_dialogs.dart';
import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/manage_users/presentation/helpers/user_data_source.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/add_update_users_screen/helpers/enum_user_menu_action.dart';
import 'package:dvld/features/manage_users/presentation/screens/widgets/filter_users_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  Future<EnUserMenuAction?> _showContextMenu(
    BuildContext context,
    DataGridCellTapDetails details,
    int selectedUserId,
  ) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromLTWH(details.globalPosition.dx, details.globalPosition.dy, 1, 1),
      Offset.zero & overlay.size,
    );

    final selectedAction = await showMenu<EnUserMenuAction>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 14,
      menuPadding: const EdgeInsets.all(8),
      items: [
        _buildMenuItem(
          EnUserMenuAction.showDetails,
          Icons.person_search_outlined,
          Colors.blue,
        ),
        const PopupMenuDivider(height: 2),
        _buildMenuItem(
          EnUserMenuAction.add,
          Icons.person_add_alt_1_outlined,
          Colors.green,
        ),
        _buildMenuItem(
          EnUserMenuAction.edit,
          Icons.edit_outlined,
          Colors.orange,
        ),
        _buildMenuItem(
          EnUserMenuAction.delete,
          Icons.delete_outline_rounded,
          Colors.red,
        ),
        _buildMenuItem(
          EnUserMenuAction.changePassword,
          Icons.lock_outline_rounded,
          Colors.purple,
        ),
        const PopupMenuDivider(height: 2),
        _buildMenuItem(
          EnUserMenuAction.sendEmail,
          Icons.mail_outline_rounded,
          Colors.indigo,
        ),
        _buildMenuItem(
          EnUserMenuAction.phoneCall,
          Icons.phone_enabled_outlined,
          Colors.teal,
        ),
      ],
    );

    if (selectedAction == null || !context.mounted) return null;

    return _handleMenuAction(context, selectedAction, selectedUserId);
  }

  PopupMenuItem<EnUserMenuAction> _buildMenuItem(
    EnUserMenuAction action,
    IconData icon,
    Color color,
  ) {
    return PopupMenuItem(
      value: action,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(action.label),
        ],
      ),
    );
  }

  Future<EnUserMenuAction?> _handleMenuAction(
    BuildContext context,
    EnUserMenuAction action,
    int userId,
  ) async {
    bool isOperationSuccess = false;

    switch (action) {
      case EnUserMenuAction.add:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdateUsersScreen,
        );
        isOperationSuccess = result ?? false;

      case EnUserMenuAction.edit:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdateUsersScreen,
          queryParameters: {'userId': userId.toString()},
        );
        isOperationSuccess = result ?? false;

      case EnUserMenuAction.delete:
        final confirmAction = await AppDialogs.showConfirmation(
          context: context,
          title: 'Delete User',
          confirmColor: Colors.red,
          icon: const Icon(Icons.delete_forever_rounded, color: Colors.red),
          confirmText: 'Delete',
          cancelText: 'Cancel',
          message: 'Are you sure you want to delete this user?',
        );

        if (confirmAction == true && context.mounted) {
          await context.read<ManageUsersCubit>().deleteUser(userID: userId);
          if (!context.mounted) return null;
          await AppDialogs.showSuccess(
            context: context,
            title: "Success",
            buttonText: "OK",
            message: 'Deleted User Successfully',
          );
          isOperationSuccess = true;
        }

      case EnUserMenuAction.showDetails:
        final result = await context.pushNamed<bool>(
          DRoutes.showDetailsUserScreen,
          queryParameters: {'userId': userId.toString()},
        );
        isOperationSuccess = result ?? false;

      case EnUserMenuAction.changePassword:
        final result = await context.pushNamed<bool>(
          DRoutes.changePasswordUserScreen,
          queryParameters: {'userId': userId.toString()},
        );
        isOperationSuccess = result ?? false;

      case EnUserMenuAction.sendEmail:
      case EnUserMenuAction.phoneCall:
        break;
    }

    return isOperationSuccess ? action : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(20),
            const FilterUsersBy(),
            verticalSpace(20),
            Expanded(
              child: BlocBuilder<ManageUsersCubit, ManageUsersCubitState>(
                buildWhen: (previous, current) =>
                    previous.users != current.users ||
                    previous.filteredUsers != current.filteredUsers ||
                    previous.selectedFilterOption !=
                        current.selectedFilterOption ||
                    previous.usersStatus != current.usersStatus,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.isFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage ?? 'Something went wrong',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state.isSuccess) {
                    final users = state.isFilterByIsActive
                        ? state.filteredUsers
                        : state.users;

                    if (users.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Users Found 😔',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return SfDataGrid(
                      source: UserDataSource(users: users),
                      selectionMode: SelectionMode.single,
                      allowSorting: true,
                      allowFiltering: true,
                      showColumnHeaderIconOnHover: true,
                      columnWidthMode: ColumnWidthMode.auto,
                      columnWidthCalculationRange:
                          ColumnWidthCalculationRange.allRows,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      footer: Center(
                        child: Text(
                          'Total Users: ${users.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      onCellSecondaryTap: (details) async {
                        final rowIndex = details.rowColumnIndex.rowIndex;
                        if (rowIndex <= 0 || rowIndex > users.length) return;

                        final selectedUserId = users[rowIndex - 1].userID;

                        final action = await _showContextMenu(
                          context,
                          details,
                          selectedUserId!,
                        );

                        if (context.mounted && action != null) {
                          context.read<ManageUsersCubit>().getAllUsers();
                        }
                      },
                      columns: _buildGridColumns(),
                    );
                  }

                  return const Center(child: Text('No Data Found'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    const columnMap = {
      'user_id': 'User ID',
      'person_id': 'Person ID',
      'user_name': 'User Name',
      'password': 'Password',
      'is_active': 'Is Active',
    };

    return [
      for (final MapEntry(:key, :value) in columnMap.entries)
        GridColumn(
          columnName: key,
          label: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
    ];
  }
}
