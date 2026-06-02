// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced/022_responsive/animations/animations.dart';
import 'package:advanced/022_responsive/transitions/nav_rail_transition.dart';
import 'package:advanced/022_responsive/models/destinations.dart';
import 'package:advanced/022_responsive/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';

class DisappearingNavigationRail extends StatelessWidget {
  const DisappearingNavigationRail({
    Key? key,
    required this.railAnimation,
    required this.railFabAnimation,
    required this.backgroundColor,
    required this.selectedIndex,
    this.onDestinationSelected,
  }) : super(key: key);

  final RailAnimation railAnimation; // Add this variable
  final RailFabAnimation railFabAnimation; // Add this variable
  final Color backgroundColor;
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavRailTransition(
      animation: railAnimation,
      backgroundColor: backgroundColor,
      child: NavigationRail(
        selectedIndex: selectedIndex,
        backgroundColor: backgroundColor,
        onDestinationSelected: onDestinationSelected,
        leading: Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            const SizedBox(height: 8),
            AnimatedFloatingActionButton(
              animation: railFabAnimation,
              elevation: 0,
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ],
        ),
        groupAlignment: -0.85,
        destinations: destinations.map((d) {
          return NavigationRailDestination(
            icon: Icon(d.icon),
            label: Text(d.label),
          );
        }).toList(),
      ),
    );
  }
}
