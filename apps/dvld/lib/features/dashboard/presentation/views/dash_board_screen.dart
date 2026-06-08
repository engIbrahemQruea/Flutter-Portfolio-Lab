// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({Key? key, required this.navigationShell})
    : super(key: key);

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      //  initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehicle Management System'),
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {
                // Handle settings action
              },
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Notifications',
              onPressed: () {
                // Handle settings action
              },
            ),
            IconButton(
              icon: const Icon(Icons.person_pin_rounded),
              tooltip: 'Profile',
              onPressed: () {
                // Handle settings action
              },
            ),
          ],
        ),
        body: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: NavigationRail(
                selectedIndex: navigationShell.currentIndex,
                scrollable: true,
                // useIndicator: true,
                indicatorShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                onDestinationSelected: _onTap,
                labelType: .all,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.dashboard),
                    selectedIcon: Icon(Icons.dashboard_customize),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.app_blocking),
                    selectedIcon: Icon(Icons.app_blocking),
                    label: Text('Applications'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.people),
                    selectedIcon: Icon(Icons.people),
                    label: Text('People'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.drive_eta_rounded),
                    selectedIcon: Icon(Icons.drive_eta_rounded),
                    label: Text('Drivers'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.person),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Users'),
                  ),
                ],
              ),
            ),
            const VerticalDivider(thickness: 2, width: 3),
            Expanded(child: navigationShell),
          ],
        ),
      ),
    );
  }
}
