import 'package:dvld/features/applications/application_types/application_types_helper/enum_application_types.dart';

enum IssueReason {
  firstTime(1, 'إصدار لأول مرة', 'First Time'),
  renew(2, 'تجديد رخصة', 'Renew'),
  replacementForDamaged(3, 'بدل تالف', 'Replacement for Damaged'),
  replacementForLost(4, 'بدل ضائع', 'Replacement for Lost');

  final int value;
  final String labelAr;
  final String labelEn;

  const IssueReason(this.value, this.labelAr, this.labelEn);

  factory IssueReason.fromValue(int value) {
    return switch (value) {
      1 => IssueReason.firstTime,
      2 => IssueReason.renew,
      3 => IssueReason.replacementForDamaged,
      4 => IssueReason.replacementForLost,
      _ => throw ArgumentError(' Unknown IssueReason value: $value'),
    };
  }
}

extension ReplacementTypeMapping on IssueReason {
  EnumApplicationTypes get applicationType => switch (this) {
    IssueReason.replacementForDamaged =>
      EnumApplicationTypes.replacementForDamagedLocalDrivingLicense,
    IssueReason.replacementForLost =>
      EnumApplicationTypes.replacementForLostLocalDrivingLicense,
    _ => throw StateError('Unknown IssueReason value: $this'),
  };
}
