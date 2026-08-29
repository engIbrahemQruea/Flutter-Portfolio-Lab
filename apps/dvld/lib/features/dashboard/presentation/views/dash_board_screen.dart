// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dvld/core/routing/routing.dart';
import 'package:flutter/material.dart';

// ============================================================
// MODELS
// ============================================================
class SubMenuItem {
  final String title;
  final IconData icon;
  final String? route;
  final List<SubMenuItem>? children;

  const SubMenuItem({
    required this.title,
    required this.icon,
    this.route,
    this.children,
  });
}

// ============================================================
// DATA
// ============================================================
final List<SubMenuItem> applicationsSubMenu = [
  const SubMenuItem(
    title: 'Driving Licenses Services',
    icon: Icons.badge_outlined,
    children: [
      SubMenuItem(
        title: 'New Driving License',
        icon: Icons.add_circle_outline,
        children: [
          SubMenuItem(
            title: 'Local License',
            icon: Icons.circle,
            route: DRoutes.addUpdateLocalDrLiApplicationsScreen,
          ),
          SubMenuItem(
            title: 'International License',
            icon: Icons.circle,
            route: '/applications/new-international',
          ),
        ],
      ),
      SubMenuItem(
        title: 'Renew Driving License',
        icon: Icons.autorenew,
        route: '/applications/renew',
      ),
      SubMenuItem(
        title: 'Replacement for Lost/Damaged',
        icon: Icons.find_replace,
        route: '/applications/replacement',
      ),
      SubMenuItem(
        title: 'Release Detained License',
        icon: Icons.lock_open,
        route: '/applications/release',
      ),
      SubMenuItem(
        title: 'Retake Test',
        icon: Icons.refresh,
        route: '/applications/retake',
      ),
    ],
  ),
  const SubMenuItem(
    title: 'Manage Applications',
    icon: Icons.folder_open_outlined,
    children: [
      SubMenuItem(
        title: 'Local Driving License',
        icon: Icons.circle,
        route: DRoutes.listLocalDrLiApplicationsScreen,
      ),
      SubMenuItem(
        title: 'International License',
        icon: Icons.circle,
        route: '/applications/manage-international',
      ),
    ],
  ),
  const SubMenuItem(
    title: 'Detain Licenses',
    icon: Icons.pan_tool_outlined,
    children: [
      SubMenuItem(
        title: 'Manage Detained Licenses',
        icon: Icons.circle,
        route: '/applications/detained-list',
      ),
      SubMenuItem(
        title: 'Detain License',
        icon: Icons.circle,
        route: '/applications/detain',
      ),
      SubMenuItem(
        title: 'Release Detained License',
        icon: Icons.circle,
        route: '/applications/release-detain',
      ),
    ],
  ),
  const SubMenuItem(
    title: 'Manage Application Types',
    icon: Icons.category_outlined,
    route: DRoutes.applicationTypes,
  ),
  const SubMenuItem(
    title: 'Manage Test Types',
    icon: Icons.checklist_outlined,
    route: DRoutes.testTypesScreen,
  ),
];

// ============================================================
// DASHBOARD WITH FLOATING PANEL
// ============================================================

class DashboardScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const DashboardScreen({super.key, required this.navigationShell});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int get _currentIndex => widget.navigationShell.currentIndex;

  // Floating panel state
  bool _isPanelOpen = false;
  final Set<String> _expandedItems = {};

  void _onMainTap(int index) {
    if (index == 1) {
      // Applications tapped
      setState(() => _isPanelOpen = !_isPanelOpen);
    } else {
      setState(() => _isPanelOpen = false);
    }
    widget.navigationShell.goBranch(index);
  }

  void _toggleExpand(String title) {
    setState(() {
      if (_expandedItems.contains(title)) {
        _expandedItems.remove(title);
      } else {
        _expandedItems.add(title);
      }
    });
  }

  void _navigateTo(String? route) {
    if (route != null) {
      setState(() => _isPanelOpen = false);
      context.pushNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehicle Management System'),
          centerTitle: true,
          leading: const Icon(Icons.menu),
          actions: [
            IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
            IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.person_pin_rounded),
              onPressed: () {},
            ),
          ],
        ),

        body: Stack(
          children: [
            Row(
              children: [
                // Navigation Rail
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: NavigationRail(
                    selectedIndex: _currentIndex,
                    scrollable: true,
                    indicatorShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onDestinationSelected: _onMainTap,
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        selectedIcon: Icon(Icons.dashboard),
                        label: Text('Dashboard'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.app_registration_outlined),
                        selectedIcon: Icon(Icons.app_registration),
                        label: Text('Applications'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people_outline),
                        selectedIcon: Icon(Icons.people),
                        label: Text('People'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.drive_eta_outlined),
                        selectedIcon: Icon(Icons.drive_eta),
                        label: Text('Drivers'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_outline),
                        selectedIcon: Icon(Icons.person),
                        label: Text('Users'),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                // Main Content takes full remaining width
                Expanded(child: widget.navigationShell),
              ],
            ),

            // ---- FLOATING PANEL (Overlay) ----
            // Positioned right next to the NavigationRail
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              left: _isPanelOpen
                  ? 90
                  : -240, // 80 = Rail width, -280 = hidden left
              top: 0,
              bottom: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isPanelOpen ? 1.0 : 0.0,
                child: _buildFloatingPanel(),
              ),
            ),

            // ---- SCRIM (Click outside to close) ----
            if (_isPanelOpen)
              Positioned.fill(
                left: 90 + 240, // Start after Rail + Panel
                child: GestureDetector(
                  onTap: () => setState(() => _isPanelOpen = false),
                  child: Container(color: Colors.black.withValues(alpha: 0.1)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingPanel() {
    return Container(
      width: 230,
      margin: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(4, 0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 40,
            spreadRadius: 8,
            offset: const Offset(8, 0),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          // Panel Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade50, Colors.blue.shade50],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.app_registration,
                    color: Colors.indigo.shade700,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Applications',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                ),
                // Close button
                InkWell(
                  onTap: () => setState(() => _isPanelOpen = false),
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView.builder(
              itemCount: applicationsSubMenu.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                return _buildSubMenuItem(applicationsSubMenu[index], 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(SubMenuItem item, int level) {
    final hasChildren = item.children != null && item.children!.isNotEmpty;
    final isExpanded = _expandedItems.contains(item.title);

    if (!hasChildren) {
      return InkWell(
        onTap: () => _navigateTo(item.route),
        child: Container(
          padding: EdgeInsets.only(
            left: 16,
            right: 16 + (level * 14),
            top: 10,
            bottom: 10,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.transparent,
          ),
          child: Row(
            children: [
              Icon(
                item.icon,
                size: level > 0 ? 7 : 17,
                color: level > 0
                    ? Colors.indigo.shade400
                    : Colors.grey.shade700,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: level > 0 ? 12 : 13,
                    fontWeight: level > 0 ? FontWeight.normal : FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        InkWell(
          onTap: () => _toggleExpand(item.title),
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16 + (level * 10),
              top: 11,
              bottom: 11,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isExpanded
                  ? Colors.indigo.shade50.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(
                  item.icon,
                  size: 17,
                  color: isExpanded
                      ? Colors.indigo.shade700
                      : Colors.grey.shade700,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isExpanded
                          ? Colors.indigo.shade800
                          : Colors.grey.shade800,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Column(
            children: item.children!
                .map((child) => _buildSubMenuItem(child, level + 1))
                .toList(),
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
