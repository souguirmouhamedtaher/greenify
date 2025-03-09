import 'package:greenify_front/repositories/userRepository.dart';

class userSignUpController {
  final userRepository ur = userRepository();

  Future<bool> checkPhoneNumberExists(String phone) async {
    try {
      return await ur.checkPhoneNumberExists(phone);
    } catch (e) {
      throw Exception('Failed to check phone number: $e');
    }
  }

  Future<bool> checkEmailExists(String email) async {
    try {
      return await ur.checkEmailExists(email);
    } catch (e) {
      throw Exception('Failed to check email: $e');
    }
  }

  Future<bool> signUpUserWithoutEmail(Map<String, dynamic> user) async {
    try {
      return await ur.signUpUserWithoutEmail(user);
    } catch (e) {
      throw Exception('Failed to sign up user: $e');
    }
  }

  Future<bool> addEmailToUser(String email) async {
    try {
      return await ur.addEmailToUser(email);
    } catch (e) {
      throw Exception('Failed to add email to user: $e');
    }
  }
}
