import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../cobtroller/concert_information_controller.dart';
import 'my_free_ticket.dart';


class MyTicketExpScreen extends StatelessWidget {
  MyTicketExpScreen({
 this.img, this.title, this.city, this.date, this.docId, this.postalCode, this.state, this.street});
  final img;
  final title;
  final city;
  final postalCode;
  final state;
  final street;
  final date;
  final docId;

  final controller = Get.put(ConcertInfoController());

  static String formate_Date(String datetime) {
    if (datetime.toString() == "" || datetime.toString() == "null") {
      return "";
    }

    DateTime time = DateTime.parse(datetime);
    String formattedDate=  DateFormat.MMMMEEEEd().add_jm().format(time );
    //String formattedDate = DateFormat.yMMMMd().format(time);
    return formattedDate.toString();
  }
  @override
  Widget build(BuildContext context) {
    log(docId.toString());
    return Scaffold(
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height:controller.isClicked.value?
                // MediaQuery.of(context).size.height: MediaQuery.of(context).size.height*1.4,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black.withOpacity(0.2),width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20,),
                    Center(child: Image.asset("images/vect.png",height: 12,width: 12,fit: BoxFit.fill,)),
                    SizedBox(height: 20,),
                    CustomText(text: title,size: 12,bold: FontWeight.w700,color: Colors.black,),
                    SizedBox(height: 5,),
                    CustomText(text: formate_Date(date),size: 12,bold: FontWeight.w400,color: Colors.black,),
                    SizedBox(height: 25,),
                    CustomText(text: "Street Address:",size: 12,bold: FontWeight.w400,color: Colors.black,),
                    SizedBox(height: 5,),
                    CustomText(text:  "${street} "+"${city}"+"${state} "+"${postalCode}",size: 12,bold: FontWeight.w400,color: Colors.black,underLine: TextDecoration.underline,),
                    SizedBox(height: 25,),
                    Image.network(img,fit: BoxFit.fill,),
                    SizedBox(height: 10,),
                    Center(child: InkWell(
                        onTap: (){

                        },
                        child: CustomText(text: "Click to see event details",size: 10,bold: FontWeight.w700,color: Colors.black,))),
                    SizedBox(height: 20,),


                    Obx(() =>
                    controller.isClicked.value?
                    Center(child:
                    InkWell(
                        onTap: (){
                          controller.isClicked.value =  false;
                        },
                        child:Icon(Icons.arrow_drop_up,color: Colors.black,))): Center(child: InkWell(
                        onTap: (){
                          controller.isClicked.value =  true;
                        },
                        child:  Icon(Icons.arrow_drop_down,color: Colors.black,))),),
                    SizedBox(height: 10,),
                    Center(child: CustomText(text: "Pull up to access your ticket",size: 13,bold: FontWeight.w500,color: Colors.black,)),
                    SizedBox(height: 10,),
                    Obx(() =>  controller.isClicked.value?SizedBox.shrink():  Column(
                      children: [

                        SizedBox(height: 20,),
                        Center(child: CustomText(text: "Standard Ticket")),
                        SizedBox(height: 20,),
                        cRowWidget(t1: "SEC",t2: "ROW",t3: "SEAT"),
                        SizedBox(height: 20,),
                        cRowWidget(t1: "GA",t2: "GA",t3: "GA"),

                        SizedBox(height: 20,),
                        Center(
                          child: QrImage(
                            data: docId,
                            version: QrVersions.auto,
                            size: 120,
                            gapless: false,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(child: CustomText(text: "Screenshots won’t get you in.",size: 12,bold: FontWeight.w400,)),
                        SizedBox(height: 20,),
                        Center(child: Image.asset(height: 40,width:40,"images/my_t_1.png",fit: BoxFit.fill,)),

                      ],
                    ))
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  cRowWidget({final t1,final t2,final t3}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text:t1 ,size: 15,bold: FontWeight.w400,),
          CustomText(text:t2 ,size: 15,bold: FontWeight.w400,),
          CustomText(text:t3 ,size: 15,bold: FontWeight.w400,),
        ],
      ),
    );
  }
}
