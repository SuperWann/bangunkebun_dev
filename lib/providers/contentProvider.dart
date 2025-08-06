import 'package:flutter/material.dart';
import 'package:bangunkebun_dev/models/KontenPengguna.dart';
import 'package:bangunkebun_dev/models/konten.dart';
import 'package:bangunkebun_dev/services/contentService.dart';

class ContentProvider extends ChangeNotifier {
  final ContentService _contentService = ContentService();

  Future<bool> addKonten(Konten data) async {
    bool isSuccess = await _contentService.addKonten(data);
    notifyListeners();
    return isSuccess;
  }

  List<KontenPengguna>? _dataArticles;
  List<KontenPengguna>? get dataArticles => _dataArticles;

  Future<void> getDataArticles() async {
    _dataArticles = await _contentService.getDataArticles();
    notifyListeners();
  }

  List<KontenPengguna>? _dataVideos;
  List<KontenPengguna>? get dataVideos => _dataVideos;

  Future<void> getDataVideos() async {
    _dataVideos = await _contentService.getDataVideos();
    notifyListeners();
  }
}
