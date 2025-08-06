import 'package:flutter/material.dart';
import 'package:bangunkebun_dev/pages/starterPage/starterPageDua.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/customPageRoute.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StarterPageSatu extends StatelessWidget {
  static const routeName = '/starterPageSatu';

  const StarterPageSatu({super.key});

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
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Color(0xFF828282),
                        ),
                      ),
                      Image.asset(
                        'assets/images/logo-hijau.png',
                        height: 40.sp,
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
                      'assets/images/starterSatu.jpg',
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Column(
                    children: [
                      Text(
                        'Belajar bagaimana membangun kebunmu sendiri.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 30.sp,
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

              LongButton(
                text: "Lanjut",
                color: '#007B29',
                colorText: '#FFFFFF',
                onPressed: () {
                  Navigator.push(
                    context,
                    PageSlideLeft(child: StarterPageDua()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
