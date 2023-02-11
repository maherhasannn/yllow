import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

import '../../cobtroller/concert_information_controller.dart';


class MyFreeTicketScreen extends StatelessWidget {
  MyFreeTicketScreen({
    this.img, this.title, this.city, this.date, this.postalCode, this.state, this.street});
  final img;
  final title;
  final city;
  final postalCode;
  final state;
  final street;
  final date;
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
    return Scaffold(
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
               // height:MediaQuery.of(context).size.height,
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
                    CustomText(text: "Date: "+formate_Date(date),size: 12,bold: FontWeight.w400,color: Colors.black,),
                    SizedBox(height: 25,),
                    CustomText(text: "Street Address:",size: 12,bold: FontWeight.w400,color: Colors.black,),
                    SizedBox(height: 5,),
                    CustomText(text:   "${street} "+"${city}"+"${state} "+"${postalCode}",size: 12,bold: FontWeight.w400,color: Colors.black,underLine: TextDecoration.underline,),
                    SizedBox(height: 25,),
                    Image.network(img,fit: BoxFit.fill,),
                    SizedBox(height: 10,),
                    Center(child: CustomText(text: "Click to see event details",size: 10,bold: FontWeight.w700,color: Colors.black,)),
                    SizedBox(height: 20,),
                    Center(child: CustomText(text: "FREE",size: 20,bold: FontWeight.w500,)),
                    SizedBox(height: 10,),
                    Center(child: Image.asset(height: 40,width:40,"images/my_t_1.png",fit: BoxFit.fill,)),

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
