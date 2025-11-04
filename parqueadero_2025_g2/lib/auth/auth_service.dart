import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl;
  AuthService({this.baseUrl = 'https://parking.visiontic.com.co/api'});

  Future<({String accessToken, String? refreshToken, String? name, String? email})> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      final data = jsonDecode(resp.body);
      final token = (data['access_token'] ?? data['token'] ?? '').toString();
      if (token.isEmpty) {
        throw Exception('La respuesta no contiene token');
      }
      final refresh = data['refresh_token']?.toString();
      final name = data['name']?.toString() ?? data['user']?['name']?.toString();
      final mail = data['email']?.toString() ?? data['user']?['email']?.toString() ?? email;

      return (accessToken: token, refreshToken: refresh, name: name, email: mail);
    }

    String message = 'Error ${resp.statusCode}';
    try {
      final data = jsonDecode(resp.body);
      message = data['message']?.toString() ?? message;
    } catch (_) {}
    throw Exception(message);
  }

  Future<({bool created, String? accessToken, String? refreshToken})> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users');
    final resp = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      try {
        final data = jsonDecode(resp.body);
        return (
          created: true,
          accessToken: data['access_token']?.toString() ?? data['token']?.toString(),
          refreshToken: data['refresh_token']?.toString(),
        );
      } catch (_) {
        return (created: true, accessToken: null, refreshToken: null);
      }
    }

    String message = 'No se pudo registrar (HTTP ${resp.statusCode})';
    try {
      final data = jsonDecode(resp.body);
      message = data['message']?.toString() ?? message;
    } catch (_) {}
    throw Exception(message);
  }
}
