enum Gender {
  unknown(0),
  male(1),
  female(2);

  final int databaseValue;

  const Gender(this.databaseValue);

  factory Gender.fromInt(int value) {
    return Gender.values.firstWhere(
      (element) => element.databaseValue == value,
      orElse: () => Gender.unknown,
    );
  }
}
