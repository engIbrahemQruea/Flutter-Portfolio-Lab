import 'dart:async';

import 'package:flutter/material.dart';

class LinerCircularProgressIndicator extends StatefulWidget {
  const LinerCircularProgressIndicator({super.key});

  @override
  State<LinerCircularProgressIndicator> createState() =>
      _LinerCircularProgressIndicatorState();
}

class _LinerCircularProgressIndicatorState
    extends State<LinerCircularProgressIndicator> {
  double _progressValue = 0.0; // القيمة تبدأ من 0 (توازي Value في C#)
  Timer? _timer;

  void startProgress() {
    _progressValue = 0.0;
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (_progressValue < 1.0) {
          _progressValue += 0.01; // زيادة التقدم بنسبة 1% في كل تكة
        } else {
          _timer?.cancel(); // إيقاف التايمر عند الوصول لـ 100%
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ProgressBar')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. شريط تقدم محدد (Determinate)
          LinearProgressIndicator(value: _progressValue),

          SizedBox(height: 20),
          LinearProgressIndicator(value: _progressValue),
          SizedBox(height: 20),
          CircularProgressIndicator(value: _progressValue),
          SizedBox(height: 20),

          // 2. نص يظهر النسبة المئوية (Formatting)
          Text("${(_progressValue * 100).toInt()}%"),

          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              startProgress();
            },
            child: Text('Start'),
          ),
        ],
      ),
    );
  }
}
