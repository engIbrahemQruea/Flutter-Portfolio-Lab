import 'dart:async';

// 1. كلاس المقال (حقيبة البيانات الممررة)
class NewsArticle {
  final String title;
  final String content;

  NewsArticle(this.title, this.content);
}

// 2. كلاس الناشر (NewsPublisher)
class NewsPublisher {
  // الـ StreamController هو الأداة المدمجة في دارت لبث الأحداث لعدة مستمعين (Broadcast)
  final StreamController<NewsArticle> _newsStreamController =
      StreamController<NewsArticle>.broadcast();

  // هذا هو "الحدث" الفعلي الذي سيتصل به المشتركون بالخارج
  Stream<NewsArticle> get newNewsPublished => _newsStreamController.stream;

  void publishNews(String title, String content) {
    final article = NewsArticle(title, content);
    _onNewNewsPublished(article);
  }

  // دالة الحماية المركزية للبث
  void _onNewNewsPublished(NewsArticle article) {
    _newsStreamController.add(article); // تشبه Invoke في C#
  }

  // تنظيف الذاكرة عند إغلاق الناشر نفسه
  void dispose() {
    _newsStreamController.close();
  }
}

// 3. كلاس المشترك (NewsSubscriber)
class NewsSubscriber {
  final String name;

  // هذا المتغير يمثل "السلك" المربوط، نحتفظ به لكي نتمكن من قطعه عند إلغاء الاشتراك
  StreamSubscription<NewsArticle>? _subscription;

  NewsSubscriber(this.name);

  // دالة الاشتراك (المكافئ لـ +=)
  void subscribe(NewsPublisher publisher) {
    _subscription = publisher.newNewsPublished.listen((article) {
      handleNewNews(publisher, article);
    });
  }

  // دالة إلغاء الاشتراك (المكافئ لـ -=)
  void unSubscribe(NewsPublisher publisher) {
    if (_subscription != null) {
      _subscription!.cancel(); // قطع السلك فوراً وإلغاء الاستماع
      _subscription = null;
      print("❌ [$name] قام بإلغاء الاشتراك ولن يستقبل أخباراً أخرى.");
    }
  }

  // دالة معالجة الحدث (المكافئ لـ HandleNewNews)
  void handleNewNews(Object sender, NewsArticle article) {
    print("$name received a new news article:");
    print("Title: ${article.title}");
    print("Content: ${article.content}\n");
  }
}
