import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/helper/constants.dart';
import 'package:tiktok_tutorial/views/signup_screen.dart';
import 'package:get/get.dart';

import 'package:tiktok_tutorial/widgets/text_input_field.dart';

import '../helper/dialog_helper.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _forgetEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 150, width: 150,),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.lock,
                  isObscure: true,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                  child: TextButton(onPressed: (){
                    Get.dialog(
                      Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                             const Text(
                                "Enter Email",
                              ),
                              const SizedBox(height: 10,),
                              TextInputField(controller: _forgetEmailController, labelText: 'Email', icon: Icons.email,),
                              const SizedBox(height: 10,),

                              ElevatedButton(onPressed:  () {
                                DialogHelper.showLoading();
                                authController.forgotPass(email: _forgetEmailController.text);
                              }, child: const Text('Reset Password'),)
                            ],
                          ),
                        ),
                      ),
                    );
                  }, child: const Text('Reset Password?'))),
              Container(
                margin:const EdgeInsets.only(left: 10, right: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => authController.loginUser(
                    _emailController.text,
                    _passwordController.text,
                  ),
                  child:const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(onPressed: (){
                    Get.to(() => SignupScreen());
                  }, child: const Text('Register', style: TextStyle(
                    fontSize: 20
                  ),)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
