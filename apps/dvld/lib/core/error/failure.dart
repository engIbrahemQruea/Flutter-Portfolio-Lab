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

class LinkedRecordFailure extends DatabaseFailure {
  const LinkedRecordFailure([
    String message = 'لا يمكن حذف السجل لأنه مرتبط ببيانات أخرى في النظام',
  ]) : super(message);
}

// Failure Not Found
class NotFoundFailure extends DatabaseFailure {
  const NotFoundFailure([
    String message = 'لم يتم العثور على السجل المطلوب في قاعدة البيانات',
  ]) : super(message);
}

// Failure From Validation Duplicate
class DuplicateEntryFailure extends DatabaseFailure {
  const DuplicateEntryFailure([
    String message = 'هذه البيانات (مثل اسم المستخدم أو الرقم) مسجلة مسبقاً',
  ]) : super(message);
}

// Failure with status code 400
class NoInternetFailure extends ServerFailure {
  const NoInternetFailure([
    String message = 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الشبكة',
  ]) : super(message);
}

// Failure with status code 401
class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure([
    String message = 'جلسة العمل انتهت، يرجى إعادة تسجيل الدخول',
  ]) : super(message);
}

// Failure with status code 500
class InternalServerFailure extends ServerFailure {
  const InternalServerFailure([
    String message = 'حدث خطأ في خادم البيانات، يرجى المحاولة لاحقاً',
  ]) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'فشل في قراءة أو حفظ البيانات المؤقتة'])
    : super(message);
}

// unexpected failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure([
    String message = 'حدث خطأ غير متوقع، يرجى التواصل مع الدعم الفني',
  ]) : super(message);
}
