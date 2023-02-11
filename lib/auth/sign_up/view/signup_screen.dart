import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/login/view/login_screen.dart';
import 'package:new_yellow/auth/sign_up/controller/signup_controller.dart';
import 'package:new_yellow/auth/sign_up/view/signup_password_screen.dart';
import 'package:new_yellow/auth/welcome_screen/welcome_screen.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({this.name, this.date});
    final name;
    final date;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
     final signupController = Get.put(SignUpController());


   @override
   Widget build(BuildContext context) {
     return Scaffold(
         backgroundColor: Colors.white,
         body: Hero(
           tag: "hero_anim_3",
           child: Form(
             key: signupController.formKey,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(
                   height: 80,
                 ),
                 Container(
                   height: 34,
                   width: 93,
                   color: Color(0xffF7D117),
                   child: Center(
                     child: Text(
                       "yllow",
                       style: GoogleFonts.inter(
                           color: Colors.black,
                           fontSize: 24,
                           fontWeight: FontWeight.w700),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height * 0.053,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 30, right: 30),
                   child: Text(
                     "Create an account using your email...",
                     textAlign: TextAlign.center,
                     style: GoogleFonts.inter(
                         color: Colors.black,
                         fontSize: 24,
                         fontWeight: FontWeight.w700),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 28, right: 28, top: 50),
                   child: Container(
                     height: 54,
                     child: TextFormField(
                       controller:signupController.emailEditingController ,
                       onChanged: (val) {
                         signupController.isButtonClrChng.value = true;
                       },
                       validator: (val) {
                         return val!.isEmpty || val.length < 2
                             ? "Enter Correct Email"
                             : null;
                       },
                       textAlign: TextAlign.center,
                       cursorColor: Color(0xff999999),
                       style: GoogleFonts.inter(
                           color: Colors.black,
                           fontSize: 24,
                           fontWeight: FontWeight.w700),

                       decoration: InputDecoration(
                         contentPadding: EdgeInsets.only(top: 10),
                         border: InputBorder.none,
                         hintText: 'Enter Email',
                         hintStyle: GoogleFonts.inter(
                             fontSize: 30,
                             fontWeight: FontWeight.w700,
                             color: Color(0xff999999)),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0),
                           borderSide: BorderSide(
                             color: Colors.white,
                           ),
                         ),
                       ),

                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
         bottomNavigationBar:
        Obx(() =>  signupController.isLoading.value ? Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CircularProgressIndicator()) :  Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child:
            Container(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      log("name: "+ widget.name.toString());
                      log("email: "+ signupController.emailEditingController.text);
                      log("password: "+  signupController.passwordEditingController.text);
                      log("phone: "+widget.date.toString());
                      if(signupController.formKey.currentState!.validate()){
                      Get.to(()=>SignUpPasswordScreen(
                        name: widget.name,
                        date: widget.date,
                        email: signupController.emailEditingController.text,
                      ));
                      }

                      // if(signupController.formKey.currentState!.validate()) {
                      //   Get.offAll(()=>WelcomeScreen());
                      // }
                    },
                    child: Container(
                      height: 58,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.transparent
                      ),
                      child: Text(
                        "Continue",
                        style: GoogleFonts.inter(
                            color: signupController.isButtonClrChng.value
                                ? Colors.black
                                : Color(0xff999999),
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAll(LoginScreen());
                    },
                    child: Center(
                      child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Already have account?",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                TextSpan(
                                  text: " SIGN IN",
                                ),
                              ])),
                    ),
                  ),
                ],
              ),
            ),
        )));
   }
}
