import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_service.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Map<String, dynamic>> register(
      Map<String, dynamic> userDetails) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(userDetails),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<Map<String, String>> _getHeaders() async {
    String? token = await AuthService.getAccessToken();
    if (token == null) {
      throw Exception('Access token not found');
    }
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<List<Map<String, String>>> getTournaments() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/tournaments'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return List<Map<String, String>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load tournaments');
    }
  }

  Future<List<Map<String, String>>> getRegisteredEvents() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/registered-events'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return List<Map<String, String>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load registered events');
    }
  }

  Future<void> addEvent(Map<String, String> eventData) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/events'),
      headers: headers,
      body: jsonEncode(eventData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add event');
    }
  }

  Future<void> registerForTournament(String tournamentId) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/register-for-tournament/$tournamentId'),
      headers: headers,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register for the tournament');
    }
  }
}
