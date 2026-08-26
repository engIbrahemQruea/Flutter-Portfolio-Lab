enum EnumApplicationTypes {
  newLocalDrivingLicense(1),
  renewLocalDrivingLicense(2),
  replacementForLostLocalDrivingLicense(3),
  replacementForDamagedLocalDrivingLicense(4),
  releaseDetainedLocalDrivingLicense(5),
  newInternationalDrivingLicense(6),
  retakeTest(7);

  final int value;
  const EnumApplicationTypes(this.value);

  factory EnumApplicationTypes.fromValue(int value) {
    return switch (value) {
      1 => EnumApplicationTypes.newLocalDrivingLicense,
      2 => EnumApplicationTypes.renewLocalDrivingLicense,
      3 => EnumApplicationTypes.replacementForLostLocalDrivingLicense,
      4 => EnumApplicationTypes.replacementForDamagedLocalDrivingLicense,
      5 => EnumApplicationTypes.releaseDetainedLocalDrivingLicense,
      6 => EnumApplicationTypes.newInternationalDrivingLicense,
      7 => EnumApplicationTypes.retakeTest,
      _ => throw ArgumentError(
        ' Value of EnumApplicationTypes not correct : $value',
      ),
    };
  }
}
