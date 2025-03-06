import 'package:greenify_front/services/userSignUpService.dart';

class userRepository {
  final userSignUpService usus = userSignUpService();

  Future<bool> checkPhoneNumberExists(String phone) async {
    try {
      return await usus.checkPhoneNumberExists(phone);
    } catch (e) {
      throw Exception('Failed to check phone number: $e');
    }
  }
}
