import 'package:flutter/material.dart';

class ContainersTabBar extends StatelessWidget {
  const ContainersTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // عدد التبويبات (توازي عدد الـ TabPages)
      child: Scaffold(
        appBar: AppBar(
          title: Text("Yummy Tabs"),
          // الـ TabBar يوضع عادة في الـ bottom الخاص بالـ AppBar
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.fastfood), text: "Meals"),
              Tab(icon: Icon(Icons.shopping_cart), text: "Orders"),
              Tab(icon: Icon(Icons.settings), text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // كل ويدجت هنا تمثل محتوى TabPage كاملة
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
                Text("List of Meals here"),
              ],
            ),
            Center(child: Text("Your Orders history")),
            Center(child: Text("App Settings")),
          ],
        ),
      ),
    );
  }
}
