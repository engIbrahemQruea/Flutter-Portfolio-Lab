import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/licenses/detain_licenses/data/data_sources/detain_licenses_view_table.dart';
import 'package:dvld/features/licenses/detain_licenses/domain/entities/read_entity/detain_license_item_entity.dart';

class DetainLicenseItemModel extends DataMapper<DetainLicenseItemEntity> {
  final int detainID;
  final int licenseID;
  final DateTime detainDate;
  final bool isReleased;
  final double fineFees;
  final DateTime? releaseDate;
  final String nationalNo;
  final int personID;
  final String fullName;
  final int? releaseApplicationID;

  DetainLicenseItemModel({
    required this.detainID,
    required this.licenseID,
    required this.detainDate,
    required this.isReleased,
    required this.fineFees,
    this.releaseDate,
    required this.nationalNo,
    required this.personID,
    required this.fullName,
    this.releaseApplicationID,
  });

  factory DetainLicenseItemModel.fromMap(Map<String, dynamic> map) {
    return DetainLicenseItemModel(
      detainID: map[DetainedLicensesView.colDetainID] as int,
      licenseID: map[DetainedLicensesView.colLicenseID] as int,
      detainDate: DateTime.parse(
        map[DetainedLicensesView.colDetainDate] as String,
      ),
      isReleased: switch (map[DetainedLicensesView.colIsReleased]) {
        1 || true => true,
        _ => false,
      },
      fineFees: (map[DetainedLicensesView.colFineFees] as num).toDouble(),
      releaseDate: map[DetainedLicensesView.colReleaseDate] != null
          ? DateTime.parse(map[DetainedLicensesView.colReleaseDate] as String)
          : null,
      nationalNo: map[DetainedLicensesView.colNationalNo] as String,
      personID: map[DetainedLicensesView.colPersonID] as int,
      fullName: map[DetainedLicensesView.colFullName] as String,
      releaseApplicationID:
          map[DetainedLicensesView.colReleaseApplicationID] != null
          ? map[DetainedLicensesView.colReleaseApplicationID] as int
          : null,
    );
  }

  @override
  DetainLicenseItemEntity mapToEntity() {
    return DetainLicenseItemEntity(
      detainID: detainID,
      licenseID: licenseID,
      detainDate: detainDate,
      isReleased: isReleased,
      fineFees: fineFees,
      releaseDate: releaseDate,
      nationalNo: nationalNo,
      personID: personID,
      fullName: fullName,
      releaseApplicationID: releaseApplicationID,
    );
  }
}
