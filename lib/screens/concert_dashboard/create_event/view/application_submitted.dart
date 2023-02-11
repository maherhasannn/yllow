import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/home_1/view/home_1_screen.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

import '../../../../utils/location.dart';
import '../../concert_page/concert_p_1.dart';
import 'create_event_screen_2.dart';

class ApplicationSubmitted extends StatelessWidget {
  const ApplicationSubmitted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("long:"+Get.find<GetStorageController>().box.read(E_LONGITUDE).toString());
    return Scaffold(
   bottomNavigationBar: Container(
     height: 100,
     child: Column(
       children: [
         Center(child: CustomText(text: "Need help? ",size: 10,bold: FontWeight.w700,color: Colors.black,)),
         SizedBox(height: 20,),
         InkWell(
           onTap: (){
             Get.offAll(()=>Home_1_Screen());

           },
           child: Container(
             height: 45,
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.symmetric(horizontal: 50),
             alignment: Alignment.center,
             decoration: BoxDecoration
               (
               color: Colors.black,
               borderRadius: BorderRadius.circular(20),
             ),
             child: CustomText(text: "Done",size: 13,color: Colors.white,),
           ),
         ),
       ],
     ),
   ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(text: "Application Submitted",size: 24,bold: FontWeight.w700,color: Colors.black,),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Divider(color: Colors.black,thickness: 1,),
              // ),
              // SizedBox(height: 30,),
              // Center(child: CustomText(text: "Thank you for your submission!",size: 20,bold: FontWeight.w700,color: Colors.black,)),
               SizedBox(height: 60,),
              Center(child: Image.asset(height: 24,width:24,"images/done.png",fit: BoxFit.fill,)),

              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:40),
                child: Center(child: CustomText(text: "Application Submitted! Once approved, you will get a confirmation text to your phone number*",
                  size: 14,bold: FontWeight.w400,color: Colors.black,)),
              ),
              SizedBox(height: 30,),
              Center(child: CustomText(text: "*Standard text message rates apply",size: 14,bold: FontWeight.w400,color: Colors.black,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: Image.asset(height: 213,width:MediaQuery.of(context).size.width,"images/catt.png",fit: BoxFit.fill,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Center(child: CustomText(text: "As a reward for all your hard work, enjoy this picture of some kittens in a box <3",
                  size: 12,bold: FontWeight.w600,color: Colors.black,)),
              ),


            ],
          ),
        ),
      ),
    );
  }
  customBottonIcon({final context}){
    return Column(
      children: [
        Center(child: CustomText(text: "Need help? Shoot us a text at 760 916 6605",size: 14,bold: FontWeight.w600,color: Colors.black,underLine: TextDecoration.underline,)),
        SizedBox(height: 20,),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          decoration: BoxDecoration
            (
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: CustomText(text: "Confirm",size: 13,color: Colors.white,),
        ),

      ],
    );
  }
  cTextField({final width}) {
    return Container(
      height: 35,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20
        ),
          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
      ),
      width:width,
      child: TextFormField(
        decoration: InputDecoration(

            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none
        ),
      ),
    );
  }
  dateTextField({final txt,final width}) {
    return
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(text:txt ,size: 10,bold: FontWeight.w700,color: Colors.black.withOpacity(0.5),),
            Container(
              height: 30,
              //margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
              ),
              width:width,
              child: TextFormField(
                decoration: InputDecoration(

                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none
                ),
              ),
            ),
          ],
        ),
      );
  }
}
