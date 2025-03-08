import 'package:greenify_front/repositories/otpRepository.dart';

class otpController {
  otpRepository otpr = otpRepository();

  Future<bool> sendOTP(String email, String phoneNumber) async {
    try {
      return await otpr.sendOTP(email, phoneNumber);
    } catch (e) {
      throw Exception('Failed to send OTP: $e');
    }
  }

  Future<bool> verifyOTP(String phoneNumber, String email, String otp) async {
    try {
      return otpr.verifyOTP(phoneNumber, email, otp);
    } catch (e) {
      throw Exception('Failed to verify OTP: $e');
    }
  }
}
