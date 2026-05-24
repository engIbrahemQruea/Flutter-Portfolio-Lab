import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final int points;

  UserModel({
    required this.username,
    required this.email,
    required this.points,
  });

  /// 1. خطوة تمهيد الـ Serialization: تحويل خصائص الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {'username': username, 'email': email, 'points': points};
  }

  /// 2. خطوة الـ Deserialization العكسية: بناء الكائن من Map قادم من الخارج
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      points: map['points'] ?? 0,
    );
  }

  /// تحويل كلي مباشر لنص JSON (توازي تماماً دالة التسييل في C#)
  String toJson() => json.encode(toMap());

  /// استعادة كلية مباشرة من نص JSON
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
