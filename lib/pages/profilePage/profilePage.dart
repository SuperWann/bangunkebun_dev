import 'package:bangunkebun_dev/pages/profilePage/widgets/profileHeader.dart';
import 'package:bangunkebun_dev/pages/profilePage/widgets/profileMenuList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: const Color(
          0xFFFAFAFA,
        ), 
        statusBarIconBrightness: Brightness.dark, // Ikon gelap untuk Android
        statusBarBrightness: Brightness.light, // Ikon gelap untuk iOS
        systemStatusBarContrastEnforced: false,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA), // Sama dengan EcommercePage
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: const Color(0xFFFAFAFA), // Header seperti EcommercePage
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 120.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const ProfileHeader(),
                      SizedBox(height: 24.h),
                      const ProfileMenuList(),
                    ],
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