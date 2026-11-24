enum Gender {
  male(0),
  female(1),
  unknown(2);

  final int databaseValue;

  const Gender(this.databaseValue);

  factory Gender.fromInt(int value) {
    return Gender.values.firstWhere(
      (element) => element.databaseValue == value,
      orElse: () => Gender.unknown,
    );
  }
}
