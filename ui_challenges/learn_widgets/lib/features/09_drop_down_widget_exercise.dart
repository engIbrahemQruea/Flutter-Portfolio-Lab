import 'package:flutter/material.dart';
import 'package:learn_widgets/core/constans.dart';
import 'package:learn_widgets/core/drop_down_provider.dart';
import 'package:provider/provider.dart';

class DropDownWidgetExercise extends StatelessWidget {
  const DropDownWidgetExercise({super.key});

  @override
  Widget build(BuildContext context) {
    var dropDownProvider = Provider.of<DropDownProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('DropDown Widget Exercise')),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            dropDownProvider.imageTitle,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(dropDownProvider.selectedImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
          DropdownMenu(
            width: 200,
            hintText: 'Select Image',
            dropdownMenuEntries: dropDownProvider.dropDownData.keys.map((path) {
              return DropdownMenuEntry(
                value: path,
                label: dropDownProvider.dropDownData[path]!,
              );
            }).toList(),
            onSelected: (value) => dropDownProvider.setSelectedImage(value),
          ),
        ],
      ),
    );
  }
}
