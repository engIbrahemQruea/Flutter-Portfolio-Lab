import 'package:dvld/features/licenses/licenses_core/domain/entities/issue_reason.dart';

typedef ReplaceLicenseParam = ({
  int oldLicenseId,
  IssueReason reason,
  int createdByUserId,
  double applicationFee,
});

typedef ReplaceLicenseResult = ({int applicationId, int newLicenseId});