import 'package:advanced/020_multithreading_isolate/03_parameterized_thread/parameterized_screen.dart';
import 'package:advanced/020_multithreading_isolate/04_download_screen/download_screen.dart';
import 'package:advanced/020_multithreading_isolate/04_download_screen/isolate_join_screen.dart';
import 'package:advanced/020_multithreading_isolate/05_race_condition/guard_lab_screen.dart';
import 'package:advanced/020_multithreading_isolate/06_thread_synchronization/counter_lock_screen.dart';
import 'package:advanced/020_multithreading_isolate/06_thread_synchronization/sync_lab_screen.dart';
import 'package:flutter/material.dart';

class MainIsolateScreen extends StatelessWidget {
  const MainIsolateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Isolate Screen')),
      body: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ParameterizedScreen()),
              );
            },
            label: Text('  Parameterized Thread (Isolate)'),
            icon: Icon(Icons.play_arrow),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DownloadScreen()),
              );
            },
            label: Text('  Parallel Web Downloader'),
            icon: Icon(Icons.download),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IsolateJoinScreen()),
              );
            },
            label: Text('  Isolate Join Simulation'),
            icon: Icon(Icons.merge_type),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GuardLabScreen()),
              );
            },
            label: Text('  Anti-Race Condition Sandbox'),
            icon: Icon(Icons.shield),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SyncLabScreen()),
              );
            },
            label: Text('Synchronization Lab Screen'),
            icon: Icon(Icons.sync),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CounterLockScreen()),
              );
            },
            label: Text('Counter Lock Screen'),
            icon: Icon(Icons.lock),
          ),
        ],
      ),
    );
  }
}
