class Helpers {
  static bool isNameValid(String name) {
    return RegExp(r'^[a-z A-Z\s]+$').hasMatch(name);
  }
  static bool isForeNameValid(String foreName){
    return RegExp(r'^[a-z A-Z\s]+$').hasMatch(foreName);
  }
  static bool isEmailValid(String email) {
    return RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+').hasMatch(email);
  }
  static bool isPhoneNumberValid(String phoneNumber) {
    return RegExp(r'^[0-9]{8}$').hasMatch(phoneNumber);
  }
  static bool hasPasswordMinimumLength(String password) {
    return password.length >= 8;
  }
  static bool hasPasswordUpperCase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }
  static bool hasPasswordLowerCase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }
  static bool hasPasswordDigit(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

}
