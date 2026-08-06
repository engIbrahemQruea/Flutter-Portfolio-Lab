/// Extensions for [String]

extension StringExtensionX on String {
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get toTitleCase => split(' ').map((word) => word.capitalize).join(' ');

  String get removeSpaces => replaceAll(' ', '');

  int? get toIntOrNull => int.tryParse(this);
  double? get toDoubleOrNull => double.tryParse(this);

  String get ellipsize {
    if (length <= 100) return this;
    return '${substring(0, 100)}...';
  }
}

extension StringValidationX on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool get isNotNullAndNotEmpty => !isNullOrEmpty;

  bool get isValidEmail {
    if (isNullOrEmpty) return false;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(this!);
  }

  bool get isValidPhone {
    if (isNullOrEmpty) return false;
    final phoneRegex = RegExp(r'^\+?[0-9]{8,15}$');
    return phoneRegex.hasMatch(this!);
  }

  bool get isValidPassword {
    if (isNullOrEmpty) return false;
    return this!.length >= 8;
  }

  bool get isValidStrongPassword {
    if (isNullOrEmpty) return false;
    final strongPasswordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return strongPasswordRegex.hasMatch(this!);
  }

  bool get isNumeric => double.tryParse(this ?? '') != null;
  bool get isValidUrl => Uri.tryParse(this ?? '')?.hasAbsolutePath ?? false;
}
