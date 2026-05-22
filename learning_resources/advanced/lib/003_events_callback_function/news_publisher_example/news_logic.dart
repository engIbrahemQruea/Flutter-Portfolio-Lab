// 1. تصنيف الأخبار
enum NewsCategory { sports, tech }

// 2. كلاس حقيبة البيانات (EventArgs)
class NewsEventArgs {
  final String title;
  final String content;
  final NewsCategory category;
  final DateTime datePublished;

  NewsEventArgs({
    required this.title,
    required this.content,
    required this.category,
  }) : datePublished = DateTime.now(); // حظر الوقت تلقائياً عند النشر
}

// 3. كلاس الناشر (NewsPublisher)
class NewsPublisher {
  final String publisherName;

  // تعريف قنوات البث (الأسلاك)
  void Function(Object sender, NewsEventArgs e)? onSportsNewsPublished;
  void Function(Object sender, NewsEventArgs e)? onTechNewsPublished;

  NewsPublisher(this.publisherName);

  // دالة الحماية والـ Invoke المركزي
  void publishNews(String title, String content, NewsCategory category) {
    final args = NewsEventArgs(
      title: title,
      content: content,
      category: category,
    );

    if (category == NewsCategory.sports && onSportsNewsPublished != null) {
      onSportsNewsPublished!(this, args);
    } else if (category == NewsCategory.tech && onTechNewsPublished != null) {
      onTechNewsPublished!(this, args);
    }
  }
}

// 4. كلاس المشترك (NewsSubscriber)
class NewsSubscriber {
  final String subscriberName;
  final List<String> receivedNotifications =
      []; // صندوق الوارد الخاص بكل مستخدم

  NewsSubscriber(this.subscriberName);

  // دالة استقبال أخبار الرياضة (تطابق الـ Signature)
  void handleSportsNews(Object sender, NewsEventArgs e) {
    final publisher = sender as NewsPublisher;
    receivedNotifications.add(
      "📣 [رياضة] من ${publisher.publisherName}:\n${e.title}\n${e.content}",
    );
  }

  // دالة استقبال أخبار التقنية (تطابق الـ Signature)
  void handleTechNews(Object sender, NewsEventArgs e) {
    final publisher = sender as NewsPublisher;
    receivedNotifications.add(
      "💻 [تقنية] من ${publisher.publisherName}:\n${e.title}\n${e.content}",
    );
  }
}
