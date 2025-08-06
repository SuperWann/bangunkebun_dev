import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListCommunityPage extends StatefulWidget {
  const ListCommunityPage({super.key});

  @override
  State<ListCommunityPage> createState() => _ListCommunityPageState();
}

class _ListCommunityPageState extends State<ListCommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.blue,
              child: Column(),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.16,
              right: 10.w,
              child: FloatingActionButton(
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                elevation: 2,
                heroTag: 'addarticlebutton',
                backgroundColor: Color(0xFFF7AB0A),
                onPressed: () {
                  Navigator.pushNamed(context, '/addCommunityPage');
                },
                child: const Icon(Icons.group_add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
