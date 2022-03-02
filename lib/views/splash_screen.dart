import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_tutorial/views/update_image_screen.dart';

import '../helper/constants.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), (){
      if(firebaseAuth.currentUser != null){
        Get.offAll(() => const HomeScreen());
      }else{
        Get.offAll(() =>  LoginScreen());
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo.png', height: 150, width: 150,),
      ),
    );
  }
}
