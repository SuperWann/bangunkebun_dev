import 'package:bangunkebun_dev/authPage/loginPage.dart';
import 'package:bangunkebun_dev/authPage/registrasiPage.dart';
import 'package:bangunkebun_dev/authPage/registrasiPageDua.dart';
import 'package:bangunkebun_dev/authPage/registrasiPageSatu.dart';
import 'package:bangunkebun_dev/authPage/registrasiPageTiga.dart';
import 'package:bangunkebun_dev/pages/chatbotPage/chatbotPage.dart';
import 'package:bangunkebun_dev/pages/contentPage/addContentPage.dart';
import 'package:bangunkebun_dev/pages/contentPage/detailContentPage.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/ecommercePage.dart';
import 'package:bangunkebun_dev/pages/navbar.dart';
import 'package:bangunkebun_dev/pages/scanPage/scanPage.dart';
import 'package:bangunkebun_dev/pages/starterPage/splashPage.dart';
import 'package:bangunkebun_dev/pages/starterPage/starterPageSatu.dart';
import 'package:bangunkebun_dev/providers/authProvider.dart';
import 'package:bangunkebun_dev/providers/chatbotProvider.dart';
import 'package:bangunkebun_dev/providers/contentProvider.dart';
import 'package:bangunkebun_dev/providers/ecommerceProvider.dart';
import 'package:bangunkebun_dev/providers/otherProvider.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await dotenv.load(fileName: ".env");
  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(
    cloudName: dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '',
    apiKey: dotenv.env['CLOUDINARY_API_KEY'] ?? '',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
        ChangeNotifierProvider(create: (_) => OtherProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ContentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
          routes: {
            //auth
            StarterPageSatu.routeName: (context) => StarterPageSatu(),
            LoginPage.routeName: (context) => LoginPage(),
            RegistrasiPage.routeName: (context) => RegistrasiPage(),
            RegistrasiPageSatu.routeName: (context) => RegistrasiPageSatu(),
            RegistrasiPageDua.routeName: (context) => RegistrasiPageDua(),
            RegistrasiPageTiga.routeName: (context) => RegistrasiPageTiga(),

            //main
            Navbar.routeName: (context) => Navbar(),
            ChatbotPage.routeName: (context) => ChatbotPage(),

            //content
            CreateContentPage.routeName: (context) => CreateContentPage(),
            DetailContentPage.routeName: (context) => DetailContentPage(),

            //Scan
            ScanPage.routeName: (context) => ScanPage(),
          },
        );
      },
    );
  }
}
