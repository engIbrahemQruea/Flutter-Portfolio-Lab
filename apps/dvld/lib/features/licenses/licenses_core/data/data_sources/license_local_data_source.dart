import 'package:dvld/features/licenses/licenses_core/data/models/license_details_model.dart';
import 'package:dvld/features/licenses/licenses_core/data/models/license_model.dart';


abstract class LicenseLocalDataSource {
  Future<List<LicenseModel>> fetchAllLicenses();
  Future<LicenseModel> fetchLicenseInfoById({required int licenseId});
  Future<LicenseDetailsModel> fetchLicenseDetailsInfoById({
    required int licenseId,
  });
  Future<int?> fetchLicenseIdByLocalAppId(int localDLAppId);
  Future<int> addNewLicense({required LicenseModel licenseModel});
  Future<bool> updateLicense({required LicenseModel licenseModel});
  Future<List<LicenseModel>> fetchDriverLicenseInfoByDriverId({
    required int driverId,
  });
  Future<int?> fetchActiveLicenseIDByPersonId({
    required int personId,
    required int licenseClassId,
  });
  Future<bool> deactivateLicense({required int licenseId});
}
