import 'package:equatable/equatable.dart';

final class LicenseDetailsEntity extends Equatable {
  final int licenseID;
  final String className;
  final String nationalNo;
  final DateTime issueDate;
  final DateTime expirationDate;
  final bool isActive;
  final String? notes;
  final int issueReason;
  final int driverID;
  final String fullName;
  final int gender;
  final DateTime dateOfBirth;
  final String? imagePath;
  final bool? isDetained;

  const LicenseDetailsEntity({
    required this.licenseID,
    required this.className,
    required this.nationalNo,
    required this.issueDate,
    required this.expirationDate,
    required this.isActive,
    this.notes,
    required this.issueReason,
    required this.driverID,
    required this.fullName,
    required this.gender,
    required this.dateOfBirth,
    this.imagePath,
    this.isDetained,
  });

  bool get isExpired => expirationDate.isBefore(DateTime.now());

  LicenseDetailsEntity copyWith({
    int? licenseID,
    String? className,
    String? nationalNo,
    DateTime? issueDate,
    DateTime? expirationDate,
    bool? isActive,
    String? notes,
    int? issueReason,
    int? driverID,
    String? fullName,
    int? gender,
    DateTime? dateOfBirth,
    String? imagePath,
    bool? isDetained,
  }) {
    return LicenseDetailsEntity(
      licenseID: licenseID ?? this.licenseID,
      className: className ?? this.className,
      nationalNo: nationalNo ?? this.nationalNo,
      issueDate: issueDate ?? this.issueDate,
      expirationDate: expirationDate ?? this.expirationDate,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
      issueReason: issueReason ?? this.issueReason,
      driverID: driverID ?? this.driverID,
      fullName: fullName ?? this.fullName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      imagePath: imagePath ?? this.imagePath,
      isDetained: isDetained ?? this.isDetained,
    );
  }

  @override
  List<Object?> get props => [
    licenseID,
    className,
    nationalNo,
    issueDate,
    expirationDate,
    isActive,
    notes,
    issueReason,
    driverID,
    fullName,
    gender,
    dateOfBirth,
    imagePath,
    isDetained,
  ];
}
