import 'package:dvld/features/manage_application/test_types/ui/logic/test_types_screen_cubit/test_types_screen_cubit.dart';
import 'package:dvld/features/manage_application/test_types/ui/widgets/test_types_screen_widgets/test_types_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TestTypesScreen extends StatelessWidget {
  const TestTypesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Types'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<TestTypesScreenCubit, TestTypesScreenCubitState>(
                buildWhen: (previous, current) =>
                    previous is TestTypesScreenCubitFailure !=
                        current is TestTypesScreenCubitFailure ||
                    previous is TestTypesScreenCubitSuccess !=
                        current is TestTypesScreenCubitSuccess ||
                    previous is TestTypesScreenCubitLoading !=
                        current is TestTypesScreenCubitLoading,
                builder: (context, state) {
                  if (state is TestTypesScreenCubitLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is TestTypesScreenCubitFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is TestTypesScreenCubitSuccess) {
                    final testTypes = state.testTypesList;

                    if (testTypes.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Application Types Found 😔',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    return SfDataGrid(
                      source: TestTypesDataSource(testTypes: testTypes),
                      selectionMode: SelectionMode.single,
                      allowSorting: true,
                      allowColumnsResizing: true,
                      allowFiltering: true,
                      showColumnHeaderIconOnHover: true,
                      columnWidthMode: ColumnWidthMode.fitByColumnName,
                      columnWidthCalculationRange:
                          ColumnWidthCalculationRange.visibleRows,
                      gridLinesVisibility: GridLinesVisibility.both,
                      headerGridLinesVisibility: GridLinesVisibility.both,
                      footer: Center(
                        child: Text(
                          'Total Records: ${testTypes.length}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      onCellSecondaryTap: (details) async {
                        final rowIndex = details.rowColumnIndex.rowIndex;
                        if (rowIndex <= 0 || rowIndex > testTypes.length) {
                          return;
                        }

                        final selectedAppTypeId =
                            testTypes[rowIndex - 1].testTypeId;

                        // final action = await _showContextMenu(
                        //   context,
                        //   details,
                        //   selectedAppTypeId!,
                        // );

                        // if (context.mounted && action != null) {
                        //   //  context.read<ManageUsersCubit>().getAllUsers();
                        // }
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
      'test_type_id': 'App Type ID',
      'test_type_title': ' Title',
      'test_type_description': ' Description',
      'test_type_fee': ' Fee',
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
