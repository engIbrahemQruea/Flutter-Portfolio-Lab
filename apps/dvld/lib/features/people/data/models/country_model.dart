import 'package:dvld/core/database/init_table.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/people/domain/entities/county_entity.dart';

class CountryModel extends DataMapper<CountyEntity> {
  final int countryId;
  final String countryName;

  CountryModel({required this.countryId, required this.countryName});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryId: json[CountryTable.colId],
      countryName: json[CountryTable.colName],
    );
  }

  Map<String, dynamic> toJson() {
    return {'countryId': countryId, 'countryName': countryName};
  }

  factory CountryModel.fromEntity(CountyEntity entity) {
    return CountryModel(
      countryId: entity.countryId,
      countryName: entity.countryName,
    );
  }

  @override
  CountyEntity mapToEntity() {
    return CountyEntity(countryId: countryId, countryName: countryName);
  }
}
