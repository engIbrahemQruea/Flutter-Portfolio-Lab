// core/errors/failures.dart
abstract class Failure {
  final String message;

  const Failure(this.message);
}

// خطأ خاص بقاعدة البيانات المحلية
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

// خطأ خاص بالسيرفر أو شبكة الإنترنت
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}
