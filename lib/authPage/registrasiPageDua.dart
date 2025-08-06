import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class RegistrasiPageDua extends StatelessWidget {
  static const routeName = '/registrasiPageDua';
  const RegistrasiPageDua({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    TextEditingController passwordController = TextEditingController();
    TextEditingController konfirmPasswordController = TextEditingController();

    bool isComplete() {
      return passwordController.text.isNotEmpty &&
          konfirmPasswordController.text.isNotEmpty;
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.white),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amankan akun anda!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 30.sp,
                ),
              ),
              Text(
                'Buat password yang kuat dan dapat anda diingat',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Color(0xFF828282),
                ),
              ),
              SizedBox(height: 40.h),
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
              SizedBox(height: 20.h),
              Text(
                'Konfirmasi Password',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),
              InputPassword(controller: konfirmPasswordController),

              SizedBox(height: 40.h),
              LongButton(
                text: 'Daftar',
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
                  } else if (passwordController.text.length < 8) {
                    Fluttertoast.showToast(
                      msg: "Password minimal 8 karakter",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                    );
                  } else if (passwordController.text !=
                      konfirmPasswordController.text) {
                    Fluttertoast.showToast(
                      msg: "Password tidak sama",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                    );
                  } else {
                    Navigator.pushNamed(
                      context,
                      '/registrasiPageTiga',
                      arguments: {
                        'email': args['email'],
                        'telepon': args['telepon'],
                        'namaLengkap': args['namaLengkap'],
                        'idKecamatan': args['idKecamatan'],
                        'password': passwordController.text,
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
