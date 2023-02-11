import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/controller/event_controller.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:new_yellow/utils/location.dart';

import '../../../../utils/common.dart';
import '../../../../utils/re_usable_dialog.dart';
import '../../view/concert_payment_screen.dart';
import 'create_event_screen_2.dart';

class CreateEventScreen_1 extends StatelessWidget {
  CreateEventScreen_1({this.event_create_user});
  final event_create_user;
 var contr = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    log((MediaQuery.of(context).size.height*0.3).toString());
    return  Get.find<GetStorageController>().box.read(COMMONS.eventlocationEnable) == "true"? Scaffold(
   bottomNavigationBar: Container(
     height: 90,

     child: Column(
       children: [
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: 20),
           child: CustomText(text: "Make sure to check out our Concert Tips after completing your submission!",size: 10,bold: FontWeight.w600,color: Colors.black,),
         ),
         SizedBox(height: 10,),
         InkWell(
           onTap: (){
             if (
             contr
                 .who_play.text ==
                 "" ||
                 contr
                     .genre.text ==
                     ""|| contr
                 .event_title.text ==
                 "" ||
                 contr
                     .streetAddress.text ==
                     ""|| contr
                 .stateAddress.text ==
                 "" ||
                 contr
                     .cityAddress.text ==
                     ""|| contr
                 .zipCodeAddress.text ==
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
               Get.to(()=>CreateEventScreen_2(
                   who_play: contr.who_play.text,
                   genre: contr.genre.text,
                   event_title: contr.event_title.text,
                   street_address: contr.streetAddress.text,
                   state_address: contr.stateAddress.text,
                   zip_code: contr.zipCodeAddress.text,
                   city_address: contr.cityAddress.text, event_create_user: event_create_user,
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
             child: CustomText(text: "Next",size: 13,color: Colors.white,bold: FontWeight.w600,),
           ),
         ),
       ],
     ),
   ),
      body: SafeArea(
        child:
        SingleChildScrollView(child: Form(
            key: contr.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  dotContainer(color: Colors.white),
                  SizedBox(width: 10,),
                  dotContainer(color: Colors.white),
                ],
              ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                  hint_text: "Enter here...",
                  txt: "Event Title",
                  context: context,
                  controller: contr.event_title,
                  validation:
                    (value) {
        if (value!.isEmpty) {
        return "Field is Empty";
        }
        },),

                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                  hint_text: "(Seperate multiple artists with commas)",
                  txt: "Who’s Playing?",
                  context: context,
                  controller: contr.who_play,
                  validation:
                      (value) {
                    if (value!.isEmpty) {
                      return "Field is Empty";
                    }
                  },),

                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                dateTextField(
                    hint_text: "Enter here...",
                    txt: "Genre",context: context,
                    controller: contr.genre,
    validation:
    (value) {
    if (value!.isEmpty) {
    return "Field is Empty";
    }}
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                dateTextField(
                  hint_text: "Street Address",
                    txt: "Where is your event?",
                    context: context,
                    controller: contr.streetAddress,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.005,),
                dateTextField(
                    hint_text: "City",
                    txt: "",context: context,
                    controller: contr.cityAddress,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
               // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  zipTextField(
                    context: context,
                      hint_text: "State",
                      txt: "",
                      controller: contr.stateAddress,
                      validation:
                          (value) {
                        if (value!.isEmpty) {
                          return "Field is Empty";
                        }}
                  ),

                  zipTextField(
                    context: context,
                      hint_text: "Zipcode",
                      txt: "",
                      controller: contr.zipCodeAddress,
                      validation:
                          (value) {
                        if (value!.isEmpty) {
                          return "Field is Empty";
                        }}
                  ),
                ],
              ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
              ],
            ),
          ),),
      ),
    ):
    Scaffold(
    body: SafeArea(
    child: SingleChildScrollView(
    child: Column(
    children: [
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    InkWell(
    onTap:(){
    Get.offAll(()=>ConcertPaymentScreen());
    },child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),
    SizedBox()
    ],
    ),
    ),
    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    CustomText(text: "Confirm Your Location",size: 24,bold: FontWeight.w600,color: Colors.black,),
    // Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?
    // InkWell(
    //     onTap:(){
    //
    //     },
    //     child: Image.asset(height: 30,width:30,"images/p_dots.png",fit: BoxFit.fill,)):
    InkWell(
    onTap: ()async{
    log("clickeddddddddddddddddddddd");

    Position position =
    await GetLocation.getGeoLocationPosition().whenComplete(() {

    Get.find<GetStorageController>().writeStorage(COMMONS.eventlocationEnable, "true");
    Get.offAll(()=>CreateEventScreen_1());


    });

    Get.find<GetStorageController>()
        .box
        .write(P_LATITUDE, position.latitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(P_LONGITUDE, position.longitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(E_LATITUDE, position.latitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(E_LONGITUDE, position.longitude.toString());

    },
    child: Image.asset(height: 30,width:30,"images/map_gray_icon.png",fit: BoxFit.fill)),

    ],
    ),
    ),
    SizedBox(height: MediaQuery.of(context).size.height*0.15,),
    Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
    Center(child: Image.asset("images/map_screen_image.png",height: 34,width: 34,fit: BoxFit.fill,)),
    Padding(
    padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
    child: CustomText(text: "We use your location to set your event’s radius!",size: 16,bold: FontWeight.w700,color: Colors.black,),
    ),

    Padding(
    padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
    child: CustomText(text: "Your event will be shown to all users within a 15 mile radius of your concert location. We confirm your location access to make sure your event shows up based on proximity.",size: 14,bold: FontWeight.w300,color: Color(0xff4E4E4E),),
    ),

    Padding(
    padding:  EdgeInsets.only(top: 30),
    child: InkWell(
    onTap: () async
    {

    log("clickeddddddddddddddddddddd");

    Position position =
    await GetLocation.getGeoLocationPosition().whenComplete(() {

    Get.find<GetStorageController>().writeStorage(COMMONS.eventlocationEnable, "true");
    Get.offAll(()=>CreateEventScreen_1());


    });

    Get.find<GetStorageController>()
        .box
        .write(P_LATITUDE, position.latitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(P_LONGITUDE, position.longitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(E_LATITUDE, position.latitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(E_LONGITUDE, position.longitude.toString());
    },
    child: Center(child: CustomText(text: " Open Settings",size: 16,bold: FontWeight.w700,color: Color(0xff4E4E4E),))),
    ),
    ],),
    ],
    ),
    ),
    ),
    );
    // return
    //   Scaffold(
    //   body: SafeArea(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 InkWell(
    //                     onTap:(){
    //                       Get.offAll(()=>ConcertPaymentScreen());
    //                     },child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),
    //                 SizedBox()
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: MediaQuery.of(context).size.height*0.05,),
    //           Padding(
    //             padding: const EdgeInsets.symmetric(horizontal: 20),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 CustomText(text: "Confirm Your Location",size: 24,bold: FontWeight.w600,color: Colors.black,),
    //                 // Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?
    //                 // InkWell(
    //                 //     onTap:(){
    //                 //
    //                 //     },
    //                 //     child: Image.asset(height: 30,width:30,"images/p_dots.png",fit: BoxFit.fill,)):
    //                 InkWell(
    //                     onTap: ()async{
    //                       log("clickeddddddddddddddddddddd");
    //
    //                       Position position =
    //                       await GetLocation.getGeoLocationPosition().whenComplete(() {
    //
    //                         Get.find<GetStorageController>().writeStorage(COMMONS.eventlocationEnable, "true");
    //                         Get.offAll(()=>CreateEventScreen_1());
    //
    //
    //                       });
    //
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(P_LATITUDE, position.latitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(P_LONGITUDE, position.longitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(E_LATITUDE, position.latitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(E_LONGITUDE, position.longitude.toString());
    //
    //                     },
    //                     child: Image.asset(height: 30,width:30,"images/map_gray_icon.png",fit: BoxFit.fill)),
    //
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: MediaQuery.of(context).size.height*0.15,),
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //
    //             children: [
    //               Center(child: Image.asset("images/map_screen_image.png",height: 34,width: 34,fit: BoxFit.fill,)),
    //               Padding(
    //                 padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
    //                 child: CustomText(text: "We use your location to set your event’s radius!",size: 16,bold: FontWeight.w700,color: Colors.black,),
    //               ),
    //
    //               Padding(
    //                 padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
    //                 child: CustomText(text: "Your event will be shown to all users within a 15 mile radius of your concert location. We confirm your location access to make sure your event shows up based on proximity.",size: 14,bold: FontWeight.w300,color: Color(0xff4E4E4E),),
    //               ),
    //
    //               Padding(
    //                 padding:  EdgeInsets.only(top: 30),
    //                 child: InkWell(
    //                     onTap: () async
    //                     {
    //
    //                       log("clickeddddddddddddddddddddd");
    //
    //                       Position position =
    //                       await GetLocation.getGeoLocationPosition().whenComplete(() {
    //
    //                         Get.find<GetStorageController>().writeStorage(COMMONS.eventlocationEnable, "true");
    //                         Get.offAll(()=>CreateEventScreen_1());
    //
    //
    //                       });
    //
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(P_LATITUDE, position.latitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(P_LONGITUDE, position.longitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(E_LATITUDE, position.latitude.toString());
    //                       Get.find<GetStorageController>()
    //                           .box
    //                           .write(E_LONGITUDE, position.longitude.toString());
    //                     },
    //                     child: Center(child: CustomText(text: " Open Settings",size: 16,bold: FontWeight.w700,color: Color(0xff4E4E4E),))),
    //               ),
    //             ],),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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

  dateTextField({final txt,var context,final hint_text,var controller,var validation}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
          ),
          SizedBox(height: 5,),
          Container(
          height: MediaQuery.of(context).size.height*0.07,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 6,left: 10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10)
          ),
          width:MediaQuery.of(context).size.width,
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

 zipTextField({final txt,final hint_text,var controller,var validation,required final context}) {
   return
     Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisAlignment: MainAxisAlignment.start,
       children: [
         Padding(
           padding:  EdgeInsets.symmetric(horizontal: 20),
           child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
         ),
         SizedBox(height: 5,),
         Container(
           height:MediaQuery.of(context).size.height*0.07,
           padding: EdgeInsets.only(bottom: 6,left: 10),
           margin: EdgeInsets.symmetric(horizontal: 20),
           alignment: Alignment.center,
           decoration: BoxDecoration(
               color: Color(0xffF5F5F5),
               borderRadius: BorderRadius.circular(10)
           ),
           width:140,
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
}
