import 'package:equatable/equatable.dart';

class ApplicationTypeEntity extends Equatable {
  const ApplicationTypeEntity({
    this.applicationTypeId,
    required this.applicationTypeTitle,
    required this.applicationTypeFees,
  });

  final int? applicationTypeId;
  final String applicationTypeTitle;
  final double applicationTypeFees;

  @override
  List<Object?> get props => [applicationTypeId, applicationTypeTitle, applicationTypeFees];
}
