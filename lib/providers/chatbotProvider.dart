import 'dart:convert';

import 'package:bangunkebun_dev/models/geminiResponse.dart';
import 'package:bangunkebun_dev/models/percakapan.dart';
import 'package:bangunkebun_dev/services/chatbotService.dart';
import 'package:flutter/material.dart';

class ChatbotProvider extends ChangeNotifier {
  final ChatbotService chatbotService = ChatbotService();

  List<ModelPercakapan>? _percakapan;
  List<ModelPercakapan>? get percakapan => _percakapan;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getAllPercakapan() async {
    _percakapan = await chatbotService.getAllPercakapan();
    notifyListeners();
  }

  Future<void> sendPertanyaan(String pertanyaan, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      await chatbotService.insertPercakapan(
        ModelPercakapan(senderType: 'user', pesan: pertanyaan),
      );
      await getAllPercakapan();
      final response = await chatbotService.requestGemini(pertanyaan);
      if (response.statusCode == 200) {
        final geminiResponse = GeminiResponse.fromJson(
          json.decode(response.body),
        );
        await chatbotService.insertPercakapan(
          ModelPercakapan(
            senderType: 'bot',
            pesan: geminiResponse.getFirstText(),
          ),
        );

        await getAllPercakapan();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal mendapatkan response dari bot'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      print('Error: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi Kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addMessageLocally(ModelPercakapan message){
    if(_percakapan != null){
      _percakapan!.add(message);
      notifyListeners();
    }
  }

  Future<void> clearChat() async {
    _percakapan?.clear();
    chatbotService.deleteAllPercakapan();
    notifyListeners();
  }
}
