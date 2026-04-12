import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> _listItems = ['Apple', 'Banana', 'Orange', 'Mango'];

    return Scaffold(
      appBar: AppBar(title: const Text('DropDown Widget')),
      body: Column(
        children: [
          DropdownButton<String>(
            isExpanded: true,
            items: const [
              DropdownMenuItem(value: 'option1', child: Text('Option 1')),
              DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              DropdownMenuItem(value: 'option3', child: Text('Option 3')),
            ],
            onChanged: (value) {
              // هنا يمكنك التعامل مع القيمة المختارة
              print('Selected: $value');
            },
            hint: const Text('Select an option'),
          ),
          DropdownButtonFormField(
            disabledHint: const Text('Disabled Dropdown'),
            hint: const Text('Select an option'),
            items: [
              const DropdownMenuItem(
                value: 'option1',
                enabled: false,
                child: Text('Option 1'),
              ),
              const DropdownMenuItem(value: 'option2', child: Text('Option 2')),
              const DropdownMenuItem(value: 'option3', child: Text('Option 3')),
            ],
            onChanged: (val) {},
          ),
          DropdownMenu(
            dropdownMenuEntries: [
              const DropdownMenuEntry(value: 'option1', label: 'Option 1'),
              const DropdownMenuEntry(value: 'option2', label: 'Option 2'),
              const DropdownMenuEntry(value: 'option3', label: 'Option 3'),
            ],
            onSelected: (value) {
              print('Selected: $value');
            },
          ),

          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              // إذا كان الحقل فارغاً، لا تظهر اقتراحات
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              // البحث داخل القائمة (توازي Suggest)
              return _listItems.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              // عند اختيار عنصر (توازي Append)
              print('You selected: $selection');
            },
          ),
          const DropdownMenuWidget(),
        ],
      ),
    );
  }
}

////////////////
///
class StudentModel {
  final String id;
  final String name;

  StudentModel({required this.id, required this.name});
}

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({super.key});

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  final TextEditingController controller = TextEditingController();

  List<StudentModel> data = [
    StudentModel(id: '1', name: "Akshay"),
    StudentModel(id: '2', name: 'Ram'),
    StudentModel(id: '3', name: 'Sham'),
  ];

  StudentModel? selectedStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownMenu<StudentModel>(
          controller: controller,
          enableFilter: true,
          enableSearch: false,
          label: const Text('Students'),
          dropdownMenuEntries: data.map((student) {
            return DropdownMenuEntry(value: student, label: student.name);
          }).toList(),
          onSelected: (student) {
            selectedStudent = student;
          },
        ),
        ElevatedButton(
          onPressed: () {
            // Reset both model and text controller
            setState(() {
              selectedStudent = null;
              controller.clear(); // Only clears the text
            });
          },
          child: const Text("Reset"),
        ),
      ],
    );
  }
}
