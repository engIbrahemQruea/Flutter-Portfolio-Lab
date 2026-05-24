class AppSettings {
  final String themeMode;
  final bool isNotificationsEnabled;
  final int cacheSizeInMB;

  AppSettings({
    required this.themeMode,
    required this.isNotificationsEnabled,
    required this.cacheSizeInMB,
  });

  // --- 🎯 محاكاة الـ Serialization لغرض الـ Caching والـ Persistence ---
  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode,
      'isNotificationsEnabled': isNotificationsEnabled,
      'cacheSizeInMB': cacheSizeInMB,
    };
  }

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      themeMode: map['themeMode'] ?? 'light',
      isNotificationsEnabled: map['isNotificationsEnabled'] ?? true,
      cacheSizeInMB: map['cacheSizeInMB'] ?? 50,
    );
  }

  // --- 🎯 محاكاة الـ Deep Copy (Cloning) المذكور في ورقة المدرب ---
  // دالة copyWith تضمن لك إنشاء نسخة منفصلة تماماً في الذاكرة مع إمكانية تعديل حقول معينة
  AppSettings copyWith({
    String? themeMode,
    bool? isNotificationsEnabled,
    int? cacheSizeInMB,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      isNotificationsEnabled:
          isNotificationsEnabled ?? this.isNotificationsEnabled,
      cacheSizeInMB: cacheSizeInMB ?? this.cacheSizeInMB,
    );
  }
}
