import 'package:bangunkebun_dev/models/KontenPengguna.dart';
import 'package:bangunkebun_dev/providers/contentProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? username;

  List<KontenPengguna> dataArticles = [];
  List<KontenPengguna> dataVideos = [];

  ContentProvider _contentProvider = ContentProvider();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        username = prefs.getString('username');
        dataArticles = _contentProvider.dataArticles!;
        dataVideos = _contentProvider.dataVideos!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actionsPadding: const EdgeInsets.only(right: 20),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: MediaQuery.of(context).size.width * 0.5,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.sp,
                backgroundColor: Colors.black54,
                // child: Image(
                //   image: const AssetImage('assets/images/logo-hijau.png'),
                //   height: 40.sp,
                // ),
              ),
              SizedBox(width: 10.sp),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo,',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Color(0xFF828282),
                    ),
                  ),
                  Text(
                    '$username',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w700,
                      fontSize: 20.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Image(
            image: const AssetImage('assets/images/logo-hijau.png'),
            height: 40.sp,
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.h),
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              child: RefreshIndicator(
                onRefresh: () async {
                  await _contentProvider.getDataArticles();
                  setState(() {
                    dataArticles = _contentProvider.dataArticles ?? [];
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: const AssetImage(
                            'assets/images/homepage-img.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      clipBehavior: Clip.hardEdge,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    SizedBox(height: 20.h),
                    Text('Penuhi Kebutuhanmu'),
                    SizedBox(height: 10.h),

                    //Penuhi Kebutuhanmu
                    SizedBox(height: 20.h),
                    Text('Belajar Cara Bangun Kebunmu'),
                    SizedBox(height: 10.h),
                    //Container here
                    SizedBox(height: 20.h),
                    Text('Diskusi Bersama'),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.15,
              right: 10.w,
              child: FloatingActionButton(
                shape: const CircleBorder(
                  side: BorderSide(color: Colors.transparent),
                ),
                elevation: 2,
                backgroundColor: Color(0xFFF7AB0A),
                heroTag: 'chatbotbutton',
                onPressed: () {
                  Navigator.pushNamed(context, '/chatbotPage');
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image(
                    image: const AssetImage('assets/images/logo-ai-chat.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
