// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/sign_up/controller/phone_controller.dart';
import 'package:new_yellow/auth/sign_up/view/signup_screen.dart';

import '../../../welcome_screen/welcome_screen.dart';


class PhonRegistrationScreen extends StatefulWidget {
  PhonRegistrationScreen({ this.date, this.name}) ;
  final date;
  final name;
  @override
  State<PhonRegistrationScreen> createState() => _PhonRegistrationScreenState();
}

class _PhonRegistrationScreenState extends State<PhonRegistrationScreen> {
  // final countryPicker =const FlCountryCodePicker();
  // final countryPicker =const FlCountryCodePicker();
  // CountryCode? countryCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PhoneAuthController>(
        init: PhoneAuthController(),
        builder: (phoneAuthController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height:80,
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "Create your account using your phone number",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 28,
                      top: 50,
                    ),
                    child: Container(
                      height: 54,
                      child: TextFormField(
                        controller: phoneAuthController.phoneController,
                        onChanged: (val) {
                          setState(() {
                            phoneAuthController.isButtonClrChng.value = true;
                          });
                        },
                        cursorColor: Color(0xff999999),
                        keyboardType: TextInputType.phone,
                        style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: 'Your Phone',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff999999),
                          ),

                          contentPadding: EdgeInsets.only(top: 6),
                          prefixIcon: Container(
                            height: 20,
                            width: 70,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(width: 1, color: Colors.black)),
                            child: Padding(
                              padding:  EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                      height: 13,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset("images/Usa_flag.png"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "+1",
                                            style: TextStyle(
                                                color: Colors.black),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(children: <InlineSpan>[
                          TextSpan(
                            text: 'By pressing “Continue”, you agree to our ',
                            style: GoogleFonts.inter(
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: GoogleFonts.inter(
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: 'Terms of Service',
                            style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontWeight: FontWeight.w700),
                          ),
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                      //  phoneAuthController.sendOtp(namee: widget.name,datee: widget.date,num:phoneAuthController.phoneController.text );
                      // Get.to(()=>WelcomeScreen());
                    //   Get.to(()=>SignUpScreen(date: widget.date,name: widget.name,phone: phoneAuthController.phoneController.text,));
                      },
                      child: Container(
                        height: 58,
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Text(
                          "Continue",
                          style: GoogleFonts.inter(
                              color: phoneAuthController.isButtonClrChng.value
                              ? Colors.black
                              : Color(0xff999999),
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
