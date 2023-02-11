import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/concert_page/concert_p_1.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

import '../../../../controller/get_storage_controller.dart';
import '../../../../global_widget/loader.dart';
import '../../../../utils/common.dart';
import '../../../../utils/location.dart';
import '../../../concert_dashboard/concert_page/concert_p_2.dart';
import '../widget/my_ticket_widget.dart';
import 'my_free_ticket.dart';
import 'my_ticket_expanded_screen.dart';



class MyTicketHome extends StatefulWidget {

  @override
  State<MyTicketHome> createState() => _MyTicketHomeState();
}

class _MyTicketHomeState extends State<MyTicketHome> {
 // final db = FirebaseFirestore.instance.collection("Events").where("uid",isEqualTo: Get.find<GetStorageController>().box.read(COMMONS.EVENT_DOC_ID).toString() ).snapshots();
  FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    //getposition();

  }
  //
  // getposition() async {
  //
  //   Position position =
  //   await GetLocation.getGeoLocationPosition().whenComplete(() {
  //
  //   });
  //  setState(() {
  //    Get.find<GetStorageController>()
  //        .box
  //        .write(P_LATITUDE, position.latitude.toString());
  //    Get.find<GetStorageController>()
  //        .box
  //        .write(P_LONGITUDE, position.longitude.toString());
  //    Get.find<GetStorageController>()
  //        .box
  //        .write(E_LATITUDE, position.latitude.toString());
  //    Get.find<GetStorageController>()
  //        .box
  //        .write(E_LONGITUDE, position.longitude.toString());
  //  });
  // }


  @override
  Widget build(BuildContext context) {
    // log("current id "+Get.find<GetStorageController>()
    //     .box.read(E_LATITUDE)
    //     .toString() );
    // log( Get.find<GetStorageController>().box.read(COMMONS.EVENT_DOC_ID).toString());
    // log(auth.currentUser!.uid.toString());
    // log(DateTime.now().toString());

    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomBottomNavBar(index: 2,),
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
                    Spacer(),
                    Image.asset(height: 60,width:60,"images/p_3.png",fit: BoxFit.fill,),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(text: "My Tickets",size: 24,bold: FontWeight.w700,color: Colors.black,),
              ),
              Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  StreamBuilder<QuerySnapshot>(
                    //  stream: FirebaseFirestore.instance.collection("Events").snapshots(),
                       stream: FirebaseFirestore.instance.collection("Events").where("participants.uid",isEqualTo: auth.currentUser!.uid ).snapshots(),
                      builder: (context,snapshot)
                      {
                        List<QueryDocumentSnapshot> upcomingEventlist = [];
                        List<QueryDocumentSnapshot> pastEventList = [];
                        snapshot.data!.docs.forEach((element) {
                          DateTime datee = DateTime.parse(element.get("when_is_it"));
                          if (datee.isBefore(DateTime.now())) {
                            pastEventList.add(element);
                          } else
                            upcomingEventlist.add(element);
                        });
                        if (!snapshot.hasData) {
                          return Center(
                            child:  Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: kLoader(),
                            ),
                          );
                        }
                        else if (!snapshot.hasData ||
                            snapshot.hasError ||
                            snapshot.data == null ||
                            snapshot.data!.docs.isEmpty || upcomingEventlist.length == 0)
                        {
                          return
                            Container(
                              height: 200,
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.black.withOpacity(0.2),width: 1)
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Image.asset(height: 60,width:60,"images/my_t_1.png",fit: BoxFit.fill,),
                                  SizedBox(height: 10,),
                                  CustomText(text: "Let’s get you live again",size: 14,bold: FontWeight.w700,color: Colors.black,),
                                  SizedBox(height: 20,),
                                  CustomText(text: "You don’t have tickets to any upcoming events. We’ll help you get to your next event without charging “service fees”.",size: 14,bold: FontWeight.w700,color: Colors.black.withOpacity(0.5),)
                                ],
                              ),
                            );
                        }
                        else{
                          return ListView.builder(
                              itemCount: upcomingEventlist.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)
                              {
                                double datainMeter= GetLocation.DistanceInMeters(
                                    double.parse(upcomingEventlist[index]["latitude"].toString()),
                                    double.parse(upcomingEventlist[index]["longitude"].toString()),
                                    double.parse(Get.find<GetStorageController>()
                                        .box.read(E_LATITUDE)
                                        .toString()),
                                    double.parse(Get.find<GetStorageController>()
                                        .box.read(E_LONGITUDE)
                                        .toString()));
                                if(datainMeter < 50000){
                                  if(upcomingEventlist[index]["ticket_sold"].toString() == "ticket_sold" ||upcomingEventlist[index]["will_be_there"].toString() == "will_be_there"){
                                    return   MyTicketWidget(
                                      onTap: (){
                                        if(upcomingEventlist[index]["ticket_sold"].toString() == "ticket_sold")
                                        {

                                          Get.to(()=>MyTicketExpScreen(
                                            docId: upcomingEventlist[index].id.toString(),
                                            img: upcomingEventlist[index]["concert_pic"].toString(),
                                            city: snapshot.data!.docs[index]["city_address"].toString(),
                                            street: snapshot.data!.docs[index]["street_address"].toString(),
                                            state: snapshot.data!.docs[index]["state_address"].toString(),
                                            postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                            date:upcomingEventlist[index]["when_is_it"].toString(),
                                            title: upcomingEventlist[index]["who_play"].toString(),
                                          ));
                                        }
                                        else{
                                          Get.to(()=>MyFreeTicketScreen(
                                            img: upcomingEventlist[index]["concert_pic"].toString(),
                                            city: snapshot.data!.docs[index]["city_address"].toString(),
                                            street: snapshot.data!.docs[index]["street_address"].toString(),
                                            state: snapshot.data!.docs[index]["state_address"].toString(),
                                            postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                            date: upcomingEventlist[index]["when_is_it"].toString(),
                                            title: upcomingEventlist[index]["who_play"].toString(),
                                          ));

                                        }
                                      },
                                      txt1: upcomingEventlist[index]["event_title"].toString(),
                                      txt2: upcomingEventlist[index]["when_is_it"].toString(),
                                      txt3: upcomingEventlist[index]["street_address"].toString(),
                                      img: upcomingEventlist[index]["banner_pic"].toString(),);
                                  }
                                  else{
                                    return SizedBox.shrink();
                                  }
                                }
                                else{
                                  return SizedBox.shrink();
                                }
                              });
                        }
                      }
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(text: "Past Concerts",size: 15,bold: FontWeight.w700,color: Colors.black,),
                  ),
                  SizedBox(height: 10,),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Image.asset(height: 30,width:40,"images/my_t_2.png",fit: BoxFit.fill,),
          // ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Events").where("participants.uid",isEqualTo: auth.currentUser!.uid ).snapshots(),
                      //stream: FirebaseFirestore.instance.collection("Events").snapshots(),
                      builder: (context,snapshot)
                      {
                        List<QueryDocumentSnapshot> upcomingEventlist = [];
                        List<QueryDocumentSnapshot> pastEventList = [];
                        snapshot.data!.docs.forEach((element) {
                          DateTime datee = DateTime.parse(element.get("when_is_it"));

                          if (datee.isBefore(DateTime.now())) {
                            pastEventList.add(element);
                          } else
                            upcomingEventlist.add(element);
                        });

                        if (!snapshot.hasData) {
                          return Center(
                            child:  Padding(
                              padding: const EdgeInsets.only(top: 120),
                              child: kLoader(),
                            ),
                          );
                        }
                        else if (!snapshot.hasData ||
                            snapshot.hasError ||
                            snapshot.data == null ||
                            snapshot.data!.docs.isEmpty || pastEventList.length == 0)
                        {
                          return
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Image.asset(height: 30,width:40,"images/my_t_2.png",fit: BoxFit.fill,),
                            );
                        }
                        else{
                          return ListView.builder(
                              itemCount: pastEventList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context,index)
                              {
                                double datainMeter= GetLocation.DistanceInMeters(
                                    double.parse(pastEventList[index]["latitude"].toString()),
                                    double.parse(pastEventList[index]["longitude"].toString()),
                                    double.parse(Get.find<GetStorageController>()
                                        .box.read(E_LATITUDE)
                                        .toString()),
                                    double.parse(Get.find<GetStorageController>()
                                        .box.read(E_LONGITUDE)
                                        .toString()));
                                if(datainMeter < 5000){
                                  if(pastEventList[index]["ticket_sold"].toString() == "ticket_sold" ||pastEventList[index]["will_be_there"].toString() == "will_be_there"){
                                    return   MyTicketWidget(
                                      onTap: (){
                                        if(pastEventList[index]["ticket_sold"].toString() == "ticket_sold")
                                        {

                                          Get.to(()=>MyTicketExpScreen(
                                            docId: pastEventList[index].id.toString(),
                                            img: pastEventList[index]["concert_pic"].toString(),
                                            city: snapshot.data!.docs[index]["city_address"].toString(),
                                            street: snapshot.data!.docs[index]["street_address"].toString(),
                                            state: snapshot.data!.docs[index]["state_address"].toString(),
                                            postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                            date: pastEventList[index]["when_is_it"].toString(),
                                            title: pastEventList[index]["who_play"].toString(),
                                          ));
                                        }
                                        else{
                                          Get.to(()=>MyFreeTicketScreen(
                                            img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                            city: snapshot.data!.docs[index]["city_address"].toString(),
                                            street: snapshot.data!.docs[index]["street_address"].toString(),
                                            state: snapshot.data!.docs[index]["state_address"].toString(),
                                            postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                            date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                            title: snapshot.data!.docs[index]["who_play"].toString(),
                                          ));
                                        }
                                      },
                                      txt1: pastEventList[index]["event_title"].toString(),
                                      txt2: pastEventList[index]["when_is_it"].toString(),
                                      txt3: pastEventList[index]["street_address"].toString(),
                                      img: pastEventList[index]["banner_pic"].toString(),);
                                  }
                                  else{
                                    return SizedBox.shrink();
                                  }
                                }
                                else{
                                  return SizedBox.shrink();
                                }
                              });
                        }
                      }
                  ),

                  SizedBox(height: 20,),
                ],
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 100,),
                  Center(child: Image.asset("images/map_screen_image.png",height: 34,width: 34,fit: BoxFit.fill,)),
                  Padding(
                    padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
                    child: CustomText(text: "We use your location to find you shows nearby!",size: 16,bold: FontWeight.w700,color: Colors.black,),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
                    child: CustomText(text: "Allow ‘Yllow’ to access your location so we can find you your next life-changing, earth-shattering, ear-melting concert.",size: 14,bold: FontWeight.w300,color: Color(0xff4E4E4E),),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(top: 30),
                    child: InkWell(
                        onTap: () async
                        {

                          log("clickeddddddddddddddddddddd");

                          Position position =
                          await GetLocation.getGeoLocationPosition().whenComplete(() {

                            setState(() {
                              Get.find<GetStorageController>().writeStorage(COMMONS.locationEnable, "true");
                            });
                            Get.offAll(()=>MyTicketHome());

                          });
                          setState(() {
                            log("latitude "+position.latitude.toString());

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
                          });
                        },
                        child: Center(child: CustomText(text: " Open Settings",size: 16,bold: FontWeight.w700,color: Color(0xff4E4E4E),))),
                  ),
                ],),
            ],
          ),
        ),
      ),
    );
  }
}
