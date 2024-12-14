class Validators {
  static bool isValidEmail(String email) {
    final emailRegEx = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$");
    return emailRegEx.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}