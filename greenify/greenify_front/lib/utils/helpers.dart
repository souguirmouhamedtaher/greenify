class Helpers {
  static bool isNameValid(String name) {
    return RegExp(r'^[a-z A-Z\s]+$').hasMatch(name);
  }
}
