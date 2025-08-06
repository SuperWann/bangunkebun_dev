import 'package:bangunkebun_dev/pages/chatbotPage/chatbotPage.dart';
import 'package:bangunkebun_dev/pages/scan/scanPage.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/ecommercePage.dart';
import 'package:bangunkebun_dev/pages/navbar.dart';
import 'package:bangunkebun_dev/providers/ecommerceProvider.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => EcommerceProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ChatbotPage());
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: EcommercePage(),
          routes: {Navbar.routeName: (context) => Navbar()},
        );
      },
    );
  }
}

