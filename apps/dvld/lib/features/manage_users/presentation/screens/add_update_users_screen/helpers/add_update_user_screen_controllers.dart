import 'package:dvld/features/manage_users/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class AddUpdateUserScreenControllers {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void initControllers(UserEntity? user) {
    if (user == null) return;
    userIdController.text = user.userID.toString();
    userNameController.text = user.userName;
    passwordController.text = user.password;
    confirmPasswordController.text = user.password;
  }

  void clearControllers() {
    userIdController.clear();
    userNameController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  void dispose() {
    userIdController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}