import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/screens/people_screen_widgets/custom_row_filter_widget.dart';
import 'package:dvld/features/people/presentation/screens/people_screen_widgets/people_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

enum PersonMenuAction { showDetails, add, edit, delete, sendEmail, phoneCall }

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  Future<PersonMenuAction?> _showContextMenu(
    BuildContext context,
    DataGridCellTapDetails details,
    int selectedPersonId,
  ) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromLTWH(details.globalPosition.dx, details.globalPosition.dy, 1, 1),
      Offset.zero & overlay.size,
    );

    final PersonMenuAction? selectedAction = await showMenu<PersonMenuAction>(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 14,
      menuPadding: const EdgeInsets.all(8),
      items: const [
        PopupMenuItem(
          value: PersonMenuAction.showDetails,
          child: Row(
            children: const [
              Icon(Icons.person_search_outlined, size: 20, color: Colors.blue),
              SizedBox(width: 12),
              Text('Show Details'),
            ],
          ),
        ),
        PopupMenuDivider(height: 2),

        PopupMenuItem(
          value: PersonMenuAction.add,
          child: Row(
            children: const [
              Icon(
                Icons.person_add_alt_1_outlined,
                size: 20,
                color: Colors.green,
              ),
              SizedBox(width: 12),
              Text('Add New Person'),
            ],
          ),
        ),
        PopupMenuItem(
          value: PersonMenuAction.edit,
          child: Row(
            children: [
              Icon(Icons.edit_outlined, size: 20, color: Colors.orange),
              SizedBox(width: 12),
              Text('Edit'),
            ],
          ),
        ),
        PopupMenuItem(
          value: PersonMenuAction.delete,
          child: Row(
            children: [
              Icon(Icons.delete_outline_rounded, size: 20, color: Colors.red),
              SizedBox(width: 12),
              Text('Delete'),
            ],
          ),
        ),

        PopupMenuDivider(height: 2),

        PopupMenuItem(
          value: PersonMenuAction.sendEmail,
          child: Row(
            children: [
              Icon(Icons.mail_outline_rounded, size: 20, color: Colors.indigo),
              SizedBox(width: 12),
              Text('Send Email'),
            ],
          ),
        ),
        PopupMenuItem(
          value: PersonMenuAction.phoneCall,
          child: Row(
            children: [
              Icon(Icons.phone_enabled_outlined, size: 20, color: Colors.teal),
              SizedBox(width: 12),
              Text('Phone Call'),
            ],
          ),
        ),
      ],
    );

    if (selectedAction == null || !context.mounted) return null;

    bool isOperationSuccess = false;

    switch (selectedAction) {
      case PersonMenuAction.add:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdatePeopleScreen,
        );
        isOperationSuccess = result ?? false;
        break;

      case PersonMenuAction.edit:
        final result = await context.pushNamed<bool>(
          DRoutes.addUpdatePeopleScreen,
          queryParameters: {'personId': selectedPersonId.toString()},
        );
        isOperationSuccess = result ?? false;
        break;

      case PersonMenuAction.delete:
        await context.read<GetAllPeopleCubit>().deletePeople(
          personID: selectedPersonId,
        );
        isOperationSuccess = true;
        break;

      default:
        break;
    }

    if (!isOperationSuccess) return null;
    return selectedAction;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Manage People')),
      body: Column(
        children: [
          const CustomRowFilterWidget(),
          const SizedBox(height: 10),
          Expanded(
            child: BlocBuilder<GetAllPeopleCubit, GetAllPeopleState>(
              builder: (context, state) {
                if (state is GetAllPeopleLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is GetAllPeopleSuccess) {
                  final people = state.people;

                  if (people.isEmpty) {
                    return const Center(
                      child: Text("لا توجد نتائج تطابق بحثك"),
                    );
                  }

                  final List<PeopleEntity> filteredPeople = people
                      .whereType<PeopleEntity>()
                      .toList();
                  final PeopleDataSource peopleDataSource = PeopleDataSource(
                    people: filteredPeople,
                  );

                  return SfDataGrid(
                    source: peopleDataSource,
                    selectionMode: SelectionMode.single,
                    showCheckboxColumn: true,
                    onCheckboxValueChanged: (details) {},
                    onCellSecondaryTap: (details) async {
                      final rowIndex = details.rowColumnIndex.rowIndex;
                      if (rowIndex == 0) return;

                      final selectedPersonId = peopleDataSource
                          .dataGridRows[rowIndex - 1]
                          .getCells()[0]
                          .value;

                      final action = await _showContextMenu(
                        context,
                        details,
                        selectedPersonId,
                      );

                      if (context.mounted && action != null) {
                        context.read<GetAllPeopleCubit>().getAllPeople();
                      }
                    },
                    allowSorting: true,
                    allowFiltering: true,
                    showColumnHeaderIconOnHover: true,
                    checkboxColumnSettings:
                        const DataGridCheckboxColumnSettings(
                          showCheckboxOnHeader: false,
                          backgroundColor: Colors.yellow,
                          label: Text('Select All'),
                        ),
                    columnWidthMode: ColumnWidthMode.auto,
                    columnWidthCalculationRange:
                        ColumnWidthCalculationRange.allRows,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columns: _buildGridColumns(),
                  );
                }

                if (state is GetAllPeopleFailure) {
                  return Center(child: Text(state.errMessage));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  List<GridColumn> _buildGridColumns() {
    final Map<String, String> columnMap = {
      'person_id': 'Person ID',
      'national_no': 'National No',
      'first_name': 'First Name',
      'second_name': 'Second Name',
      'third_name': 'Third Name',
      'last_name': 'Last Name',
      'gender': 'Gender',
      'date_of_birth': 'Date of Birth',
      'email': 'Email',
      'phone': 'Phone',
    };

    return columnMap.entries.map((entry) {
      return GridColumn(
        columnName: entry.key,
        filterPopupMenuOptions: entry.key == 'person_id'
            ? const FilterPopupMenuOptions(
                filterMode: FilterMode.checkboxFilter,
              )
            : null,
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          child: Text(entry.value, overflow: TextOverflow.ellipsis),
        ),
      );
    }).toList();
  }
}
