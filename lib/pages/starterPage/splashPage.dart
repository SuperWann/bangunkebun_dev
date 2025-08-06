// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Cek apakah widget masih mounted sebelum melanjutkan
      if (!mounted) return;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      bool isRead = prefs.getBool('isRead') ?? false;
      int idUser = prefs.getInt('idUser') ?? 0;

      // Debug print untuk troubleshooting (opsional)
      // print('isLoggedIn: $isLoggedIn');
      // print('isRead: $isRead');
      // print('idUser: $idUser');

      // Cek mounted lagi sebelum navigation
      if (!mounted) return;

      if (isLoggedIn && idUser > 0) {
        Navigator.pushReplacementNamed(context, '/navbar');
      } else if (!isRead) {
        Navigator.pushReplacementNamed(context, '/starterPageSatu');
      } else {
        Navigator.pushReplacementNamed(context, '/loginPage');
      }
    } catch (e) {
      print('Error in splash initialization: $e');

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/loginPage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              'assets/images/bg-splash.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.12,
              child: Image.asset('assets/images/logo-nama.png'),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
            child: Text(
              'Menjembatani masyarakat untuk belajar, bertransaksi, dan berinteraksi dalam menjaga ketahanan pangan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
