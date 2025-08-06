import 'package:flutter/material.dart';
import 'package:bangunkebun_dev/services/otherService.dart';

class OtherProvider extends ChangeNotifier {
  final OtherService _otherService = OtherService();

  List<dynamic>? _dataJenisKonten;
  List<dynamic>? get dataJenisKonten => _dataJenisKonten;

  Future<void> getJenisKonten() async {
    _dataJenisKonten = await _otherService.getDataJenisKonten();
    notifyListeners();
  }

  List<dynamic>? _dataJenisProduk;
  List<dynamic>? get dataJenisProduk => _dataJenisProduk;

  Future<void> getJenisProduk() async {
    _dataJenisKonten = await _otherService.getDataJenisProduk();
    notifyListeners();
  }

  List<dynamic>? _dataProvinsi;
  List<dynamic>? get dataProvinsi => _dataProvinsi;

  Future<void> getProvinsi() async {
    _dataProvinsi = await _otherService.getDataProvinsi();
    notifyListeners();
  }

  List<dynamic>? _dataKabupatenByProvinsi;
  List<dynamic>? get dataKabupatenByProvinsi => _dataKabupatenByProvinsi;

  Future<void> getKabupatenByProvinsi(int idProvinsi) async {
    _dataKabupatenByProvinsi = await _otherService.getDataKabupatenByProvinsi(
      idProvinsi,
    );
    notifyListeners();
  }

  List<dynamic>? _dataKecamatanByKabupaten;
  List<dynamic>? get dataKecamatanByKabupaten => _dataKecamatanByKabupaten;

  Future<void> getKecamatanByKabupaten(int idKabupaten) async {
    _dataKecamatanByKabupaten = await _otherService.getDataKecamatanByKabupaten(
      idKabupaten,
    );
    notifyListeners();
  }
}
