import 'dart:convert';
import 'package:greenify_front/utils/constants.dart';
import 'package:http/http.dart' as http;

class userSignUpService {
  static final baseUrl = appConstants.apiUrl;

  Future<bool> checkPhoneNumberExists(String phone) async {
    final response = await http.get(
      Uri.parse('$baseUrl/check-phone?phone=$phone'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['exists'] == true;
    } else {
      throw Exception('Failed to check phone number');
    }
  }
}
