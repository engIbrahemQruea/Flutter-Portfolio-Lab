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
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromLTWH(details.globalPosition.dx, details.globalPosition.dy, 1, 1),
      Offset.zero & overlay.size,
    );

    final EnUserMenuAction? selectedAction = await showMenu<EnUserMenuAction>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 14,
      menuPadding: const EdgeInsets.all(8),
      items: [
        PopupMenuItem(
          value: EnUserMenuAction.showDetails,
          child: Row(
            children: [
              Icon(Icons.person_search_outlined, size: 20, color: Colors.blue),
              SizedBox(width: 12),
              Text(EnUserMenuAction.showDetails.label),
            ],
          ),
        ),
        PopupMenuDivider(height: 2),

        PopupMenuItem(
          value: EnUserMenuAction.add,
          child: Row(
            children: [
              Icon(
                Icons.person_add_alt_1_outlined,
                size: 20,
                color: Colors.green,
              ),
              SizedBox(width: 12),
              Text(EnUserMenuAction.add.label),
            ],
          ),
        ),
        PopupMenuItem(
          value: EnUserMenuAction.edit,
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20, color: Colors.orange),
              SizedBox(width: 12),
              Text(EnUserMenuAction.edit.label),
            ],
          ),
        ),
        PopupMenuItem(
          value: EnUserMenuAction.delete,
          child: Row(
            children: [
              Icon(Icons.delete_outline_rounded, size: 20, color: Colors.red),
              SizedBox(width: 12),
              Text(EnUserMenuAction.delete.label),
            ],
          ),
        ),
        PopupMenuItem(
          value: EnUserMenuAction.changePassword,
          child: Row(
            children: [
              Icon(Icons.lock_outline_rounded, size: 20, color: Colors.purple),
              SizedBox(width: 12),
              Text(EnUserMenuAction.changePassword.label),
            ],
          ),
        ),

        PopupMenuDivider(height: 2),

        PopupMenuItem(
          value: EnUserMenuAction.sendEmail,
          child: Row(
            children: [
              Icon(Icons.mail_outline_rounded, size: 20, color: Colors.indigo),
              SizedBox(width: 12),
              Text(EnUserMenuAction.sendEmail.label),
            ],
          ),
        ),
        PopupMenuItem(
          value: EnUserMenuAction.phoneCall,
          child: Row(
            children: [
              Icon(Icons.phone_enabled_outlined, size: 20, color: Colors.teal),
              SizedBox(width: 12),
              Text(EnUserMenuAction.phoneCall.label),
            ],
          ),
        ),
      ],
    );

    if (selectedAction == null || !context.mounted) return null;

    bool isOperationSuccess = false;

    switch (selectedAction) {
      case EnUserMenuAction.add:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdateUsersScreen,
        );
        isOperationSuccess = result ?? false;
        break;

      case EnUserMenuAction.edit:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdateUsersScreen,
          queryParameters: {'userId': selectedUserId.toString()},
        );
        isOperationSuccess = result ?? false;
        break;

      case EnUserMenuAction.delete:
        // await context.read<GetAllPeopleCubit>().deletePeople(
        //   personID: selectedPersonId,
        // );
        // isOperationSuccess = true;
        break;

      case EnUserMenuAction.showDetails:
        final result = await context.pushNamed<bool>(
          DRoutes.showDetailsUserScreen,
          queryParameters: {'userId': selectedUserId.toString()},
        );
        isOperationSuccess = result ?? false;
        break;

      case EnUserMenuAction.changePassword:
        // Handle change password action
        break;

      case EnUserMenuAction.sendEmail:
        // Handle send email action
        break;

      case EnUserMenuAction.phoneCall:
        // Handle phone call action
        break;
    }

    if (!isOperationSuccess) return null;
    return selectedAction;
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
            FilterUsersBy(),
            verticalSpace(20),
            BlocBuilder<ManageUsersCubit, ManageUsersCubitState>(
              buildWhen: (previous, current) =>
                  previous.users != current.users ||
                  previous.usersStatus != current.usersStatus,
              builder: (context, state) {
                if (state.usersStatus == EnManageUsersStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.usersStatus == EnManageUsersStatus.failure) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? 'Something went wrong',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state.usersStatus == EnManageUsersStatus.success) {
                  final users = state.users;
                  if (users == null || users.isEmpty) {
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
                    source: UserDataSource(users: users!),
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
                        'Total Users: ${state.users!.length} ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    onCellSecondaryTap: (details) async {
                      final rowIndex = details.rowColumnIndex.rowIndex;
                      if (rowIndex == 0) return;

                      final selectedUserId = UserDataSource(
                        users: users,
                      ).dataGridRows[rowIndex - 1].getCells()[0].value;

                      final action = await _showContextMenu(
                        context,
                        details,
                        selectedUserId,
                      );

                      if (context.mounted && action != null) {
                        context.read<ManageUsersCubit>().getAllUsers();
                      }
                    },
                    columns: _buildGridColumns(),
                  );
                }
                return const Center(child: Text('No Data FFFound'));
              },
            ),
          ],
        ),
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    final Map<String, String> columnMap = {
      'user_id': 'User ID',
      'person_id': 'Person ID',
      'user_name': 'User Name',
      'password': 'Password',
      'is_active': 'Is Active',
    };

    return columnMap.entries.map((entry) {
      return GridColumn(
        columnName: entry.key,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(entry.value, overflow: TextOverflow.ellipsis),
        ),
      );
    }).toList();
  }
}
