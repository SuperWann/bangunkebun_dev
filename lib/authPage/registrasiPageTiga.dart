import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bangunkebun_dev/models/pengguna.dart';
import 'package:bangunkebun_dev/providers/authProvider.dart';
import 'package:bangunkebun_dev/widgets/button.dart';
import 'package:bangunkebun_dev/widgets/inputForm.dart';

class RegistrasiPageTiga extends StatefulWidget {
  static const routeName = '/registrasiPageTiga';

  const RegistrasiPageTiga({super.key});

  @override
  State<RegistrasiPageTiga> createState() => _RegistrasiPageTigaState();
}

class _RegistrasiPageTigaState extends State<RegistrasiPageTiga> {
  TextEditingController usernameController = TextEditingController();
  Pengguna? dataPengguna;

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Panggilan akrab anda?',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 30.sp,
                ),
              ),
              Text(
                'Tentukan username atau nama panggilan',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Color(0xFF828282),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                'Username',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 10.h),
              InputFormWithHintText(
                type: TextInputType.text,
                text: 'Masukkan Username',
                controller: usernameController,
              ),
              SizedBox(height: 40.h),
              LongButton(
                text: 'Daftar',
                color: '007B29',
                colorText: 'FFFFFF',
                onPressed: () async {
                  if (usernameController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Data belum diisi",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                    );
                  } else if (usernameController.text.length < 6 &&
                      usernameController.text.length > 10) {
                    Fluttertoast.showToast(
                      msg: "Username minimal 6 dan maksimal 10 karakter",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                    );
                  } else {
                    dataPengguna = Pengguna(
                      // iduser: 0,
                      username: usernameController.text,
                      password: args['password'],
                      email: args['email'],
                      noTelepon: args['telepon'],
                      namaLengkap: args['namaLengkap'],
                      idKecamatan: args['idKecamatan'],
                    );

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (context) =>
                              const Center(child: CircularProgressIndicator()),
                    );

                    await authProvider.registration(dataPengguna!, context);

                    final data = authProvider.dataPengguna;

                    if (data == null) {
                      Fluttertoast.showToast(
                        msg: "Gagal membuat akun customer",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                        fontAsset: 'assets/fonts/Montserrat-Medium.ttf',
                      );
                    }

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    await prefs.setBool('isLoggedIn', true);
                    await prefs.setString('username', dataPengguna!.username!);
                    await prefs.setInt('idUser', dataPengguna!.iduser!);

                    print(prefs.getString('username'));
                    print(prefs.getBool('isLoggedIn'));
                    Navigator.pop(context);

                    Navigator.pushReplacementNamed(context, '/navbar');
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
