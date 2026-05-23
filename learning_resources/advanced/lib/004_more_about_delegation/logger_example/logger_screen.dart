import 'package:advanced/004_more_about_delegation/logger_example/logger_logic.dart';
import 'package:flutter/material.dart';

class LoggerScreen extends StatefulWidget {
  const LoggerScreen({super.key});

  @override
  State<LoggerScreen> createState() => _LoggerScreenState();
}

class _LoggerScreenState extends State<LoggerScreen> {
  final Logger _logger = Logger();
  final List<String> _logsDisplay = [];
  late LogDestinations _destinations;

  @override
  void initState() {
    super.initState();
    // ربط مخرجات الكلاسات بالواجهة الرسومية مباشرة
    _destinations = LogDestinations((formattedText) {
      setState(() {
        _logsDisplay.add(formattedText);
      });
    });
  }

  void _triggerLog(String type) {
    if (type == 'console') {
      _logger.log("Normal operation completed.", _destinations.logToConsole);
    } else if (type == 'file') {
      _logger.log(
        "Backup file created on local storage.",
        _destinations.logToFile,
      );
    } else if (type == 'multicast') {
      // محاكاة الـ Multicast Delegate (+=) في سي شارب عن طريق تجميع الدوال في قائمة
      _logsDisplay.add("\n💥 [Multicast Triggered]:");

      // دالة تجمع بداخلها استدعاء الدالات الثلاث بالتوالي
      LogAction multiDelegate = (msg) {
        _destinations.logToConsole(msg);
        _destinations.logToFile(msg);
        _destinations.logToCloud(msg);
      };

      _logger.log("⚠️ CRITICAL FATAL EXCEPTION DETECTED!", multiDelegate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محاكي سجلات النظام (Logger Delegate)'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'أطلق حدث تسجيل البيانات وحدد الوجهة المفوضة:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // أزرار التحكم والـ Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _triggerLog('console'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Console Only'),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _triggerLog('file'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('File Only'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ElevatedButton.icon(
              onPressed: () => _triggerLog('multicast'),
              icon: const Icon(Icons.call_split),
              label: const Text('Multicast (Console + File + Cloud)'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade900,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            // لوحة عرض الـ Logs
            Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.blueGrey),
                const SizedBox(width: 6),
                const Text(
                  'شاشة رصد السجلات الحية:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete_sweep, color: Colors.red),
                  onPressed: () => setState(() => _logsDisplay.clear()),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: _logsDisplay.isEmpty
                    ? const Center(
                        child: Text(
                          'المستودع فارغ، أرسل سجلات برمجية لرصدها...',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _logsDisplay.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Text(
                              _logsDisplay[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
