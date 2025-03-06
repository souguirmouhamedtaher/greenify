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
}
