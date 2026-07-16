import 'package:dvld/core/database/init_table.dart';
import 'package:dvld/core/mapper_to_entity/data_mapper.dart';
import 'package:dvld/features/people/domain/entities/people_entity.dart';

class PeopleModels extends DataMapper<PeopleEntity> {
  final int? personId;
  final String nationalNo;
  final String firstName;
  final String secondName;
  final String? thirdName;
  final String lastName;
  final String dateOfBirth;
  final int gender;
  final String address;
  final String phone;
  final String? email;
  final int nationalityCountryId;
  final String? imagePath;

  PeopleModels({
    this.personId,
    required this.nationalNo,
    required this.firstName,
    required this.secondName,
    this.thirdName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phone,
    this.email,
    required this.nationalityCountryId,
    this.imagePath,
  });

  factory PeopleModels.fromJson(Map<String, dynamic> json) {
    return PeopleModels(
      personId: json[PersonTable.colId],
      nationalNo: json[PersonTable.colNationalNo],
      firstName: json[PersonTable.colFirstName],
      secondName: json[PersonTable.colSecondName],
      thirdName: json[PersonTable.colThirdName],
      lastName: json[PersonTable.colLastName],
      dateOfBirth: json[PersonTable.colDateOfBirth],
      gender: json[PersonTable.colGender],
      address: json[PersonTable.colAddress],
      phone: json[PersonTable.colPhone],
      email: json[PersonTable.colEmail],
      nationalityCountryId: json[PersonTable.colCountryId],
      imagePath: json[PersonTable.colImagePath],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      PersonTable.colId: personId,
      PersonTable.colNationalNo: nationalNo,
      PersonTable.colFirstName: firstName,
      PersonTable.colSecondName: secondName,
      PersonTable.colThirdName: thirdName,
      PersonTable.colLastName: lastName,
      PersonTable.colDateOfBirth: dateOfBirth,
      PersonTable.colGender: gender,
      PersonTable.colAddress: address,
      PersonTable.colPhone: phone,
      PersonTable.colEmail: email,
      PersonTable.colCountryId: nationalityCountryId,
      PersonTable.colImagePath: imagePath,
    };
  }

  @override
  PeopleEntity mapToEntity() {
    return PeopleEntity(
      personId: personId,
      nationalNo: nationalNo,
      firstName: firstName,
      secondName: secondName,
      thirdName: thirdName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      gender: gender,
      address: address,
      phone: phone,
      email: email,
      nationalityCountryId: nationalityCountryId,
      imagePath: imagePath,
    );
  }

  factory PeopleModels.fromEntity(PeopleEntity entity) {
    return PeopleModels(
      personId: entity.personId,
      nationalNo: entity.nationalNo,
      firstName: entity.firstName,
      secondName: entity.secondName,
      thirdName: entity.thirdName,
      lastName: entity.lastName,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      address: entity.address,
      phone: entity.phone,
      email: entity.email,
      nationalityCountryId: entity.nationalityCountryId,
      imagePath: entity.imagePath,
    );
  }
}
