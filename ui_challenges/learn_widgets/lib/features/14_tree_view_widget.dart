import 'package:flutter/material.dart';

// 1. الموديل الذي يمثل العقدة (Node)
class TreeNodeModel {
  String title;
  bool isChecked;
  List<TreeNodeModel> children;
  IconData icon;

  TreeNodeModel({
    required this.title,
    required this.icon,
    this.isChecked = false,
    this.children = const [],
  });

  // دالة الريكيرجن لتحديث الأبناء (توازي منطق C#)
  void setCheckRecursive(bool value) {
    isChecked = value;
    for (var child in children) {
      child.setCheckRecursive(value);
    }
  }
}

class TreeViewWidget extends StatefulWidget {
  const TreeViewWidget({super.key});

  @override
  State<TreeViewWidget> createState() => _TreeViewWidgetState();
}

class _TreeViewWidgetState extends State<TreeViewWidget> {
  // قائمة البيانات (Tree Data)
  List<TreeNodeModel> treeData = [
    TreeNodeModel(
      title: "Boys",
      icon: Icons.boy,
      children: [
        TreeNodeModel(title: "Ahmed", icon: Icons.boy),
        TreeNodeModel(title: "Ali", icon: Icons.boy),
      ],
    ),
    TreeNodeModel(
      title: "Girls",
      icon: Icons.girl,
      children: [
        TreeNodeModel(title: "Huda", icon: Icons.girl),
        TreeNodeModel(title: "Alia", icon: Icons.girl),
      ],
    ),
    TreeNodeModel(
      title: 'Parents',
      icon: Icons.bedroom_parent_sharp,
      children: [
        TreeNodeModel(title: "Father", icon: Icons.person),
        TreeNodeModel(title: "Mather", icon: Icons.person),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tree View (C# Logic in Flutter)'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: treeData.length,
        itemBuilder: (context, index) {
          // هنا نقوم ببناء كل شجرة (Boys ثم Girls)
          return _buildTree(treeData[index]);
        },
      ),
    );
  }

  // دالة بناء الشجرة بشكل ريكيرجن
  Widget _buildTree(TreeNodeModel node) {
    if (node.children.isEmpty) {
      return GestureDetector(
        onDoubleTap: () => _showDialog(node.title), // محاكاة MessageBox
        child: CheckboxListTile(
          title: Text(node.title),
          secondary: Icon(node.icon),
          value: node.isChecked,
          onChanged: (val) {
            setState(() => node.isChecked = val!);
          },
        ),
      );
    }

    return ExpansionTile(
      leading: Icon(node.icon),
      title: Row(
        children: [
          Checkbox(
            value: node.isChecked,
            onChanged: (val) {
              setState(() {
                node.setCheckRecursive(val!);
              });
            },
          ),
          GestureDetector(
            onDoubleTap: () => _showDialog(node.title),
            child: Text(
              node.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      // هنا السحر: الدالة تنادي نفسها لبناء الأبناء
      children: node.children.map((child) => _buildTree(child)).toList(),
    );
  }

  // دالة بسيطة لإظهار رسالة (توازي MessageBox في C#)
  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Node Selected"),
        content: Text("You double clicked on: $title"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
