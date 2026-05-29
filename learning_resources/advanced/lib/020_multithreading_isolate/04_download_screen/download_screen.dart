import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  // سجل تتبع حالة تحميل كل موقع
  final Map<String, String> _statusMap = {
    "https://www.wikipedia.org": "في الانتظار...",
    "https://www.github.com": "في الانتظار...",
    "https://www.microsoft.com": "في الانتظار...",
  };

  final Map<String, Color> _colorMap = {
    "https://www.wikipedia.org": Colors.grey,
    "https://www.github.com": Colors.grey,
    "https://www.microsoft.com": Colors.grey,
  };

  bool _isDownloading = false;
  String _totalTimeText = "";

  /// 🛠️ الأنبوب الهندسي للتحميل المتوازي (The Concurrent Download Pipeline)
  Future<void> _startConcurrentDownload() async {
    setState(() {
      _isDownloading = true;
      _totalTimeText = "";
      _statusMap.updateAll((key, value) => "⏳ جاري التحميل بالتوازي...");
      _colorMap.updateAll((key, value) => Colors.amberAccent);
    });

    final stopwatch = Stopwatch()..start();

    // 1. تجميع الـ Futures (المهام) في قائمة واحدة
    List<Future<void>> downloadTasks = [
      _downloadPage("https://www.wikipedia.org"),
      _downloadPage("https://www.github.com"),
      _downloadPage("https://www.microsoft.com"),
    ];

    // 2. 🔴 اللقطة السحرية: Future.wait تطلق جميع المهام معاً بالتوازي كلياً!
    // الكود ينتظر حتى تنتهي "جميع" المواقع، دون أن يحجز خيط الواجهة الرئيسية.
    await Future.wait(downloadTasks);

    stopwatch.stop();

    setState(() {
      _isDownloading = false;
      _totalTimeText =
          "⏱️ اكتملت المنظومة بالكامل في: ${stopwatch.elapsedMilliseconds} ميلي ثانية! (حوالي ${stopwatch.elapsed.inSeconds} ثوانٍ)";
    });
  }

  /// الدالة المسؤولة عن جلب بيانات الموقع الواحد
  Future<void> _downloadPage(String url) async {
    try {
      // إرسال طلب جلب البيانات غير المتزامن (Non-blocking Asynchronous Call)
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          _statusMap[url] =
              "✅ تم التحميل! حجم الصفحة: ${response.body.length} بايت.";
          _colorMap[url] = Colors.greenAccent;
        });
      } else {
        setState(() {
          _statusMap[url] =
              "⚠️ استجابة غريبة من السيرفر: ${response.statusCode}";
          _colorMap[url] = Colors.orangeAccent;
        });
      }
    } catch (e) {
      setState(() {
        _statusMap[url] = "❌ فشل الاتصال بالشبكة!";
        _colorMap[url] = Colors.redAccent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🌐 Parallel Web Downloader Lab"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 100, 129, 186),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "محاكاة معمارية لتحميل 3 صفحات ويب في نفس الوقت بشكل متزامن متوازٍ:",
              style: TextStyle(fontSize: 13, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // زر إطلاق خط إنتاج التحميل
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade700,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey.shade900,
              ),
              onPressed: _isDownloading ? null : _startConcurrentDownload,
              icon: _isDownloading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.cloud_download),
              label: Text(
                _isDownloading
                    ? "Downloading concurrently..."
                    : "Start Parallel Download",
              ),
            ),
            const SizedBox(height: 25),

            // لوحات عرض الحالة الحية لكل موقع ويب
            ..._statusMap.entries.map((entry) {
              String url = entry.key;
              String status = entry.value;
              Color statusColor = _colorMap[url]!;

              return Card(
                color: const Color(0xFF121824),
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: statusColor.withOpacity(0.3)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.language, color: statusColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              url,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 12,
                                fontFamily: 'Courier',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 20),
            // عرض إجمالي الوقت المستغرق
            if (_totalTimeText.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  // border: BorderSide(color: Colors.purple.withOpacity(0.3)),
                ),
                child: Text(
                  _totalTimeText,
                  style: const TextStyle(
                    color: Colors.purpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
