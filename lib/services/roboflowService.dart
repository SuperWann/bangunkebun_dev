// lib/services/roboflow_service.dart
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';

class RoboflowService {
  static const String _baseUrl = 'https://serverless.roboflow.com';
  final Dio _dio = Dio();
  
  // API Configuration berdasarkan endpoint yang diberikan
  final String _apiKey = 'Olaf4EFdhnj84s1BaHwh';
  final String _modelEndpoint = 'chili-disease-afgra/12';
  
  Future<Map<String, dynamic>> detectDisease(File imageFile) async {
    try {
      // Konversi gambar ke base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      // Buat FormData untuk multipart request
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageBytes,
          filename: 'image.jpg',
        ),
      });
      
      // Buat request ke Roboflow serverless API
      final response = await _dio.post(
        '$_baseUrl/$_modelEndpoint',
        queryParameters: {
          'api_key': _apiKey,
          'confidence': 0.4, // threshold confidence
          'overlap': 0.3,
        },
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
          receiveTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 30),
        ),
      );
      
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception('Error ${e.response!.statusCode}: ${e.response!.data}');
        } else {
          throw Exception('Network error: ${e.message}');
        }
      }
      throw Exception('Gagal mendeteksi penyakit: $e');
    }
  }
  
  // Alternative method untuk menggunakan base64 jika multipart gagal
  Future<Map<String, dynamic>> detectDiseaseBase64(File imageFile) async {
    try {
      // Konversi gambar ke base64
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      
      // Buat request dengan base64 image
      final response = await _dio.post(
        '$_baseUrl/$_modelEndpoint',
        queryParameters: {
          'api_key': _apiKey,
          'confidence': 0.4,
          'overlap': 0.3,
        },
        data: {
          'image': 'data:image/jpeg;base64,$base64Image'
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          receiveTimeout: Duration(seconds: 30),
          sendTimeout: Duration(seconds: 30),
        ),
      );
      
      return response.data;
    } catch (e) {
      throw Exception('Gagal mendeteksi penyakit dengan base64: $e');
    }
  }
}