import 'package:greenify_front/utils/constants.dart';
import 'package:greenify_front/utils/helpers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OTPService {
  static final baseUrl = appConstants.apiUrl;
  final String sendGridApiKey = appConstants.sendGridApiKey;
  final String sendGridUrl = 'https://api.sendgrid.com/v3/mail/send';

  String generateOTP() {
    return Helpers().generateOTP();
  }

  Future<bool> sendOTP(String email, String otp) async {
    final response = await http.post(
      Uri.parse(sendGridUrl),
      headers: {
        'Authorization': 'Bearer $sendGridApiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'personalizations': [
          {
            'to': [
              {'email': email},
            ],
            'subject': 'Your OTP Code',
          },
        ],
        'from': {'email': 'mouhamed.taher.souguir.work@gmail.com'},
        'content': [
          {
            'type': 'text/plain',
            'value': 'Your OTP code is: $otp. It will expire in 5 minutes.',
          },
        ],
      }),
    );

    print('SendGrid Response Code: ${response.statusCode}');
    print('SendGrid Response Body: ${response.body}');

    if (response.statusCode != 202) {
      print('Error sending email: ${response.body}');
    }

    return response.statusCode == 202;
  }

  Future<bool> storeOTP(
    String email,
    String otp,
    DateTime expirationTime,
    String phoneNumber,
  ) async {
    // Delete any existing OTP for this phone number
    final deleteResponse = await http.post(
      Uri.parse('$baseUrl/deleteOTP'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    if (deleteResponse.statusCode != 200) {
      return false; // Failed to delete previous OTP
    }

    // Store the new OTP
    final storeResponse = await http.post(
      Uri.parse('$baseUrl/storeOTP'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'phoneNumber': phoneNumber,
        'email': email,
        'otp': otp,
        'expirationTime': expirationTime.toIso8601String(),
      }),
    );

    return storeResponse.statusCode == 200;
  }

  Future<bool> verifyOTP(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verifyOTP'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phoneNumber': phoneNumber}),
    );

    return response.statusCode == 200;
  }
}
