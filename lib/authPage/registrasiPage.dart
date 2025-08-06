import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class RegistrasiPage extends StatelessWidget {
  static const routeName = '/registrasiPage';

  const RegistrasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController teleponController = TextEditingController();
    TextEditingController namaLengkapController = TextEditingController();

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

    bool isComplete() {
      return emailController.text.isNotEmpty &&
          teleponController.text.isNotEmpty &&
          namaLengkapController.text.isNotEmpty;
    }

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftarkan diri anda',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 30.sp,
                  ),
                ),
                Text(
                  'Masukkan data diri',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Color(0xFF828282),
                  ),
                ),
                SizedBox(height: 40.h),
                Text(
                  'Nama Lengkap',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                InputFormWithHintText(
                  type: TextInputType.text,
                  text: 'Masukkan Nama Lengkap',
                  controller: namaLengkapController,
                ),
                SizedBox(height: 20.h),
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
                  'Nomor Telepon',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                InputFormWithHintText(
                  type: TextInputType.emailAddress,
                  text: 'Masukkan Nomor Telepon',
                  controller: teleponController,
                ),
                SizedBox(height: 40.h),
                LongButton(
                  text: 'Lanjutkan',
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
                      Navigator.pushNamed(
                        context,
                        '/registrasiPageSatu',
                        arguments: {
                          'email': emailController.text,
                          'telepon': teleponController.text,
                          'namaLengkap': namaLengkapController.text,
                        },
                      );
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/loginPage');
                      },
                      child: const Text(
                        'Masuk',
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
