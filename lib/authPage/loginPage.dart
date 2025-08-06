import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bangunkebun_dev/models/pengguna.dart';
import 'package:bangunkebun_dev/providers/authProvider.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/dialog.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthProvider _authProvider = AuthProvider();

  Pengguna? dataPengguna;

  bool isComplete() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void login(String email, String password) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await _authProvider.login(email, password);
      Navigator.pop(context);

      dataPengguna = _authProvider.dataPengguna!;

      if (dataPengguna == null) {
        showDialog(
          context: context,
          builder:
              (context) => YesDialog(
                title: 'Login Gagal',
                content: 'Email atau Password Salah!',
                onYes: () => Navigator.pop(context),
              ),
        );
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setInt('idUser', dataPengguna!.iduser!);
      await prefs.setString('username', dataPengguna!.username!);
      Navigator.pushReplacementNamed(context, '/navbar');
    } catch (e) {
      Navigator.pop(context);
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var index = 0;

    Future<bool> _onWillPop() async {
      if (index == 0) {
        Fluttertoast.showToast(
          msg: "Tekan sekali lagi untuk keluar",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF828282).withOpacity(0.8),
          textColor: Colors.white,
          fontSize: 16.0,
          fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
        );
        index++;

        Future.delayed(const Duration(seconds: 5), () {
          index = 0;
        });

        return false;
      } else {
        SystemNavigator.pop();
        return true;
      }
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: false),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                  ),
                ),
                Text(
                  'Masukkan data diri kamu',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Color(0xFF828282),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                InputFormWithHintText(
                  type: TextInputType.emailAddress,
                  text: 'Masukkan Email',
                  controller: emailController,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                InputPassword(controller: passwordController),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lupa Password?',
                      style: TextStyle(
                        color: Color(0xFF007B29),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                LongButton(
                  text: 'Masuk',
                  color: '007B29',
                  colorText: 'FFFFFF',
                  onPressed: () {
                    if (!isComplete()) {
                      Fluttertoast.showToast(
                        msg: "Data belum lengkap",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                      );
                    } else {
                      login(
                        emailController.text.trim(),
                        passwordController.text.trim(),
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/registrasiPage',
                        );
                      },
                      child: const Text(
                        'Daftar',
                        style: TextStyle(
                          color: Color(0xFF007B29),
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
