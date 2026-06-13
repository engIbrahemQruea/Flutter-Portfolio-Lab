import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:dvld/features/people/presentation/screens/people_screen_widgets/people_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PeopleScreen extends StatelessWidget {
  const PeopleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage People')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              ElevatedButton(onPressed: () {}, child: Text('Filter')),
              ElevatedButton(onPressed: () {}, child: Text('Add Person')),
            ],
          ),
          BlocBuilder<GetAllPeopleCubit, GetAllPeopleState>(
            builder: (context, state) {
              if (state is GetAllPeopleLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is GetAllPeopleSuccess) {
                final people = state.people;
                final PeopleDataSource peopleDataSource = PeopleDataSource(
                  people: people,
                );

                return SfDataGrid(
                  source: peopleDataSource,
                  selectionMode: SelectionMode.single,
                  
                  columns: [
                    GridColumn(
                      columnName: 'person_id',
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
