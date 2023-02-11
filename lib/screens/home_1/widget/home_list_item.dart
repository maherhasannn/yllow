import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_text.dart';

import '../../main_ticket_pages/concert_information_explanation/concert_info_screen.dart';

class HomeListItem extends StatelessWidget {
   HomeListItem({this.img, this.txt1, this.txt2, this.txt3, this.onTap}) ;
final img;
final txt1;
final txt2;
final txt3;
final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child:
      Container(
        height: 170,
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
        ),
        child: Hero(
          tag: "hero_anim_5",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: txt1,size: 16,color: Colors.white,bold: FontWeight.w600,),
              CustomText(text: txt2,size: 12,bold: FontWeight.w400,color: Color(0xfff7d117),),
              CustomText(text: txt3,size: 13,color: Colors.white,bold: FontWeight.w500,)
            ],
          ),
        ),
      ),
    );
  }
}
