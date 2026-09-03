import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class LocalDatabaseFailure extends DatabaseFailure {
  const LocalDatabaseFailure([super.message = 'error in query database']);
}

class LinkedRecordFailure extends DatabaseFailure {
  const LinkedRecordFailure([
    super.message = 'لا يمكن حذف السجل لأنه مرتبط ببيانات أخرى في النظام',
  ]);
}

// Failure Not Found
class NotFoundFailure extends DatabaseFailure {
  const NotFoundFailure([
    super.message = 'لم يتم العثور على السجل المطلوب في قاعدة البيانات',
  ]);
}

// Failure From Validation Duplicate (Unique Constraint)
class DuplicateEntryFailure extends DatabaseFailure {
  const DuplicateEntryFailure([
    super.message = 'هذه البيانات (مثل اسم المستخدم أو الرقم) مسجلة مسبقاً',
  ]);
}

// Failure with status code 400
class NoInternetFailure extends ServerFailure {
  const NoInternetFailure([
    super.message = 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة',
  ]);
}

// Failure with status code 401
class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure([
    super.message = 'جلسة العمل انتهت، يرجى إعادة تسجيل الدخول',
  ]);
}

// Failure with status code 500
class InternalServerFailure extends ServerFailure {
  const InternalServerFailure([
    super.message = 'حدث خطأ في خادم البيانات، يرجى المحاولة لاحقاً',
  ]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'فشل في قراءة أو حفظ البيانات المؤقتة']);
}

// unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    super.message = 'حدث خطأ غير متوقع، يرجى التواصل مع الدعم الفني',
  ]);
}
