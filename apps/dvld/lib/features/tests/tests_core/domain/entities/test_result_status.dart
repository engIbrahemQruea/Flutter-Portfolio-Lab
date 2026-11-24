
enum TestResult {
  fail(0, 'راسب', 'Fail'),
  pass(1, 'ناجح', 'Pass');

  final int value;
  final String labelAr;
  final String labelEn;

  const TestResult(this.value, this.labelAr, this.labelEn);

  factory TestResult.fromValue(int value) {
    return switch (value) {
      1 => TestResult.pass,
      0 => TestResult.fail,
      _ => throw ArgumentError(' Value of TestResult not correct : $value'),
    };
  }

  bool get isPassed => this == TestResult.pass;
}
