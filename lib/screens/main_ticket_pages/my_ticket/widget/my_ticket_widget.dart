import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_text.dart';

import '../../cobtroller/concert_information_controller.dart';
import '../view/my_ticket_expanded_screen.dart';

class MyTicketWidget extends StatelessWidget {
    MyTicketWidget({  this.img, this.txt1, this.txt2, this.txt3, this.onTap});
        final img;
        final txt1;
        final txt2;
        final txt3;
        final onTap;
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
    return InkWell(
      onTap: onTap,
      child:
      Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: txt1,size: 16,color: Colors.white,bold: FontWeight.w600,),
            CustomText(text: formate_Date(txt2),size: 12,bold: FontWeight.w400,color: Color(0xfff7d117),),
            CustomText(text: txt3,size: 13,color: Colors.white,bold: FontWeight.w500,)
          ],
        ),
      ),
    );
  }
}
