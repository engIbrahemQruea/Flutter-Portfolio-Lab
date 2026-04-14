import 'dart:async';

import 'package:flutter/material.dart';

class TimerPractice extends StatefulWidget {
  const TimerPractice({super.key});

  @override
  State<TimerPractice> createState() => _TimerPracticeState();
}

class _TimerPracticeState extends State<TimerPractice> {
  int _counter = 0; // يوازي private int Counter في كودك
  Timer? _timer; // كائن التايمر

  void _startTimer() {
    // لمنع تشغيل أكثر من تايمر في نفس الوقت
    if (_timer != null && _timer!.isActive) return;

    // يوازي timer1.Interval = 1000 و Enabled = true
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++; // يوازي Counter++ في حدث Tick
      });
    });
  }

  void _stopTimer() {
    // يوازي timer1.Enabled = false
    _timer?.cancel();
  }

  void _restTimer() {
    // _stopTimer();
    setState(() {
      _counter = 0;
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // كقاعدة هندسية: دائماً نظف التايمر عند إغلاق الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Timer Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // يوازي label1 بخصائصه (Font 50)
            Text(
              '$_counter',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  child: Text("Start"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _restTimer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text('Rest'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _stopTimer,
                  child: Text("Stop"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
