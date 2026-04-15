import 'package:flutter/material.dart';

class Person {
  final String id;
  final String name;
  final bool isMale;

  Person({required this.id, required this.name, required this.isMale});
}

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({super.key});

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  final List<Person> _people = []; // قائمة البيانات
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isMale = true; // توازي RadioButtons

  // 1. دالة الإضافة (توازي btnAdd_Click)
  void _addPerson() {
    if (_idController.text.isEmpty || _nameController.text.isEmpty) return;

    setState(() {
      _people.add(
        Person(
          id: _idController.text,
          name: _nameController.text,
          isMale: _isMale,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Added ${_nameController.text} Succefully')),
      );
    });

    // تنظيف الحقول والتركيز (توازي txtID.Clear و Focus)
    _idController.clear();
    _nameController.clear();
  }

  // 2. دالة التعبئة العشوائية (توازي btnFillrandom_Click)
  void _fillRandom() {
    setState(() {
      for (int i = 1; i <= 5; i++) {
        _people.add(Person(id: "10$i", name: "User $i", isMale: i % 2 == 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView Manager")),
      body: Column(
        children: [
          DataTable(
            showBottomBorder: true,
            dividerThickness: 2,
            dataRowHeight: 50,
            headingRowHeight: 50,
            headingTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headingRowColor: MaterialStateProperty.resolveWith(
              (states) => Colors.black,
            ),
            border: TableBorder(borderRadius: BorderRadius.circular(10)),
          
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
            ],
            rows: [
              DataRow(cells: [DataCell(Text('1')), DataCell(Text('Ibrahem'))]),
            ],
          ),
          // جزء الإدخال (توازي الجزء العلوي في Form)
          _buildInputSection(),

          Divider(),

          // جزء القائمة (توازي listView1)
          Expanded(
            child: ListView.builder(
              itemCount: _people.length,
              itemBuilder: (context, index) {
                final person = _people[index];
                return ListTile(
                  leading: Icon(
                    person.isMale
                        ? Icons.face
                        : Icons.face_3, // يوازي ImageIndex
                    color: person.isMale ? Colors.blue : Colors.pink,
                  ),
                  title: Text(person.name),
                  subtitle: Text("ID: ${person.id}"),
                  onLongPress: () {
                    // يوازي btmRemove_Click (الحذف عند الضغط المطول)
                    setState(() {
                      _people.removeAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed ${person.name} Succefully'),
                        ),
                      );
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _idController,
            decoration: InputDecoration(labelText: "ID"),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: _isMale,
                onChanged: (v) => setState(() => _isMale = v!),
              ),
              Text("Male"),
              Radio(
                value: false,
                groupValue: _isMale,
                onChanged: (v) => setState(() => _isMale = v!),
              ),
              Text("Female"),
              Spacer(),
              ElevatedButton(onPressed: _addPerson, child: Text("Add")),
              SizedBox(width: 5),
              ElevatedButton(onPressed: _fillRandom, child: Text("Random")),
            ],
          ),
        ],
      ),
    );
  }
}
