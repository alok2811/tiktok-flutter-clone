import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_tutorial/helper/constants.dart';
import 'package:tiktok_tutorial/views/splash_screen.dart';

import 'controllers/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
          colorScheme: const ColorScheme.light().copyWith(primary: Colors.red),
        primaryColor: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
                textStyle: const TextStyle(color: Colors.white) )),
        textTheme: TextTheme(
          headline1: GoogleFonts.faustina(fontWeight: FontWeight.bold, fontSize: 20, color:  Colors.white),
          bodyText1: GoogleFonts.faustina(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
          bodyText2: GoogleFonts.faustina(fontWeight: FontWeight.w200, fontSize: 14, color: Colors.white),
        )
      ),
      home: const SplashScreen(),
    );
  }
}
