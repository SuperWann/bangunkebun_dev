import 'package:flutter/material.dart';

class ListContentPage extends StatefulWidget {
  const ListContentPage({super.key});

  @override
  State<ListContentPage> createState() => _ListContentPageState();
}

class _ListContentPageState extends State<ListContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('List Content Page')));
  }
}
