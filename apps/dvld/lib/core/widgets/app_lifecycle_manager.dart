import 'package:dvld/core/di/dependency_injection.dart';
import 'package:dvld/core/helpers/constance.dart';
import 'package:dvld/core/helpers/shared_pref_helper.dart';
import 'package:flutter/material.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;
  const AppLifecycleManager({super.key, required this.child});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager> {
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onDetach: _clearDataOnExit, //executed when the app is closed
      // onHide: _clearDataOnExit,  //executed when the app is minimized
    );
  }

  void _clearDataOnExit() {
    getIt<SharedPrefHelper>().removeData(sharedPrefKeyCurrentUser);
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
