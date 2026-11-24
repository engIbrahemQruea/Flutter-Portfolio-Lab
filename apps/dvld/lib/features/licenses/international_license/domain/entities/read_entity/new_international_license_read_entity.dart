import 'package:dvld/core/helpers/extensions_x/date_time_extensions_x.dart';
import 'package:dvld/features/applications/application_types/domain/entity/application_type_entity.dart';
import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:equatable/equatable.dart';

class NewInternationalLicenseReadEntity extends Equatable {
  final LoginEntity loginEntity;
  final ApplicationTypeEntity applicationTypeEntity;
  final DateTime applicationDate;
  final DateTime issueDate;
  final DateTime expirationDate;

  NewInternationalLicenseReadEntity({
    required this.loginEntity,
    required this.applicationTypeEntity,
    DateTime? applicationDate,
    DateTime? issueDate,
    DateTime? expirationDate,
  }) : applicationDate = applicationDate ?? DateTime.now(),
       issueDate = issueDate ?? DateTime.now(),
       expirationDate =
           issueDate?.addOneYear()! ?? DateTime.now().addOneYear()!;

  int get currentUserId => loginEntity.userId!;
  String get currentUserName => loginEntity.userName;
  double get currentFees => applicationTypeEntity.applicationTypeFees;

  NewInternationalLicenseReadEntity copyWith({
    LoginEntity? loginEntity,
    ApplicationTypeEntity? applicationTypeEntity,
    DateTime? applicationDate,
    DateTime? issueDate,
    DateTime? expirationDate,
  }) {
    return NewInternationalLicenseReadEntity(
      loginEntity: loginEntity ?? this.loginEntity,
      applicationTypeEntity:
          applicationTypeEntity ?? this.applicationTypeEntity,
      applicationDate: applicationDate ?? this.applicationDate,
      issueDate: issueDate ?? this.issueDate,
      expirationDate: expirationDate ?? this.expirationDate,
    );
  }

  @override
  List<Object?> get props => [
    loginEntity,
    applicationTypeEntity,
    applicationDate,
    issueDate,
    expirationDate,
  ];
}
