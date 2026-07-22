class PeopleEntity {
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

  PeopleEntity({
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

  String get fullName => '$firstName $secondName ${thirdName ?? ''} $lastName';
}
