import 'package:flutter/material.dart';
import 'package:bangunkebun_dev/models/product.dart';
import 'package:bangunkebun_dev/services/productService.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _productService = ProductService();

  Future<bool> addProduct(Product data) async {
    bool isSuccess = await _productService.addProduct(data);
    notifyListeners();
    return isSuccess;
  }

  List<Product>? _dataProduct;
  List<Product>? get dataProduct => _dataProduct;

  Future<void> getDataProduct() async {
    _dataProduct = await _productService.getDataProduct();
    notifyListeners();
  }

}
