import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bangunkebun_dev/config.dart';
import 'package:bangunkebun_dev/models/product.dart';

class ProductService {
  final String _baseUrl =
      '${ApiConfig.baseUrl}'
              '/Content'
          .trim();

  Future<bool> addProduct(Product data) async {
    final url = Uri.parse('$_baseUrl/createProduct');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data.toStore()),
    );

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Gagal membuat produk: ${response.body}');
  }

  Future<List<Product>> getDataProduct() async {
    final response = await http.get(Uri.parse('$_baseUrl/dataProduct'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData
          .map<Product>((json) => Product.fromJson(json))
          .toList();
    }
    throw Exception('Gagal fetch data produk: ${response.body}');
  }

}
