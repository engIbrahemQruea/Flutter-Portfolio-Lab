import 'package:advanced/021_intro_to_asynchronous/01_intro/benchmark_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/02_Task_class/task_mirror_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/02_Task_class/when_all_ex_towScreen.dart';
import 'package:advanced/021_intro_to_asynchronous/03_task_class_with_callback_event/task_class_with_callback_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/04_task_run/task_run_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/05_task_factory/task_factory_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/06_parallel_class_data_parallelism/app_bar_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/06_parallel_class_data_parallelism/parallel_for_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/06_parallel_class_data_parallelism/parallel_screen.dart';
import 'package:flutter/material.dart';

class MainAsynchronousScreen extends StatelessWidget {
  const MainAsynchronousScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مقدمة في البرمجة غير المتزامنة")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BenchmarkScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Benchmarking Concurrency Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskMirrorScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Task Mirror Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WhenAllScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Task WhenAll Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EventCallbackScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Event Callback Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskRunScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Task.Run Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskFactoryScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Task.Factory Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParallelScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Data Parallelism Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParallelForScreen(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("Data Parallelism For Lab"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AppBarExample(),
                  ),
                );
              },
              icon: Icon(Icons.info_outline),
              label: Text("async AppBar Lab"),
            ),
          ],
        ),
      ),
    );
  }
}
