
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/admin/controller/admin_controller.dart';
import '../screens/profile/controler/profile_controler.dart';

class Dialouge_Box {

  //
  static publishEvent({required final docId,required final text}) {

    var adminController = Get.put(AdminController());
    if (Get.isDialogOpen!) {
      Get.back();
      Get.find<ProfileController>().notificationArrowClick.value= true;
    }
    Get.defaultDialog(
      title: "Alert!",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
          color: Color(0xffE94235),
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
          fontSize: 25),
      barrierDismissible: true,
      radius: 15,
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " Are you sure you want to Approve?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.1),width: 1)
              ),
              child: Text("N0",style: TextStyle(color: Colors.blue),)),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            adminController.eventPublish(id: docId,text: text);
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.1),width: 1)
              ),
              child: Text(
                "YES",
                style: TextStyle(color: Colors.blue),
              )),
        ),
      ],
    );
  }


  static unPublishEvent({required final docId,required final text}) {

    var adminController = Get.put(AdminController());
    if (Get.isDialogOpen!) {
      Get.back();
      Get.find<ProfileController>().notificationArrowClick.value= true;
    }
    Get.defaultDialog(
      title: "Alert!",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
          color: Color(0xffE94235),
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
          fontSize: 25),
      barrierDismissible: true,
      radius: 15,
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " Are you sure you want to Deny?",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.1),width: 1)
              ),
              child: Text("N0",style: TextStyle(color: Colors.blue),)),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            adminController.eventPublish(id: docId,text: text);
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.1),width: 1)
              ),
              child: Text(
                "YES",
                style: TextStyle(color: Colors.blue),
              )),
        ),
      ],
    );
  }
  static notificationDialog() {

    if (Get.isDialogOpen!) {
      Get.back();
      Get.find<ProfileController>().notificationArrowClick.value= true;
    }
    Get.defaultDialog(
      title: "Alert!",
      backgroundColor: Colors.white,
      titleStyle: TextStyle(
          color: Color(0xffE94235),
          fontWeight: FontWeight.w700,
          fontFamily: "Roboto",
          fontSize: 25),
      barrierDismissible: true,
      radius: 15,
      contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " ${"App"} would like to Send You Notifications.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              " Notification may include alerts, sounds and icon badges. There can be configuration in settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.find<ProfileController>().notificationArrowClick.value= false;
            Get.find<ProfileController>().notificationClicked.value= false;
            Get.back();
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.3),width: 1)
              ),
              child: Text("Don't Allow",style: TextStyle(color: Colors.blue),)),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Get.find<ProfileController>().notificationClicked.value= true;
            Get.find<ProfileController>().notificationArrowClick.value= false;
            Get.back();
          },
          child: Container(
              height: 40,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.3),width: 1)
              ),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              )),
        ),
      ],
    );
  }
}