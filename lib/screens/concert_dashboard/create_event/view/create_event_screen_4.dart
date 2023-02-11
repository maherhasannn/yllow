import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/global_widget/loader.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/controller/event_controller.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:new_yellow/utils/location.dart';

import '../../../../controller/get_storage_controller.dart';
import 'application_submitted.dart';

class CreateEventScreen_4 extends StatefulWidget {
  CreateEventScreen_4({
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
    required this.event_title,
    required this.instagram,
    required this.spotify,
    required this.phone,
    required this.event_caption,
    required this.event_create_user
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
  final phone;
  final instagram;
  final spotify;
  final event_caption;
  final event_create_user;

  @override
  State<CreateEventScreen_4> createState() => _CreateEventScreen_4State();
}

class _CreateEventScreen_4State extends State<CreateEventScreen_4> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getposition();
  }
  getposition() async {

    Position position =
    await GetLocation.getGeoLocationPosition();
    Get.find<GetStorageController>()
        .box
        .write(E_LATITUDE, position.latitude.toString());
    Get.find<GetStorageController>()
        .box
        .write(E_LONGITUDE, position.longitude.toString());
  }

  var contr = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomNavigationBar:
Obx(() =>   contr.isLoading.value?
Container(
    height: 30,
    width: 30,
    child: Center(child:  kLoader())):
InkWell(
  onTap: (){
    if (
    contr
        .selectedImagePath
        .value ==
        "" ||
        contr
            .selectedImagePath2
            .value ==
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
    } else {
     // mobileController.isLoading2.value == true;
      log("tttapped");
      contr.uploadImageToFirebase(
        link_to_buy_ticket: widget.link_to_buy_ticket,
          who_play: widget.who_play,
          event_title: widget.event_title,
          street_address: widget.street_address,
          state_address: widget.state_address,
          zip_code: widget.zip_code,
          city_address: widget.city_address,
          genre: widget.genre,
          when_is_it: widget.when_is_it,
          when_door_open: widget.when_door_open,
          phone: widget.phone,
          how_much_ticket: widget.how_much_ticket,
          available_ticket: widget.available_ticket,
          event_caption: widget.event_caption,
          instagram_link: widget.instagram,
          spotfy_link: widget.spotify,
          event_create_user: widget.event_create_user
      );
      log("dddd");
    }



  },
  child: Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    margin: EdgeInsets.only(left: 20,right: 20,bottom: 20),
    alignment: Alignment.center,
    decoration: BoxDecoration
      (
      color: Colors.black,
      borderRadius: BorderRadius.circular(20),
    ),
    child: CustomText(text: "Submit Application",size: 13,color: Colors.white,),
  ),
))
      ,
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
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
                    CustomText(text: "Event Images",size: 24,bold: FontWeight.w700,),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 120,),
              customWidget(
                  icon:Obx(() =>    contr.selectedImagePath.value==""  ? InkWell(
                      onTap: (){
                        Get.defaultDialog(
                          title: "Image Picker",
                          titleStyle: TextStyle(
                            fontSize: 18,
                          ),
                          middleText: "Select Image From Gallery",
                          middleTextStyle: TextStyle(
                            fontSize: 14,
                          ),
                          radius: 5,
                          actions: [
                            Obx(() {
                              if (contr.isLoading.value) {
                                return Center(
                                  child: CircularProgressIndicator(

                                  ),
                                );
                              }
                              return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),

                                  ),
                                  onPressed: () {
                                    contr
                                        .getImage(ImageSource.gallery);
                                    Get.back();
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }),
                            Obx(() {
                              if (contr.isLoading.value) {
                                return Center(
                                    child:
                                    CircularProgressIndicator()
                                );
                              }
                              return ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.blue)),
                                  onPressed: () {
                                    contr
                                        .getImage(ImageSource.camera);
                                    Get.back();
                                  },
                                  child: Text("Camera"));
                            }),
                          ],
                        );
                      },
                      child: Image.asset("images/camera_img.png",fit: BoxFit.fill,height: 22,width: 22,)):
                  InkWell(
                  onTap: (){
        Get.defaultDialog(
        title: "Image Picker",
        titleStyle: TextStyle(
        fontSize: 18,
        ),
        middleText: "Select Image From Gallery",
        middleTextStyle: TextStyle(
        fontSize: 14,
        ),
        radius: 5,
        actions: [
        Obx(() {
        if (contr.isLoading.value) {
        return Center(
        child: CircularProgressIndicator(
        ),
        );
        }
        return ElevatedButton(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),

        ),
        onPressed: () {
        contr
            .getImage(ImageSource.gallery);
        Get.back();
        },
        child: Text(
        "Gallery",
        style: TextStyle(color: Colors.white),
        ));
        }),
        Obx(() {
        if (contr.isLoading.value) {
        return Center(
        child:
        CircularProgressIndicator()
        );
        }
        return ElevatedButton(
        style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all(
        Colors.blue)),
        onPressed: () {
        contr
            .getImage(ImageSource.camera);
        Get.back();
        },
        child: Text("Camera"));
        }),
        ],
        );
        },
          child: Container(
            height: 130,
             width:MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                    color: Colors.black, width: 1),
                image: DecorationImage(
                    image: FileImage(File(
                        contr
                            .selectedImagePath.value)

                    ),
                    fit: BoxFit.fill
                )),
          ),
        )),
                  txt: "Upload banner picture (this will show up on the home screen). Please select an image that is horizontal"),
              SizedBox(height: 120,),
              customWidget(
                  icon:Obx(() =>    contr.selectedImagePath2.value==""  ? InkWell(
                      onTap: (){
                        Get.defaultDialog(
                          title: "Image Picker",
                          titleStyle: TextStyle(
                            fontSize: 18,
                          ),
                          middleText: "Select Image From Gallery",
                          middleTextStyle: TextStyle(
                            fontSize: 14,
                          ),
                          radius: 5,
                          actions: [
                            Obx(() {
                              if (contr.isLoading2.value) {
                                return Center(
                                  child: CircularProgressIndicator(
                                  ),
                                );
                              }
                              return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),

                                  ),
                                  onPressed: () {
                                    contr
                                        .getImage2(ImageSource.gallery);
                                    Get.back();
                                  },
                                  child: Text(
                                    "Gallery",
                                    style: TextStyle(color: Colors.white),
                                  ));
                            }),
                            Obx(() {
                              if (contr.isLoading2.value) {
                                return Center(
                                    child:
                                    CircularProgressIndicator()
                                );
                              }
                              return ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.blue)),
                                  onPressed: () {
                                    contr
                                        .getImage2(ImageSource.camera);
                                    Get.back();
                                  },
                                  child: Text("Camera"));
                            }),
                          ],
                        );
                      },
                      child:Image.asset("images/camera_img.png",fit: BoxFit.fill,height: 22,width: 22,)):
                  InkWell(
                    onTap: (){
                      Get.defaultDialog(
                        title: "Image Picker",
                        titleStyle: TextStyle(
                          fontSize: 18,
                        ),
                        middleText: "Select Image From Gallery",
                        middleTextStyle: TextStyle(
                          fontSize: 14,
                        ),
                        radius: 5,
                        actions: [
                          Obx(() {
                            if (contr.isLoading2.value) {
                              return Center(
                                child: CircularProgressIndicator(
                                ),
                              );
                            }
                            return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),

                                ),
                                onPressed: () {
                                  contr
                                      .getImage2(ImageSource.gallery);
                                  Get.back();
                                },
                                child: Text(
                                  "Gallery",
                                  style: TextStyle(color: Colors.white),
                                ));
                          }),
                          Obx(() {
                            if (contr.isLoading2.value) {
                              return Center(
                                  child:
                                  CircularProgressIndicator()
                              );
                            }
                            return ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all(
                                        Colors.blue)),
                                onPressed: () {
                                  contr
                                      .getImage2(ImageSource.camera);
                                  Get.back();
                                },
                                child: Text("Camera"));
                          }),
                        ],
                      );
                    },
                    child: Container(
                      height: 330,
                      width:220,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              color: Colors.black, width: 1),
                          image: DecorationImage(
                              image: FileImage(File(
                                  contr
                                      .selectedImagePath2.value)

                              ),
                              fit: BoxFit.fill
                          )),
                    ),
                  )),
                  txt: "Upload concert poster (this will show up on the Event Information screen). Please select an image that is vertical"),    SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text("Note: Low resolution images might result in your submission to be denied",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w700),),
              ),
              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }

customWidget({final txt,icon}){
    return Column(
      children: [
        icon,
       // Icon(Icons.insert_photo_rounded,size: 30,),
       SizedBox(height: 40,),
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 40.0),
         child: Text(txt,textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.w700),),
       )
      ],
    );
}
}
