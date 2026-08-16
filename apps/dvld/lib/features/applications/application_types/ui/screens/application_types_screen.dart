import 'package:dvld/core/routing/routing.dart';
import 'package:dvld/features/applications/application_types/ui/logic/application_types_screen_cubit/application_types_screen_cubit.dart';
import 'package:dvld/features/applications/application_types/ui/widgets/application_types_screen_widgets/application_types_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum ApplicationTypesMenuAction {
  edit('Edit');

  final String label;
  const ApplicationTypesMenuAction(this.label);
}

class ApplicationTypesScreen extends StatelessWidget {
  const ApplicationTypesScreen({super.key});

  Future<ApplicationTypesMenuAction?> _showContextMenu(
    BuildContext context,
    DataGridCellTapDetails details,
    int selectedAppTypesId,
  ) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final position = RelativeRect.fromRect(
      Rect.fromLTWH(details.globalPosition.dx, details.globalPosition.dy, 1, 1),
      Offset.zero & overlay.size,
    );

    final selectedAction = await showMenu<ApplicationTypesMenuAction>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 14,
      menuPadding: const EdgeInsets.all(8),
      items: [
        _buildMenuItem(
          ApplicationTypesMenuAction.edit,
          Icons.edit_outlined,
          Colors.blue,
        ),
      ],
    );

    if (selectedAction == null || !context.mounted) return null;

    return _handleMenuAction(context, selectedAction, selectedAppTypesId);
  }

  PopupMenuItem<ApplicationTypesMenuAction> _buildMenuItem(
    ApplicationTypesMenuAction action,
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

  Future<ApplicationTypesMenuAction?> _handleMenuAction(
    BuildContext context,
    ApplicationTypesMenuAction action,
    int appTypeId,
  ) async {
    bool isOperationSuccess = false;

    switch (action) {
      case ApplicationTypesMenuAction.edit:
        final result = await context.pushNamed<bool>(
          DRoutes.updateApplicationTypes,
          queryParameters: {'appTypeId': appTypeId.toString()},
        );
        isOperationSuccess = result ?? false;
    }

    return isOperationSuccess ? action : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Types Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child:
                  BlocBuilder<
                    ApplicationTypesScreenCubit,
                    ApplicationTypesScreenCubitState
                  >(
                    buildWhen: (previous, current) =>
                        previous is ApplicationTypesScreenCubitFailure !=
                            current is ApplicationTypesScreenCubitFailure ||
                        previous is ApplicationTypesScreenCubitSuccess !=
                            current is ApplicationTypesScreenCubitSuccess ||
                        previous is ApplicationTypesScreenCubitLoading !=
                            current is ApplicationTypesScreenCubitLoading,
                    builder: (context, state) {
                      if (state is ApplicationTypesScreenCubitLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is ApplicationTypesScreenCubitFailure) {
                        return Center(
                          child: Text(
                            state.errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (state is ApplicationTypesScreenCubitSuccess) {
                        final appTypes = state.applicationTypesList;

                        if (appTypes.isEmpty) {
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
                          source: ApplicationTypesDataSource(
                            appTypes: appTypes,
                          ),
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
                              'Total Records: ${appTypes.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          onCellSecondaryTap: (details) async {
                            final rowIndex = details.rowColumnIndex.rowIndex;
                            if (rowIndex <= 0 || rowIndex > appTypes.length) {
                              return;
                            }

                            final selectedAppTypeId =
                                appTypes[rowIndex - 1].applicationTypeId;

                            final action = await _showContextMenu(
                              context,
                              details,
                              selectedAppTypeId!,
                            );

                            if (context.mounted && action != null) {
                              //  context.read<ManageUsersCubit>().getAllUsers();
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
      'app_type_id': 'App Type ID',
      'app_type_title': ' Title',
      'app_type_fee': ' Fee',
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
