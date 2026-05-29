import 'package:advanced/021_intro_to_asynchronous/01_intro/benchmark_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/02_Task_class/task_mirror_screen.dart';
import 'package:advanced/021_intro_to_asynchronous/02_Task_class/when_all_ex_towScreen.dart';
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
          ],
        ),
      ),
    );
  }
}
