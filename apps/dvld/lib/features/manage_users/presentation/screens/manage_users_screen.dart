import 'package:dvld/core/helpers/spacing.dart';
import 'package:dvld/features/manage_users/presentation/helpers/user_data_source.dart';
import 'package:dvld/features/manage_users/presentation/logic/cubit/manage_users_cubit.dart';
import 'package:dvld/features/manage_users/presentation/screens/widgets/filter_users_by.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

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
              // buildWhen: (previous, current) =>
              //     previous.users != current.users ||
              //     previous.usersStatus != current.usersStatus ||
              //     previous.selectedFilterOption != current.selectedFilterOption,
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
