import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/login/controller/login_controller.dart';
import 'package:new_yellow/auth/login/view/login_password_screen.dart';
import 'package:new_yellow/auth/sign_up/controller/signup_controller.dart';
import 'package:new_yellow/auth/sign_up/view/name_screen.dart';
import 'package:new_yellow/auth/sign_up/view/signup_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);

   final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: loginController.loginFormKey,
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
                  "Welcome back! Please sign in with your email...",
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
                    controller:loginController.emailController ,
                    onChanged: (val) {
                      loginController.isButtonClrChng.value = true;
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.053,
              // ),
              //
              //
              // Padding(
              //   padding: const EdgeInsets.only(left: 28, right: 28, top: 30),
              //   child: Container(
              //     height: 54,
              //     child: TextFormField(
              //       controller: loginController.passwordController,
              //       onChanged: (val) {
              //         loginController.isButtonClrChng.value = true;
              //       },
              //       validator: (val) {
              //         return val!.isEmpty || val.length < 2
              //             ? "Password Should be Greater then 2"
              //             : null;
              //       },
              //       textAlign: TextAlign.center,
              //       cursorColor: Color(0xff999999),
              //       style: GoogleFonts.inter(
              //           fontSize: 26,
              //           fontWeight: FontWeight.w700,
              //           color: Colors.black),
              //       decoration: InputDecoration(
              //         contentPadding: EdgeInsets.only(top: 10),
              //         border: InputBorder.none,
              //         hintText: 'Password',
              //         hintStyle: GoogleFonts.inter(
              //             fontSize: 30,
              //             fontWeight: FontWeight.w700,
              //             color: Color(0xff999999)),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10.0),
              //           borderSide: BorderSide(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar:
        Obx(() =>  loginController.isLoading.value ? Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            child: CircularProgressIndicator()) :  Padding(
          padding:  EdgeInsets.only(left: 24, right: 24),
          child:
          Container(
            height: 120,
            child: Column(
              children: [
                InkWell(
                  onTap: (){

                      if(loginController.loginFormKey.currentState!.validate()){
                        Get.to(()=>LoginPasswordScreen(email: loginController.emailController.text,));
                      }

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
                          color: loginController.isButtonClrChng.value
                              ? Colors.black
                              : Color(0xff999999),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => NameRegistration());
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
                                  text: "Don’t have account?",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              TextSpan(
                                text: " SIGN UP",
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
