typedef RenewLicenseResult = ({int applicationId, int newLicenseId});
typedef RenewLicenseParam = ({
  int oldLicenseId,
  int createdByUserId,
  double applicationFee,
  String? notes,
});
