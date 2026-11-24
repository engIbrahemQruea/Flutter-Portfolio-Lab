abstract class IssueFirstLicenseDataSource {
  Future<int> issueFirstLicense({
    required int localDLApplicationId,
     String? notes,
    required int createdByUserId,
  });
}
