class AppRegex {
  static bool isEmailValid(String email) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(password);
  }

  static bool isNameValid(String name) {
    return RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
  }
}
