import 'dart:developer';

import 'package:echo_booking/core/constent/text/text_constend.dart';
import 'package:echo_booking/core/theme/colors.dart';
import 'package:echo_booking/core/until/validation.dart';
import 'package:echo_booking/feature/domain/auth_service.dart';
import 'package:echo_booking/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:echo_booking/feature/presentation/pages/sign_up/screen_sign_up.dart';
import 'package:echo_booking/feature/presentation/widgets/custom_button.dart';
import 'package:echo_booking/feature/presentation/widgets/heading_text.dart';
import 'package:echo_booking/feature/presentation/widgets/rich_text_widget.dart';
import 'package:echo_booking/feature/presentation/widgets/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  late TextEditingController _email;
  late TextEditingController _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = AuthService();


  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * .09),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: HeadingText(
                    text: appTitle,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: HeadingText(
                    text: "Welcome Back!",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Login to continue",
                    style: TextStyle(color: kWhite,fontSize: 16),
                  ),
                ),
                //E-mail----------------
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text(
                  textUserName,
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextFormFieldWidget(
                  validator: (value){
                    return Validation.emailValidation(value);
                  },
                  controller: _email,
                ),
            
                //password-------------
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Text(
                  textPassword,
                  style: TextStyle(
                      color: kWhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextFormFieldWidget(
                  validator: (value){
                    return Validation.passWordValidation(value);
                  },
                  controller: _password,
                ),
            
                SizedBox(
                  height: screenHeight * 0.10,
                ),
                //Login button------------
                Center(
                  child: CustomButton(
                    onTap:(){
                      if(_formKey.currentState!.validate()){
                        print(" Validated--------------------");
                        _signIn(context);
                      }else{
                        print("Not Validated--------------------");
                      }
                    },
                    screenWidth: screenWidth,
                    text: textLoginButton,
                  ),
                ),
                SizedBox(height: 08,),
                //Rich text --------------------------------
                Center(
                  child: RichTextWidget(
                    text: "Don’t have an account?",
                    eventText: "Sign up",
                    onTap: (){
                      Get.off(ScreenSignUp(),transition: Transition.cupertino);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void>_signIn(BuildContext context)async{
    final user = await _auth.signInUserWithEmailAndPassword(_email.text, _password.text,context);
    if(user!=null){
      log("successfully longed");
       Get.off(()=>ScreenHome(),transition: Transition.cupertino);
    }
  }
}
