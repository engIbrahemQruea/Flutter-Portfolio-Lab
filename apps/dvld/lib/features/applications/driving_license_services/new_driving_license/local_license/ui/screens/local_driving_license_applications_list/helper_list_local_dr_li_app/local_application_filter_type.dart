import 'package:flutter/services.dart';

enum LocalApplicationFilterType {
  none('None'),
  lDLAppID('L.D.L.Application ID'),
  nationalNo('National No'),
  fullName('Fall Name'),
  status('Status');

  final String label;
  const LocalApplicationFilterType(this.label);
}

extension LocalApplicationFilterTypeX on LocalApplicationFilterType {
  TextInputType get keyboardType => switch (this) {
    LocalApplicationFilterType.lDLAppID =>
      const TextInputType.numberWithOptions(decimal: false),
    LocalApplicationFilterType.nationalNo => TextInputType.text,
    LocalApplicationFilterType.fullName => TextInputType.text,
    LocalApplicationFilterType.status => TextInputType.text,
    LocalApplicationFilterType.none => TextInputType.none,
  };

  List<TextInputFormatter> get inputFormatters => switch (this) {
    LocalApplicationFilterType.lDLAppID => [
      FilteringTextInputFormatter.digitsOnly,
    ],
    LocalApplicationFilterType.nationalNo => [
      FilteringTextInputFormatter.allow(
        // \p{L} أحرف عربية وإنجليزية
        // \p{N} أرقام إنجليزية (0-9) وعربية (٠-٩)
        // _ . - رموز شائعة في اسم المستخدم
        // \s مسافات
        RegExp(r'[\p{L}\p{N}_\.\-\s]', unicode: true),
      ),
    ],
    LocalApplicationFilterType.fullName => [
      FilteringTextInputFormatter.allow(
        // \p{L} أحرف عربية وإنجليزية
        // \s مسافات
        RegExp(r'[\p{L}\s]', unicode: true),
      ),
    ],
    LocalApplicationFilterType.status => [
      FilteringTextInputFormatter.allow(
        // \p{L} أحرف عربية وإنجليزية
        // \s مسافات
        RegExp(r'[\p{L}\s]', unicode: true),
      ),
    ],
    LocalApplicationFilterType.none => [],
  };
}
