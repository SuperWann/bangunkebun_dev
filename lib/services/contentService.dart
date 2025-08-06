import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bangunkebun_dev/config.dart';
import 'package:bangunkebun_dev/models/KontenPengguna.dart';
import 'package:bangunkebun_dev/models/konten.dart';

class ContentService {
  final String _baseUrl =
      '${ApiConfig.baseUrl}'
              '/Content'
          .trim();

  Future<bool> addKonten(Konten data) async {
    final url = Uri.parse('$_baseUrl/createContent');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toStore()),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Gagal membuat konten: ${response.body}');
  }

  Future<List<KontenPengguna>> getDataArticles() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataArticles'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData
          .map<KontenPengguna>((json) => KontenPengguna.fromJson(json))
          .toList();
    }
    throw Exception('Gagal fetch data articles: ${response.body}');
  }

  Future<List<KontenPengguna>> getDataVideos() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataVideos'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData
          .map<KontenPengguna>((json) => KontenPengguna.fromJson(json))
          .toList();
    }
    throw Exception('Gagal fetch data videos: ${response.body}');
  }
}
