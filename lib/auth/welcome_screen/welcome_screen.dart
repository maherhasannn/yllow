import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/utils/common.dart';

import 'app_explanation_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.060,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 48, right: 48),
                  child: Hero(
                    tag: "hero_anim",
                    child: Container(
                      width: 130,
                      height: 130,
                      child: Image.asset('images/p_3.png'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  "Welcome to the yllow app",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Color(0xff000000),
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding:  EdgeInsets.only(left: 24, right: 24, bottom: 20),
          child: InkWell(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AppExplanationScreen()));
              Get.to(()=>AppExplanationScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 4,
                    image: AssetImage("images/swipe.png"),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Icon(
                  Icons.arrow_downward_sharp,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ));
  }
}
