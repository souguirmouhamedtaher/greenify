import 'package:greenify_front/services/otpService.dart';

class otpRepository {
  Future<bool> sendOTP(String email, String phoneNumber) async {
    try {
      await otpService.sendOTP(email, phoneNumber);
      return true;
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String email, String otp) async {
    try {
      await otpService.verifyOTP(phoneNumber, email, otp);
      return true;
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
