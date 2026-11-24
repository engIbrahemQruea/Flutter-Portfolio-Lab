import 'package:dvld/features/applications/applications_core/domain/entities/application_status.dart';

extension ApplicationStatusX on ApplicationStatus {
  String get arabicName {
    return switch (this) {
      ApplicationStatus.newApp => 'طلب جديد',
      ApplicationStatus.cancelled => 'ملغي',
      ApplicationStatus.completed => 'مكتمل',
    };
  }

  String get englishName {
    return switch (this) {
      ApplicationStatus.newApp => 'New',
      ApplicationStatus.cancelled => 'Cancelled',
      ApplicationStatus.completed => 'Completed',
    };
  }
}
