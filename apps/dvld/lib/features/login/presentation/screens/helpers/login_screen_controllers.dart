import 'package:dvld/features/login/domain/entities/login_entity.dart';
import 'package:flutter/material.dart';

class LoginScreenControllers {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void initControllers(LoginEntity? loginEntity) {
    if (loginEntity == null) return;

    userNameController.text = loginEntity.userName;
    passwordController.text = loginEntity.password;
  }

  void clearControllers() {
    formKey.currentState?.reset();
    userNameController.clear();
    passwordController.clear();
  }

  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
  }
}
