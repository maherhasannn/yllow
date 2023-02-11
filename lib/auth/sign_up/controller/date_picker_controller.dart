import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DatePickController extends GetxController {
  GlobalKey<FormState> dateKey = GlobalKey();
  var isButtonClrChng = false.obs;
  DateTime selectedDate = DateTime.now();

  getFormatedDatetime(var dateTime) {
    var datee = DateFormat('dd/MM/yyyy').format(dateTime);
    var isBtnColorChnage = false.obs;
    // Parsed date to check
    DateTime birthDate = DateFormat(datee).parse(dateTime);

    // Date to check but moved 18 years ahead
    DateTime adultDate = DateTime(
      birthDate.year + 18,
      birthDate.month,
      birthDate.day,
    );

    return adultDate.isBefore(selectedDate);

    // return datee;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: Colors.green,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ?? Text(""),
        );
      },
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      int datee = calculateAge(picked);
      print(datee.toString());
      if (datee >= 17) {
        var dtnew = DateFormat('MM/dd/yyyy').format(picked);
        //  getFormatedDatetime(selectedDate);
        eventDate.text = dtnew.toString();
      } else if (datee < 17) {
        Get.snackbar("Age Restriction", "You must be above 17 to register",
            colorText: Colors.white, backgroundColor: Colors.blue);
        eventDate.text = "";
      }
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  final eventDate = TextEditingController();

  String? validateEventDate(String value) {
    if (value == null || value == '') {
      return "*This field is compulsory";
    }
    return null;
  }
}