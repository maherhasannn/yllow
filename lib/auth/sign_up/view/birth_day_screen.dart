import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/sign_up/view/signup_screen.dart';

import '../controller/date_picker_controller.dart';
import '../phone_verification/view/phone_v_screen.dart';


class DbRegistrationScreen extends StatefulWidget {
  DbRegistrationScreen({this.name}) ;
  final name;
  @override
  State<DbRegistrationScreen> createState() => _DbRegistrationScreenState();
}

class _DbRegistrationScreenState extends State<DbRegistrationScreen> {
  final createEventController = Get.put(DatePickController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: createEventController.dateKey,
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
                  "Hi ${widget.name}, when’s your birthday?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 28, right: 28, top: 40, bottom: 50),
                child: Container(
                  height: 54,
                  child: TextFormField(
                    controller: createEventController.eventDate,
                    onTap: () {
                      createEventController.selectDate(context);
                      createEventController.isButtonClrChng.value = true;
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
                      hintText: 'MM DD YYYY',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 25,
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: InkWell(
            onTap: () {
              //  log("Nothing");
              //
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => PhonRegistrationScreen(
              //           name: widget.name,
              //           date: createEventController.eventDate.text,
              //
              //         )));
              if(createEventController.dateKey.currentState!.validate()){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(
                          name: widget.name,
                          date: createEventController.eventDate.text,

                        )));
              }

              if (createEventController.getFormatedDatetime(context) < 17)
              {
                log("Nothing");
              } else {
                MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                      name: widget.name,
                      date: createEventController.eventDate.text,

                    ));
              }
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
                    color: createEventController.isButtonClrChng.value
                        ? Colors.black
                        : Color(0xff999999),
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ));
  }
}
