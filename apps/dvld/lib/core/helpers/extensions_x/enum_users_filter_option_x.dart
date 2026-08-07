import 'package:dvld/features/manage_users/presentation/helpers/enum_users_filter_option.dart';
import 'package:flutter/services.dart';

extension EnUsersFilterOptionX on EnUsersFilterOption {
  TextInputType get keyboardType => switch (this) {
    EnUsersFilterOption.userID || EnUsersFilterOption.personID =>
      const TextInputType.numberWithOptions(decimal: false),
    EnUsersFilterOption.userName => TextInputType.text,
    EnUsersFilterOption.password => TextInputType.visiblePassword,
    EnUsersFilterOption.isActive ||
    EnUsersFilterOption.none => TextInputType.none,
  };

  List<TextInputFormatter> get inputFormatters => switch (this) {
    EnUsersFilterOption.userID ||
    EnUsersFilterOption.personID => [FilteringTextInputFormatter.digitsOnly],
    EnUsersFilterOption.userName => [
      FilteringTextInputFormatter.allow(
        // \p{L} أحرف عربية وإنجليزية
        // \p{N} أرقام إنجليزية (0-9) وعربية (٠-٩)
        // _ . - رموز شائعة في اسم المستخدم
        // \s مسافات
        RegExp(r'[\p{L}\p{N}_\.\-\s]', unicode: true),
      ),
    ],
    EnUsersFilterOption.isActive ||
    EnUsersFilterOption.password ||
    EnUsersFilterOption.none => [],
  };
}
