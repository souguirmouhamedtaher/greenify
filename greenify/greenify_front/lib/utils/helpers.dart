import 'package:intl/intl.dart';

class Helpers {
  static bool isNameValid(String? name) {
    return RegExp(r'^[a-z A-Z\s]+$').hasMatch(name!);
  }

  static bool isForeNameValid(String? foreName) {
    return RegExp(r'^[a-z A-Z\s]+$').hasMatch(foreName!);
  }

  static bool isDateValid(String? date) {
    if (date == null || date.isEmpty) return false;
    try {
      DateTime bd = DateFormat("dd/MM/yyyy").parse(date);
      DateTime n = DateTime.now();
      int age = n.year - bd.year;
      if (n.month < bd.month || (n.month == bd.month && n.day < bd.day)) {
        age--;
      }
      if (age < 18) return false;
    } catch (e) {
      return false;
    }
    return true;
  }

  static bool isEmailValid(String? email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email!);
  }

  static bool isPhoneNumberValid(String? phoneNumber) {
    return RegExp(r'^[0-9]{8}$').hasMatch(phoneNumber!);
  }

  static bool hasPasswordMinimumLength(String? password) {
    return password!.length >= 8;
  }

  static bool hasPasswordUpperCase(String? password) {
    return RegExp(r'[A-Z]').hasMatch(password!);
  }

  static bool hasPasswordLowerCase(String? password) {
    return RegExp(r'[a-z]').hasMatch(password!);
  }

  static bool hasPasswordDigit(String? password) {
    return RegExp(r'[0-9]').hasMatch(password!);
  }

  String? validateName(String? value) {
    if (isNameValid(value)) {
      return null;
    } else {
      return "Nom invalide";
    }
  }

  String? validatePassword(String? value) {
    if (hasPasswordMinimumLength(value) &&
        hasPasswordUpperCase(value) &&
        hasPasswordLowerCase(value) &&
        hasPasswordDigit(value)) {
      return null;
    } else {
      return "Mot de passe invalide";
    }
  }

  String? validateForeName(String? value) {
    if (isForeNameValid(value)) {
      return null;
    } else {
      return "Prénom invalide";
    }
  }

  String? validatePhoneNumber(String? value) {
    if (isPhoneNumberValid(value)) {
      return null;
    } else {
      return "Numéro de téléphone invalide";
    }
  }

  String? validateBirthDate(String? value) {
    if (isDateValid(value)) {
      return null;
    } else {
      return "Doit etre plus que 18 ans";
    }
  }

  String? validateEmail(String? value) {
    if (isEmailValid(value)) {
      return null;
    } else {
      return "Email invalide";
    }
  }
}
