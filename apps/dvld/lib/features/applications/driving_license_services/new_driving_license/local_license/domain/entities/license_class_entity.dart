import 'package:equatable/equatable.dart';

final class LicenseClassEntity extends Equatable {
  const LicenseClassEntity({
    this.licenseClassId,
    required this.className,
    required this.classDescription,
    required this.minimumAllowedAge,
    required this.defaultValidityLength,
    required this.classFees,
  });

  final int? licenseClassId;
  final String className;
  final String classDescription;
  final int minimumAllowedAge;
  final int defaultValidityLength;
  final double classFees;

  @override
  List<Object?> get props => [
    licenseClassId,
    className,
    classDescription,
    minimumAllowedAge,
    defaultValidityLength,
    classFees,
  ];
}
