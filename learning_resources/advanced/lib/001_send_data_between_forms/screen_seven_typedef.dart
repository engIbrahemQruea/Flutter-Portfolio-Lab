import 'package:advanced/001_send_data_between_forms/screen_sex.dart';
import 'package:flutter/material.dart';

class delegateScreenSex extends StatefulWidget {
  const delegateScreenSex({super.key});

  @override
  State<delegateScreenSex> createState() => _delegateScreenSexState();
}

class _delegateScreenSexState extends State<delegateScreenSex> {
  String textFromForm2 = "No Data Yet";

  // 3. الدالة الحقيقية التي تطابق مواصفات الـ Delegate
  void _handleDataFromForm2(String incomingData) {
    setState(() {
      textFromForm2 = incomingData; // تحديث الواجهة بالبيانات العائدة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen Sex')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textFromForm2, style: const TextStyle(fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                // فتح Form2 وتمرير الدالة كـ Delegate
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        delegateScreenSeven(onDataBack: _handleDataFromForm2),
                  ),
                );
              },
              child: const Text('Go to Form 2'),
            ),
          ],
        ),
      ),
    );
  }
}
