import 'package:greenify_front/services/userSignUpService.dart';

class userRepository {
  Future<bool> checkPhoneNumberExists(String phone) async {
    try {
      return await userSignUpService.checkPhoneNumberExists(phone);
    } catch (e) {
      throw Exception('Failed to check phone number: $e');
    }
  }
}
