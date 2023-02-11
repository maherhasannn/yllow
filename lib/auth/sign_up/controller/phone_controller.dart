// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class PhoneAuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  var name;
  var date;
  var isButtonClrChng = false.obs;
  // sendOtp({final namee, final datee, final num}) async {
  //   name=namee;
  //   date=datee;
  //   log("name "+name.toString());
  //   log("name "+date.toString());
  //   log("<=============================================>");
  //   log("Inside Phone Authentication sendOtp Controller");
  //   log("Phone Number inside Controller: ${phoneController.value.text.toString()}");
  //   log("<=============================================>");
  //   PhoneAuthentication.sendOTP(phoneNumber: phoneController.value.text.trim(),name: name,date: date);
  // }
  //
  // verifyOtp({required String verificationId, required String otp}) async {
  //   log("<=============================================>");
  //   log("Inside Phone Authentication verifyOtp Controller");
  //   log("Otp is $otp");
  //   log("VerificationId is $verificationId");
  //   log("<=============================================>");
  //   bool verificationStatus;
  //   verificationStatus = await PhoneAuthentication.verifyOtp(
  //       verificationId: verificationId, otp: otp);
  //   if (verificationStatus) {
  //     //Get.offAll(() => WelcomeScreen());
  //     Get.offAll(() => SignUpScreen(name: name,date: date,phone: phoneController.text,));
  //   } else {
  //     Get.snackbar("OTP Verification Failed", "Please Ask for resend token");
  //   }
  // }
  //
  // resendOtp({required String phoneNumber, required int? resendToken}) async {
  //   log("<=============================================>");
  //   log("Inside Phone Authentication resendOtp Controller");
  //   log("Phone Number is $phoneNumber");
  //   log("Resend Token is $resendToken");
  //   log("<=============================================>");
  //   PhoneAuthentication.resendOtp(
  //       phoneNumber: phoneNumber, resendToken: resendToken);
  // }
}
