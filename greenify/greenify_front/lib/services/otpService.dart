import 'dart:convert';
import 'package:greenify_front/utils/constants.dart';
import 'package:http/http.dart' as http;

class otpService {
  static final baseUrl = appConstants.apiUrl;

  static Future<void> sendOTP(String email, String phoneNumber) async {
    final url = Uri.parse('$baseUrl/sendOTP');
    final body = json.encode({'email': email, 'phoneNumber': phoneNumber});
    try {
      final r = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (r.statusCode != 200) throw Exception('failed to send OTP');
    } catch (e) {
      throw Exception('error $e ');
    }
  }

  static Future<void> verifyOTP(
    String phoneNumber,
    String email,
    String otp,
  ) async {
    final url = Uri.parse('$baseUrl/verifyOTP');
    final body = json.encode({
      'phoneNumber': phoneNumber,
      'email': email,
      'otp': otp,
    });

    try {
      final r = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (r.statusCode != 200) throw Exception('failed to verify OTP');
    } catch (e) {
      throw Exception('error $e');
    }
  }
}
