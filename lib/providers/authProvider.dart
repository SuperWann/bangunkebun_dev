import 'package:flutter/material.dart';
import 'package:bangunkebun_dev/models/pengguna.dart';
import 'package:bangunkebun_dev/services/authService.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  Pengguna? _dataPengguna;
  Pengguna? get dataPengguna => _dataPengguna;

  Future<void> login(String email, String password) async {
    _dataPengguna = await _authService.login(email, password);
    notifyListeners();
  }

  Future<void> registration(Pengguna data, BuildContext context) async {
    _dataPengguna = await _authService.registration(data);
    notifyListeners();
  }
}
