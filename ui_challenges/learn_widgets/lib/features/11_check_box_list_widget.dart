import 'package:flutter/material.dart';

class CheckableItem {
  String name;
  bool isChecked;
  CheckableItem({required this.name, this.isChecked = false});
}

class CheckBoxListWidget extends StatefulWidget {
  const CheckBoxListWidget({super.key});

  @override
  State<CheckBoxListWidget> createState() => _CheckBoxListWidgetState();
}

class _CheckBoxListWidgetState extends State<CheckBoxListWidget> {
  Map<String, bool> hobbies = {
    "Programming": false,
    "Reading": false,
    "Gaming": false,
    "Sports": false,
  };

  List<CheckableItem> myItems = [];

  // --- العمليات (Logic) ---

  void addItems() {
    setState(() {
      for (int i = 1; i <= 5; i++) {
        myItems.add(CheckableItem(name: "Item $i"));
      }
    });
  }

  void checkAll(bool status) {
    setState(() {
      for (var item in myItems) {
        item.isChecked = status;
      }
    });
  }

  void removeAt(int index) {
    if (myItems.length > index) {
      setState(() {
        myItems.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CheckBox List Widget')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: hobbies.length,
              itemBuilder: (context, index) {
                String key = hobbies.keys.elementAt(index);
                return CheckboxListTile(
                  title: Text(key),
                  value: hobbies[key],
                  onChanged: (bool? value) {
                    setState(() {
                      hobbies[key] = value!;
                    });
                  },
                  activeColor: Colors.green, // لون الصح عند الاختيار
                  checkColor: Colors.white, // لون علامة الصح نفسها
                );
              },
            ),
          ),
          Expanded(
            child: myItems.isEmpty
                ? Center(child: Text("القائمة فارغة، أضف عناصر!"))
                : ListView.builder(
                    itemCount: myItems.length,
                    itemBuilder: (context, index) {
                      return CheckboxListTile(
                        title: Text(myItems[index].name),
                        value: myItems[index].isChecked,
                        onChanged: (bool? val) {
                          setState(() => myItems[index].isChecked = val!);
                        },
                      );
                    },
                  ),
          ),

          // منطقة الأزرار (توازي أزرار المدرب)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(onPressed: addItems, child: Text("Add Items")),
                ElevatedButton(
                  onPressed: () => checkAll(true),
                  child: Text("Check All"),
                ),
                ElevatedButton(
                  onPressed: () => checkAll(false),
                  child: Text("Uncheck All"),
                ),
                ElevatedButton(
                  onPressed: () => removeAt(4),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                  ),
                  child: Text("Remove 3rd"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
