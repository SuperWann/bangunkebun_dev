import 'package:bangunkebun_dev/pages/chatbotPage/chatbotPage.dart';
import 'package:bangunkebun_dev/pages/ecommercePage.dart/ecommercePage.dart';
import 'package:bangunkebun_dev/pages/navbar.dart';
import 'package:bangunkebun_dev/providers/chatbotProvider.dart';
import 'package:bangunkebun_dev/providers/ecommerceProvider.dart';
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
        ChangeNotifierProvider(create: (_) => EcommerceProvider()),
        ChangeNotifierProvider(create: (_) => ChatbotProvider()),
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
          home: Navbar(),
          routes: {
            Navbar.routeName: (context) => Navbar(),
            ChatbotPage.routeName: (context) => ChatbotPage(),
          },
        );
      },
    );
  }
}
