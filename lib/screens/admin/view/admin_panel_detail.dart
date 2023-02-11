import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/admin/controller/admin_controller.dart';
import 'package:new_yellow/screens/concert_dashboard/view/concert_dashboard_screen.dart';

import '../../../utils/custom_dialog.dart';

class AdminPDetailScreen extends StatelessWidget {
 AdminPDetailScreen({required this.docId, this.index});
  final docId;
  final index;

   var adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    log("docid: "+docId.toString());
    log("instagram: "+ index["event_title"].toString() );
    log("instagram: "+ index["who_play"].toString());
    log("instagram: "+ index["when_is_it"].toString());
    log("instagram: "+  index["street_address"].toString());
    log("instagram: "+index["genre"].toString() );
    log("instagram: "+ index["how_much_ticket"].toString());
    log("spotify: "+index["spotfy_link"].toString() );
    log("caption: "+index["event_caption"].toString());
    log("Freee: "+ index["how_much_ticket"].toString());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    children: [
                     Icon(Icons.arrow_back_ios,size: 20,),
                      Spacer(),
                      CustomText(text: "Admin Panel",size: 24,bold: FontWeight.w700,),
                      Spacer()

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  index["who_play"].toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:20,
                  ),
                ),
                Divider(color: Colors.black,thickness: 2,),
                SizedBox(height: 20,),
                customTxtAndImage(txt:  index["event_title"].toString(),color: Colors.black),

                SizedBox(height: 20,),
                customTxtAndImage(txt: index["when_is_it"].toString(),color: Colors.black.withOpacity(0.5)),
                SizedBox(height: 20,),
                customTxtAndImageUnderLine(txt: index["street_address"].toString(),color: Colors.black),
                SizedBox(height: 20,),
               CustomText(text: "Genre: ${index["genre"].toString()}",size: 14,bold: FontWeight.w500,color: Colors.black.withOpacity(0.5),),
                SizedBox(height:20,),
                customTxtAndImage(txt:"Price: \$ ${index["how_much_ticket"].toString()}",color: Colors.black),
                SizedBox(height: 20,),
                CustomText(text: "Caption:",size: 14,bold: FontWeight.w500,color: Colors.black,),
                CustomText(text: index["event_caption"].toString(),size: 14,bold: FontWeight.w500,color: Colors.black.withOpacity(0.5),),
                SizedBox(height: 20,),
                CustomText(text: "Follow me on ${index["spotfy_link"].toString()}",size: 14,bold: FontWeight.w500,color: Colors.black.withOpacity(0.5),),
                SizedBox(height: 20,),
                customTxtAndImage(txt:"PHONE NUMBER: ${index["phone"].toString()}",color: Colors.black),
                SizedBox(height: 20,),
                customTxtAndImage(txt:"VENMO: NULL",color: Colors.black),
                SizedBox(height: 20,),
                customTxtAndImageUnderLine(txt:"Banner Image:",color: Colors.black),
                Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(index["banner_pic"].toString()),fit: BoxFit.cover)
                  ),

                ),
                SizedBox(height: 20,),
                customTxtAndImageUnderLine(txt:"Poster Image:",color: Colors.black),
                Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(index["concert_pic"].toString()),fit: BoxFit.cover)
                  ),

                ),
                SizedBox(height: 20,),
                customTxtAndImageUnderLine(txt:index["instagram_link"].toString(),color: Colors.black),
                SizedBox(height: 20,),
                customTxtAndImageUnderLine(txt:index["spotfy_link"].toString(),
                    color: Colors.black),
                SizedBox(height: 10,),
          Divider(color: Colors.black,thickness: 2,),
                SizedBox(height: 10,),
                Center(child: CustomText(text: "Approve or Deny?",size: 20,bold: FontWeight.w700,color: Colors.black,)),
                SizedBox(height: 10,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 30),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 cImageTxt(txt: "Approve",img: "images/e2.png",onTap: (){
                   Dialouge_Box.publishEvent(docId: docId, text: "Publish");
                 //  adminController.eventPublish(id: docId,text: "Publish");
                 }),
                 cImageTxt(txt: "Deny",img: "images/imgg_22.png",onTap: (){
                   Dialouge_Box.unPublishEvent(docId: docId, text: "Deny");
                  // adminController.eventPublish(id: docId,text: "Deny");
                 }),
               ],
             ),
           ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  customTxtAndImage({final txt,final color})
  {
    return Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: color,
          fontSize:14,
          fontWeight: FontWeight.w500,
      ),
    );

  }
  customTxtAndImageUnderLine({final txt,final color})
  {
    return ConstrainedBox(

      constraints: BoxConstraints(
        maxWidth: 160
      ),
      child: Text(
        txt,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: color,
          fontSize:14,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
        ),
      ),
    );

  }

  cImageTxt({final img,final txt,final onTap}){
    return Column(
      children: [
        InkWell(
        onTap: onTap,
            child: Image.asset(img,fit: BoxFit.fill,height: 40,width: 40,)),
        Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize:14,
            fontWeight: FontWeight.w500,
          ),
        ),

      ],
    );
  }
}
