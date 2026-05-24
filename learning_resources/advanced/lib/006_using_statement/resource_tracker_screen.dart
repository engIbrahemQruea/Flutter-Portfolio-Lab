import 'package:advanced/006_using_statement/custom_resource_manager.dart';
import 'package:flutter/material.dart';

class ResourceTrackerScreen extends StatefulWidget {
  const ResourceTrackerScreen({super.key});

  @override
  State<ResourceTrackerScreen> createState() => _ResourceTrackerScreenState();
}

class _ResourceTrackerScreenState extends State<ResourceTrackerScreen> {
  // حجز المورد عند بناء الشاشة
  final CustomStreamResource _myResource = CustomStreamResource();

  @override
  void dispose() {
    // 🎯 هنا التطبيق العملي لنصيحة المدرب الحتمية!
    // عند الخروج من الشاشة (Out of scope)، نقوم بتدمير وتنظيف المورد فوراً
    _myResource.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حارس الموارد والذاكرة في فلاتر'),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 80,
              color: Colors.red.shade700,
            ),
            const SizedBox(height: 16),
            const Text(
              'استماع حي لبيانات الشبكة المستمرة:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // عرض البث المباشر المأخوذ من المورد
            StreamBuilder<int>(
              stream: _myResource.liveStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    'الحزمة رقم: ${snapshot.data}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
              ),
              onPressed: () {
                // العودة للخلف لتدمير الويدجت وتفعيل الـ dispose تلقائياً
                Navigator.pop(context);
              },
              child: const Text(
                'اضغط للخروج وتدمير المورد فوراً',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
