import 'package:bangunkebun_dev/pages/profilePage/widgets/profileMenuItem.dart';
import 'package:bangunkebun_dev/pages/storePages/storePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          icon: Icons.person_outline,
          title: 'Edit Profile',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Edit Profile tapped');
          },
        ),
        SizedBox(height: 8.h),
        ProfileMenuItem(
          icon: Icons.key_outlined,
          title: 'Ganti Password',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Ganti Password tapped');
          },
        ),
        SizedBox(height: 8.h),
        ProfileMenuItem(
          icon: Icons.location_on_outlined,
          title: 'Alamat',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Alamat tapped');
          },
        ),
        SizedBox(height: 8.h),
        ProfileMenuItem(
          icon: Icons.store_outlined,
          title: 'Toko',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Navigating to StorePage');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StorePage()),
            );
          },
        ),
        SizedBox(height: 8.h),
        ProfileMenuItem(
          icon: Icons.note,
          title: 'Pesanan Saya',
          iconColor: const Color(0xFF2E7D32),
          onTap: () {
            print('Pesanan Saya tapped');
          },
        ),
        SizedBox(height: 16.h),
        ProfileMenuItem(
          icon: Icons.logout,
          title: 'Logout',
          iconColor: Colors.red,
          textColor: Colors.red,
          showArrow: false,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
        SizedBox(height: 0.h),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Apakah Anda yakin ingin keluar?',
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 14.sp),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print('User logged out');
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.sp,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
