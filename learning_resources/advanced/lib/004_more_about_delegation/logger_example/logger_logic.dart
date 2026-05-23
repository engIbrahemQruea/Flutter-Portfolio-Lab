// تعريف الـ Typedef ليكون مطابقاً للـ Delegate في سي شارب
typedef LogAction = void Function(String message);

class Logger {
  // دالة استقبال اللوج وتمريره للدالة المفوضة
  void log(String message, LogAction logDestination) {
    String timestamp = DateTime.now().toString().substring(11, 19);
    String formattedMessage = "[$timestamp] $message";

    // تنفيذ التفويض
    logDestination(formattedMessage);
  }
}

// الوجهات الحقيقية المتاحة للتسجيل في النظام
class LogDestinations {
  final void Function(String) onUIUpdate;

  LogDestinations(this.onUIUpdate);

  void logToConsole(String message) {
    onUIUpdate("🟢 ConsoleLogger: $message");
  }

  void logToFile(String message) {
    onUIUpdate("🔵 FileLogger: Writing to app_log.txt -> $message");
  }

  void logToCloud(String message) {
    onUIUpdate("🔥 CloudLogger: Sending critical alert to server! -> $message");
  }
}
