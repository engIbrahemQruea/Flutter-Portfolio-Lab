class ValidationFineFeesField {
  final double value;
  const ValidationFineFeesField._(this.value);

  static String? validate(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return 'Fine Fees is required !';
    }
    final parsed = double.tryParse(raw.trim());
    if (parsed == null) return 'Fine Fees is invalid.';
    if (parsed <= 0) {
      return '    Fine Fees must be greater than zero.';
    }
    return null;
  }

  static ValidationFineFeesField? parse(String raw) {
    final v = double.tryParse(raw.trim());
    return v != null && v > 0 ? ValidationFineFeesField._(v) : null;
  }
}
