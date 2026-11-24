part of 'issue_first_license_cubit.dart';

sealed class IssueFirstLicenseCubitState extends Equatable {
  const IssueFirstLicenseCubitState({this.localDLAppId, this.note});

  final int? localDLAppId;
  final String? note;

  @override
  List<Object?> get props => [localDLAppId, note];
}

final class IssueFirstLicenseCubitInitial extends IssueFirstLicenseCubitState {
  const IssueFirstLicenseCubitInitial({super.localDLAppId, super.note});

  IssueFirstLicenseCubitInitial copyWith({int? localDLAppId, String? note}) {
    return IssueFirstLicenseCubitInitial(
      localDLAppId: localDLAppId ?? this.localDLAppId,
      note: note ?? this.note,
    );
  }
}

final class IssueFirstLicenseCubitLoading extends IssueFirstLicenseCubitState {
  const IssueFirstLicenseCubitLoading({super.localDLAppId, super.note});
}

final class IssueFirstLicenseCubitSuccess extends IssueFirstLicenseCubitState {
  final int licenseId; // مع إرجاع رقم الرخصة الناتجة

  const IssueFirstLicenseCubitSuccess({
    required this.licenseId,
    super.localDLAppId,
    super.note,
  });

  @override
  List<Object?> get props => [licenseId, localDLAppId, note];
}

final class IssueFirstLicenseCubitFailure extends IssueFirstLicenseCubitState {
  final String errorMessage;

  const IssueFirstLicenseCubitFailure({
    required this.errorMessage,
    super.localDLAppId,
    super.note,
  });

  @override
  List<Object?> get props => [errorMessage, localDLAppId, note];
}
