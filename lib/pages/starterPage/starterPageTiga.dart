import 'package:bangunkebun_dev/authPage/registrasiPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bangunkebun_dev/pages/starterPage/starterPageDua.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/customPageRoute.dart';

class StarterPageTiga extends StatefulWidget {
  static const routeName = '/starterPageTiga';

  const StarterPageTiga({super.key});

  @override
  State<StarterPageTiga> createState() => _StarterPageTigaState();
}

class _StarterPageTigaState extends State<StarterPageTiga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 60, bottom: 40, left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat datang di\nBangun Kebun!',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF828282),
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo-hijau.png',
                        height: 50.sp,
                      ),
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 40, bottom: 40),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(-5, 5),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/starterTiga.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Column(
                    children: [
                      Text(
                        'Belajar bagaimana membantu sesama dalam kebaikan.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 40.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'Menjembatani masyarakat untuk belajar, bertransaksi, dan berinteraksi dalam menjaga ketahanan pangan. (ganti)',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LongButtonWithOpacity(
                      text: "Kembali",
                      color: '#000000',
                      colorText: '#828282',
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageSlideRight(child: const StarterPageDua()),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LongButton(
                      text: "Lanjut",
                      color: '#007B29',
                      colorText: '#FFFFFF',
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setBool('isRead', true);

                        Navigator.pushAndRemoveUntil(
                          context,
                          PageSlideLeft(child: const RegistrasiPage()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
