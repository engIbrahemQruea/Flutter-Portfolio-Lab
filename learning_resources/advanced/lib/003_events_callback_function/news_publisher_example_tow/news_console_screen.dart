import 'package:advanced/003_events_callback_function/news_publisher_example_tow/news_engine_logic.dart';
import 'package:flutter/material.dart';

// تم تحويل الشاشة إلى StatefulWidget لتحديث الواجهة ديناميكياً
class NewsConsoleScreen extends StatefulWidget {
  const NewsConsoleScreen({super.key});

  @override
  State<NewsConsoleScreen> createState() => _NewsConsoleScreenState();
}

class _NewsConsoleScreenState extends State<NewsConsoleScreen> {
  // هذه المصفوفة ستحفظ الأسطر المطبوعة لعرضها في قائمة داخل الواجهة
  final List<String> _uiLogs = [];

  // دالة مساعدة لإضافة السجلات للواجهة فوراً
  void _logToUI(String message) {
    setState(() {
      _uiLogs.add(message);
    });
  }

  // الدالة التنفذية المحاكية لـ static void Main() المعدلة للطباعة في الواجهة
  void _runSimulation() {
    // تنظيف الشاشة من أي محاكاة سابقة قبل البدء
    setState(() {
      _uiLogs.clear();
    });

    _logToUI("--- 🚀 بدء محاكاة نظام المدرب للأخبار 🚀 ---");

    NewsPublisher publisher = NewsPublisher();

    // إنشاء كائن المشترك الأول والثاني باستخدام الكلاس الذكي الموجه للواجهة
    NewsUisubscriber subscriber1 = NewsUisubscriber("Subscriber 1", _logToUI);
    subscriber1.subscribe(publisher); // استخدام الدالة الأصلية للمدرب دون مشاكل

    NewsUisubscriber subscriber2 = NewsUisubscriber("Subscriber 2", _logToUI);
    subscriber2.subscribe(publisher);

    // البث الأول
    _logToUI("\n📢 [الناشر]: يبث الخبر الأول...");
    publisher.publishNews(
      "Breaking News",
      "A significant event just happened!",
    );

    // البث الثاني
    _logToUI("\n📢 [الناشر]: يبث الخبر الثاني...");
    publisher.publishNews("Tech Update", "New gadgets are hitting the market.");

    // إلغاء اشتراك المشترك الأول
    _logToUI("\n🛑 [إجراء]: إلغاء اشتراك Subscriber 1...");
    subscriber1.unSubscribe(publisher);
    _logToUI("❌ [Subscriber 1]: قطع السلك البرمجي بنجاح.");

    // البث الثالث (يستقبله المشترك الثاني فقط!)
    _logToUI("\n📢 [الناشر]: يبث الخبر الثالث...");
    publisher.publishNews(
      "Weather Forecast",
      "Expect sunny weather for the weekend.",
    );

    // إلغاء اشتراك المشترك الثاني
    _logToUI("\n🛑 [إجراء]: إلغاء اشتراك Subscriber 2...");
    subscriber2.unSubscribe(publisher);
    _logToUI("❌ [Subscriber 2]: قطع السلك البرمجي بنجاح.");

    // البث الرابع والأخير (لن يستقبله أحد!)
    _logToUI("\n📢 [الناشر]: يبث الخبر الرابع والأخير...");
    publisher.publishNews("Final Edition", "Last news update for today.");
    _logToUI("⚠️ (لم يستقبل أحد هذا الخبر لأن الجميع ألغوا اشتراكهم)");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محاكي نظام المشتركين والمقالات'),
        backgroundColor: Colors.blueGrey.shade900,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _runSimulation,
              icon: const Icon(Icons.play_arrow),
              label: const Text('تشغيل سيناريو المدرب ورصد النتائج'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Row(
              children: [
                Icon(Icons.terminal, color: Colors.blueGrey),
                SizedBox(width: 8),
                Text(
                  'ux شاشة عرض مخرجات النظام (UI Console):',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // صندوق محاكاة كونسول المخرجات السوداء
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade800, width: 2),
                ),
                padding: const EdgeInsets.all(12.0),
                child: _uiLogs.isEmpty
                    ? const Center(
                        child: Text(
                          'اضغط على الزر بالأعلى لمشاهدة دورة حياة الأحداث...',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'monospace',
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _uiLogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              _uiLogs[index],
                              style: TextStyle(
                                color: _uiLogs[index].contains('📥')
                                    ? Colors.greenAccent
                                    : _uiLogs[index].contains('❌')
                                    ? Colors.redAccent
                                    : Colors.white,
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

// 🛠️ الحل الهندسي لمنع الـ Assignment_to_method:
// قمنا بإنشاء كلاس مخصص للواجهة يرث من كلاس المدرب ويقوم بعمل Override لدالة الاستقبال
class NewsUisubscriber extends NewsSubscriber {
  final void Function(String) onLogReceived;

  NewsUisubscriber(super.name, this.onLogReceived);

  @override
  void handleNewNews(Object sender, NewsArticle article) {
    // بدلاً من الـ Print التقليدي في الكونسول، نوجه النص المنسق إلى دالة الواجهة فوراً
    String formattedMessage =
        "📥 [$name استقبل خبراً جديداً]:\n"
        "   العنوان: ${article.title}\n"
        "   المحتوى: ${article.content}";

    onLogReceived(formattedMessage);
  }
}
