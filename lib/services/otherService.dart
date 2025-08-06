import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bangunkebun_dev/config.dart';

class OtherService {
  final String _baseUrl =
      '${ApiConfig.baseUrl}'
              '/Other'
          .trim();

  Future<List<dynamic>> getDataJenisKonten() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataJenisKonten'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }

    Future<List<dynamic>> getDataJenisProduk() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataJenisProduk'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }


  Future<List<dynamic>> getDataProvinsi() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataProvinsi'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getDataKabupatenByProvinsi(int idProvinsi) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/dataKabupatenByProvinsi/$idProvinsi'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getDataKecamatanByKabupaten(int idKabupaten) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/dataKecamatanByKabupaten/$idKabupaten'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }
}
