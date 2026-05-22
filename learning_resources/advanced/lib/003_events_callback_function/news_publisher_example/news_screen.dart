import 'package:advanced/003_events_callback_function/news_publisher_example/news_logic.dart';
import 'package:flutter/material.dart';

class NewsAppScreen extends StatefulWidget {
  const NewsAppScreen({super.key});

  @override
  State<NewsAppScreen> createState() => _NewsAppScreenState();
}

class _NewsAppScreenState extends State<NewsAppScreen> {
  // إنشاء الناشر والمشتركين (دالة Main)
  final NewsPublisher _publisher = NewsPublisher("الجزيرة الإخبارية");
  final NewsSubscriber _ahmed = NewsSubscriber("أحمد");
  final NewsSubscriber _sara = NewsSubscriber("سارة");

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  NewsCategory _selectedCategory = NewsCategory.sports;

  @override
  void initState() {
    super.initState();
    // 🔌 توصيل الأسلاك (الاشتراك بالحدث بدون أقواس كما تعلمنا!)
    _publisher.onSportsNewsPublished =
        _ahmed.handleSportsNews; // أحمد اشترك في الرياضة فقط
    _publisher.onTechNewsPublished =
        _sara.handleTechNews; // سارة اشتركت في التقنية فقط
  }

  void _onPublishPressed() {
    if (_titleController.text.isEmpty) return;

    setState(() {
      // إطلاق الحدث من الناشر
      _publisher.publishNews(
        _titleController.text,
        _contentController.text,
        _selectedCategory,
      );
    });

    _titleController.clear();
    _contentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نظام بث الإشعارات والأخبار')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // 📝 لوحة تحكم الناشر
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '✍️ لوحة الناشر: ${_publisher.publisherName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'عنوان الخبر',
                      ),
                    ),
                    TextField(
                      controller: _contentController,
                      decoration: const InputDecoration(
                        labelText: 'تفاصيل الخبر',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('القسم: '),
                        DropdownButton<NewsCategory>(
                          value: _selectedCategory,
                          items: const [
                            DropdownMenuItem(
                              value: NewsCategory.sports,
                              child: Text('رياضة ⚽'),
                            ),
                            DropdownMenuItem(
                              value: NewsCategory.tech,
                              child: Text('تقنية 💻'),
                            ),
                          ],
                          onChanged: (val) =>
                              setState(() => _selectedCategory = val!),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: _onPublishPressed,
                          child: const Text('بث الخبر الآن 🚀'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 📱 هواتف المشتركين (صناديق الوارد)
            Expanded(
              child: Row(
                children: [
                  // هاتف أحمد (رياضة)
                  Expanded(
                    child: _buildSubscriberPhone(_ahmed, Colors.green.shade100),
                  ),
                  const SizedBox(width: 10),
                  // هاتف سارة (تقنية)
                  Expanded(
                    child: _buildSubscriberPhone(_sara, Colors.purple.shade100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriberPhone(NewsSubscriber subscriber, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            '📱 هاتف: ${subscriber.subscriberName}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: subscriber.receivedNotifications.isEmpty
                ? const Center(
                    child: Text(
                      'لا توجد إشعارات',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: subscriber.receivedNotifications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            subscriber.receivedNotifications[index],
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
