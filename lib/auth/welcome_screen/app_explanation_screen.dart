// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/sign_up/view/name_screen.dart';

import '../../screens/home_1/view/home_1_screen.dart';


class AppExplanationScreen extends StatefulWidget {
  const AppExplanationScreen({Key? key}) : super(key: key);

  @override
  State<AppExplanationScreen> createState() => _AppExplanationScreenState();
}

class _AppExplanationScreenState extends State<AppExplanationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 32,right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.060,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 48, right: 48),
                    child: Container(
                      width: 130,
                      height: 130,
                      child: Image.asset('images/p_3.png'),
                    ),
                  ),
                ),
                Text(
                  "Welcome to the yllow app",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Color(0xff000000),
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.030,
                ),
                Text.rich(
                    TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: 'Use this app to RSVP to Events ',
                        style: GoogleFonts.inter(
                            color: Color(0xff000000),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                          text: 'Hosted by Yllow,',
                          style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              color: Color(0xff000000),
                              fontSize: 32,
                              fontWeight: FontWeight.w700)
                      ),
                    ])),
                SizedBox(height: MediaQuery.of(context).size.height * 0.030,
                ),
                Text.rich(

                    TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: 'To Scan ',
                        style: GoogleFonts.inter(
                            color: Color(0xff000000),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                          text: 'Yllow Wristbands',
                          style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              color: Color(0xff000000),
                              fontSize: 32,
                              fontWeight: FontWeight.w700)
                      ),
                    ])),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.030,
                ),
                Text.rich(
                  // textAlign: TextAlign.center,
                    TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: 'And to ',
                        style: GoogleFonts.inter(
                            color: Color(0xff000000),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                          text: 'securely chat',
                          style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              color: Color(0xff000000),
                              fontSize: 32,
                              fontWeight: FontWeight.w700)
                      ),
                      TextSpan(
                        text: ' with your new acquaintances.',
                        style: GoogleFonts.inter(
                            color: Color(0xff000000),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      ),
                    ])),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 24,right: 24, bottom: 20),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NameRegistration()));
            },
            child: Hero(
              tag: "hero_anim_2",
              child: Container(
                decoration:BoxDecoration(
                    image: DecorationImage(
                      scale: 4,
                      image: AssetImage("images/swipe.png"),
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Icon(Icons.arrow_downward_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
