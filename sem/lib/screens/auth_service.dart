import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _tokenKey = 'access_token';

  static Future<void> login(String username, String password) async {
    // Call API to authenticate user and get access token
    String accessToken = 'example_access_token'; // Replace with actual token

    // Save access token to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, accessToken);
  }

  static Future<void> logout() async {
    // Clear access token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
}
