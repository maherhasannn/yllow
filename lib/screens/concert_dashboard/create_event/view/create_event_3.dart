import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/controller/event_controller.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

import 'create_event_screen_4.dart';

class CreateEventScreen_3 extends StatelessWidget {
  CreateEventScreen_3({
    required this.who_play,
    required this.link_to_buy_ticket,
    required  this.genre,
    required this.when_is_it,
    required this.when_door_open,
    required this.how_much_ticket,
    required this.available_ticket,
    required this.street_address,
    required this.state_address,
    required this.zip_code,
    required this.city_address,
    required this.event_create_user,
    required this.event_title
  });
  final link_to_buy_ticket;
  final who_play;
  final event_title;
  final street_address;
  final state_address;
  final zip_code;
  final city_address;
  final genre;
  final when_is_it;
  final when_door_open;
  final how_much_ticket;
  final available_ticket;
  final event_create_user;
  var contr = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 110,

        child: Column(
          children: [

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(text: "We’ll send you a text once your submission is confirmed (or if something goes wrong)",size: 10,bold: FontWeight.w600,color: Colors.black,),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                if (
                contr
                    .phone.text ==
                    "" ||
                    contr
                        .instagram_link.text ==
                        ""||
                    contr
                        .spotfy_link.text ==
                        ""
                ) {
                  print("if error");
                  Get.snackbar(
                    "Error",
                    "One of your field is not selected",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
                else{
                  Get.to(()=>CreateEventScreen_4
                    (
                    link_to_buy_ticket:link_to_buy_ticket,
                    who_play: who_play,
                    event_title: event_title,
                    state_address: state_address,
                    street_address: street_address,
                    zip_code: zip_code,
                    city_address: city_address,
                    genre: genre,
                    when_is_it: when_is_it ,
                    when_door_open:  when_door_open,
                    how_much_ticket: how_much_ticket,
                    available_ticket: available_ticket,
                    phone: contr.phone.text,
                    event_caption: contr.event_caption.text,
                    instagram: contr.instagram_link.text,
                    spotify: contr.spotfy_link.text, event_create_user: event_create_user,

                  ));

                }

              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration
                  (
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(text: "Next",size: 13,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Form(
            key: contr.formKey3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),

                      Spacer(),
                      CustomText(text: "New Event",size: 24,bold: FontWeight.w700,),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dotContainer(color: Colors.black),
                    SizedBox(width: 10,),
                    dotContainer(color: Colors.black),
                    SizedBox(width: 10,),
                    dotContainer(color: Colors.black),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                  height: MediaQuery.of(context).size.height*0.07,
                    hint_text: "+1",
                    txt: "Phone Number",width: MediaQuery.of(context).size.width,
                    controller: contr.phone,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                eventCapion(
                  height:MediaQuery.of(context).size.height*0.3,
                    hint_text: "Parking, Dress Code, etc...",
                    txt: "Event Caption",width: MediaQuery.of(context).size.width,
                    controller: contr.event_caption,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                    height: MediaQuery.of(context).size.height*0.07,
                    hint_text: "Paste link here",
                    txt: "Link your Instagram*",width: MediaQuery.of(context).size.width,
                    controller: contr.instagram_link,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                    height: MediaQuery.of(context).size.height*0.07,
                    hint_text: "Paste link here",
                    txt: "Link your Music (Spotify, YouTube, etc)",width: MediaQuery.of(context).size.width,
                    controller: contr.spotfy_link,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  dateTextField({final txt,var width,var height,final hint_text,var controller,var validation}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
          ),
          SizedBox(height: 10,),
          Container(
            height: height,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 6,left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10)
            ),
            width:width,
            child: TextFormField(
              controller: controller,
              validator: validation,
              decoration: InputDecoration(
                  hintText: hint_text,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      );
  }

  eventCapion({final txt,var width,var height,final hint_text,var controller,var validation}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
          ),
          SizedBox(height: 10,),
          Container(
            height: height,
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(bottom: 6,left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10)
            ),
            width:width,
            child: TextFormField(
              controller: controller,
              validator: validation,
              decoration: InputDecoration(
                  hintText: hint_text,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      );
  }

  dotContainer({final color}){
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black,width: 1)
      ),
    );
  }
}
