import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bangunkebun_dev/config.dart';
import 'package:bangunkebun_dev/models/pengguna.dart';

class AuthService {
  final String _baseUrl =
      '${ApiConfig.baseUrl}'
              '/Auth'
          .trim();

  Future<Pengguna?> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');

    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, dynamic>{"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Pengguna.fromJson(jsonData[0]);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<Pengguna> registration(Pengguna data) async {
    final url = Uri.parse('$_baseUrl/registration');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toStore()),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return Pengguna.fromJson(jsonData[0]);
    }
    throw Exception('Gagal membuat akun customer: ${response.body}');
  }
}
