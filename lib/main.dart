import 'package:bangunkebun_dev/pages/chatbotPage/chatbotPage.dart';
import 'package:bangunkebun_dev/pages/scan/scanPage.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ChatbotPage());
  }
}
