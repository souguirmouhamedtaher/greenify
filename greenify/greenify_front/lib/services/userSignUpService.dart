import 'dart:convert';
import 'package:greenify_front/utils/constants.dart';
import 'package:http/http.dart' as http;

class userSignUpService {
  static final baseUrl = appConstants.apiUrl;

  static Future<bool> checkPhoneNumberExists(String phone) async {
    final response = await http.get(
      Uri.parse('$baseUrl/checkPhoneNumberExists?phoneNumber=$phone'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'] == true;
    } else {
      throw Exception('Failed to check phone number');
    }
  }

  static Future<bool> checkEmailExists(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/checkEmailExists?email=$email'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'] == true;
    } else {
      throw Exception('Failed to check email');
    }
  }

  static Future<bool> signUpUserWithoutEmail(Map<String, dynamic> user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/createUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'] ?? false;
      } else {
        print('Failed to sign up user: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception during signup: $e');
      return false;
    }
  }

  static Future<bool> addEmailToUser(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addEmailToUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      return false;
    }
    return true;
  }
}
