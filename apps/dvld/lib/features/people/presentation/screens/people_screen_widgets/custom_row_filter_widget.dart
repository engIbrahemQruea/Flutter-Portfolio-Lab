import 'dart:async';

import 'package:dvld/features/people/presentation/logic/cubit/get_all_people_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomRowFilterWidget extends StatefulWidget {
  const CustomRowFilterWidget({super.key});

  @override
  State<CustomRowFilterWidget> createState() => _CustomRowFilterWidgetState();
}

class _CustomRowFilterWidgetState extends State<CustomRowFilterWidget> {
  final TextEditingController searchController = TextEditingController();
  static const List<String> filterOptions = [
    'none',
    'PersonID',
    'NationalNo',
    'FirstName',
  ];
  String selectedFilterOption = 'none';

  bool get isEnabled => selectedFilterOption == 'none' ? false : true;

  Timer? _debounceTimer;
  TextInputType get keyboardType => switch (selectedFilterOption) {
    'PersonID' => TextInputType.numberWithOptions(decimal: true),
    'NationalNo' => TextInputType.multiline,
    'FirstName' => TextInputType.text,
    _ => TextInputType.none,
  };

  TextInputFormatter get customInputFormatters =>
      switch (selectedFilterOption) {
        'PersonID' => FilteringTextInputFormatter.digitsOnly,
        'NationalNo' => FilteringTextInputFormatter.singleLineFormatter,
        'FirstName' => FilteringTextInputFormatter.allow(
          RegExp(r'^[a-zA-Z ]+$'),
        ),
        _ => FilteringTextInputFormatter.singleLineFormatter,
      };

  void _onSearchChanged(BuildContext context, String text) {
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      switch (selectedFilterOption) {
        case 'FirstName':
          context.read<GetAllPeopleCubit>().getPeopleByFirstName(
            firstName: text,
          );
          break;
        case 'PersonID':
          final id = int.tryParse(text);
          if (id != null) {
            context.read<GetAllPeopleCubit>().getPeopleById(personID: id);
          }
          break;
        case 'NationalNo':
          context.read<GetAllPeopleCubit>().getPeopleByNationalNo(
            nationalNo: text,
          );
          break;
        case 'none':
          context.read<GetAllPeopleCubit>().getAllPeople();
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounceTimer?.cancel();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //  mainAxisAlignment: .spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('Filter By: '),
        SizedBox(width: 10),
        DropdownButton<String>(
          value: selectedFilterOption,
          mouseCursor: WidgetStateMouseCursor.clickable,
          dropdownMenuItemMouseCursor: WidgetStateMouseCursor.clickable,
          items: filterOptions.map((String option) {
            return DropdownMenuItem<String>(value: option, child: Text(option));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedFilterOption = newValue!;
            });
            _onSearchChanged(context, searchController.text.trim());
          },
        ),
        SizedBox(width: 10),
        isEnabled == true
            ? SizedBox(
                width: 200,
                child: TextField(
                  controller: searchController,
                  enabled: isEnabled,
                  keyboardType: keyboardType,
                  inputFormatters: [customInputFormatters],
                  decoration: InputDecoration(
                    labelText: "Search $selectedFilterOption",
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        searchController.clear();

                        // context.read<GetAllPeopleCubit>().getAllPeople();
                      },
                    ),
                  ),

                  onChanged: (text) {
                    _onSearchChanged(context, text);
                  },
                ),
              )
            : SizedBox.shrink(),
      ],
    );
  }
}
