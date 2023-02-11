import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/sign_up/controller/signup_controller.dart';

import '../../login/view/login_screen.dart';
import 'birth_day_screen.dart';


class NameRegistration extends StatefulWidget {

  @override
  State<NameRegistration> createState() => _NameRegistrationState();
}

class _NameRegistrationState extends State<NameRegistration> {
  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Hero(
          tag: "hero_anim_2",
          child: Form(
            key: controller.nameKey,
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
                    "Let’s Get Started, what’s your name?",
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
                      controller: controller.nController,
                      onChanged: (val) {
                        controller.isButtonClrChng.value = true;
                      },
                      validator: (val) {
                        return val!.isEmpty || val.length < 2
                            ? "Enter Correct Name"
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
                        hintText: 'Your Name',
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: Container(
            height: 70,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DbRegistrationScreen(name: controller.nController.text,)));

                    if(controller.nameKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DbRegistrationScreen(name: controller.nController.text,)));
                    } },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent
                    ),
                    child: Text(
                      "Continue",
                      style: GoogleFonts.inter(
                          color: controller.isButtonClrChng.value
                              ? Colors.black
                              : Color(0xff999999),
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 5,),
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
                                      fontSize: 14,    color: controller.isButtonClrChng.value
                                      ? Colors.black
                                      : Color(0xff999999),)),
                              TextSpan(
                                text: " SIGN IN",
                              ),
                            ])),
                  ),
                ),
                SizedBox(height: 5,),
              ],
            ),
          ),
        ));
  }
}
