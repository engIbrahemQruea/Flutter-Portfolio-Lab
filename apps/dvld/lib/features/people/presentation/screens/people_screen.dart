import 'package:dvld/core/routing/routes.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';
import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/screens/people_screen_widgets/custom_row_filter_widget.dart';
import 'package:dvld/features/people/presentation/screens/people_screen_widgets/people_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  void _showContextMenu(
    BuildContext context,
    DataGridCellTapDetails details,
    int selectedPersonId,
  ) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        details.globalPosition & const Size(0, 0), // Click point radius
        Offset.zero & overlay.size, // Overlay bounds
      ),
      items: const [
        PopupMenuItem(value: 'showInfo', child: Text('Show Info')),
        PopupMenuItem(value: 'add', child: Text('Add New Person')),
        PopupMenuItem(value: 'update', child: Text('Update')),
        PopupMenuItem(value: 'edit', child: Text('Edit')),
        PopupMenuItem(value: 'delete', child: Text('Delete')),
        PopupMenuItem(value: 'share', child: Text('Share')),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case 'add':
            context.pushNamed(DRoutes.addUpdatePeopleScreen);
            break;
          case 'update':
            {
              context.pushNamed(
                DRoutes.addUpdatePeopleScreen,
                queryParameters: {'personId': selectedPersonId.toString()},
                //'${DRoutes.addUpdatePeopleScreen}?personId=$selectedPersonId',
              );
            }
            break;
          case 'edit':
            return 'edit';
          case 'delete':
            return 'delete';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Manage People')),
      body: Column(
        children: [
          CustomRowFilterWidget(),
          SizedBox(height: 10),
          BlocBuilder<GetAllPeopleCubit, GetAllPeopleState>(
            builder: (context, state) {
              if (state is GetAllPeopleLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetAllPeopleSuccess) {
                final people = state.people;
                if (people == [] || people.isEmpty) {
                  return Center(child: Text("لا توجد نتائج تطابق بحثك"));
                }

                final PeopleDataSource peopleDataSource = PeopleDataSource(
                  people: people.whereType<PeopleEntity>().toList(),
                );

                return SfDataGrid(
                  source: peopleDataSource,
                  selectionMode: SelectionMode.single,
                  showCheckboxColumn: true,
                  onCheckboxValueChanged: (details) {},
                  onCellSecondaryTap: (details)  {
                    final rowIndex = details.rowColumnIndex.rowIndex;

                    if (rowIndex == 0) return;

                    final selectedPersonId = peopleDataSource
                        .dataGridRows[rowIndex - 1]
                        .getCells()[0]
                        .value;
                     _showContextMenu(context, details, selectedPersonId);
                  },
                  onCellLongPress: (details) => {},
                  // showPopupMenu(context, details.globalPosition),
                  allowSorting: true,
                  allowFiltering: true,
                  showColumnHeaderIconOnHover: true,
                  checkboxColumnSettings: DataGridCheckboxColumnSettings(
                    showCheckboxOnHeader: false,
                    backgroundColor: Colors.yellow,
                    label: Text('Select All'),
                  ),
                  columnWidthMode: ColumnWidthMode.auto,
                  columnWidthCalculationRange:
                      ColumnWidthCalculationRange.allRows,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  columns: [
                    GridColumn(
                      columnName: 'person_id',
                      // visible: false,
                      //width: 200,
                      filterPopupMenuOptions: FilterPopupMenuOptions(
                        filterMode: FilterMode.checkboxFilter,
                      ),

                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Person ID'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'national_no',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('National No'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'first_name',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'First Name',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'second_name',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Second Name'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'third_name ',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Third Name'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'last_name',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Last Name'),
                      ),
                    ),

                    GridColumn(
                      columnName: 'gender',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Gender'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'date_of_birth',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Date of Birth'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'email',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Email'),
                      ),
                    ),
                    GridColumn(
                      columnName: 'phone',
                      label: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text('Phone'),
                      ),
                    ),
                  ],
                );
                // } else {
                //   return Text('No Data');
                // }
              } else if (state is GetAllPeopleFailure) {
                return Text(state.errMessage);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
