import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/view/consert_tips_screen.dart';

import '../../../controller/get_storage_controller.dart';
import '../../../global_widget/loader.dart';
import '../../../utils/common.dart';
import '../../../utils/location.dart';
import '../../main_ticket_pages/concert_information_explanation/concert_inf_exp_buy_ticket.dart';
import '../../main_ticket_pages/concert_information_explanation/concert_info_screen.dart';
import '../../main_ticket_pages/my_ticket/view/my_free_ticket.dart';
import '../../main_ticket_pages/my_ticket/view/my_ticket_expanded_screen.dart';
import '../../main_ticket_pages/my_ticket/widget/my_ticket_widget.dart';
import '../concert_page/concert_p_1.dart';
import '../concert_page/concert_p_2.dart';
import '../concert_page/concert_third_party_ticket_screen.dart';
import '../concert_page/dashboard_third_party_ticket.dart';
import '../create_event/view/create_event_screen.dart';
import 'c_d_screen_2.dart';
import 'concert_payment_screen.dart';

class ConcertDashboardScreen extends StatefulWidget {
  @override
  State<ConcertDashboardScreen> createState() => _ConcertDashboardScreenState();
}

class _ConcertDashboardScreenState extends State<ConcertDashboardScreen> {
  final db = FirebaseFirestore.instance.collection("Events").where("uid",isEqualTo:Get.find<GetStorageController>().box.read(COMMONS.EVENT_DOC_ID) ).snapshots();
  void initState(){
    super.initState();
    _getUserName();
    //getposition();
  }

  //
  // getposition() async {
  //
  //   Position position =
  //   await GetLocation.getGeoLocationPosition().whenComplete(() {
  //
  //   });
  //   setState(() {
  //     Get.find<GetStorageController>()
  //         .box
  //         .write(P_LATITUDE, position.latitude.toString());
  //     Get.find<GetStorageController>()
  //         .box
  //         .write(P_LONGITUDE, position.longitude.toString());
  //     Get.find<GetStorageController>()
  //         .box
  //         .write(E_LATITUDE, position.latitude.toString());
  //     Get.find<GetStorageController>()
  //         .box
  //         .write(E_LONGITUDE, position.longitude.toString());
  //   });
  // }

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Events')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {

       // Get.find<GetStorageController>().writeStorage(COMMONS.EVENT_DOC_ID, value['uid'].toString());
       // Get.find<GetStorageController>().writeStorage(COMMONS.EMAIL_ID, value['email'].toString());
      });
    });
  }
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // log("event id "+Get.find<GetStorageController>().box.read(COMMONS.EVENT_DOC_ID) );
    // log("current id "+Get.find<GetStorageController>()
    //     .box.read(E_LATITUDE)
    //     .toString() );
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(index: 1,),
      bottomSheet: Container(
        height: 70,
        child: Column(
          children: [
            Center(child: CustomText(text: "Need help?",size: 10,bold: FontWeight.w600,color: Colors.black,)),
            SizedBox(height: 10,),
            customBottonIcon()
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap:(){
                            Get.back();
                },
                          child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),
                      Spacer(),
                      Center(child: Hero(
                          tag: "hero_anim6",
                          child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 50,width: 50,))),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "My Concert Dashboard",size: 24,bold: FontWeight.w700,color: Colors.black,),
                    InkWell(
                        onTap: (){
                          Get.to(()=>ConcertTipsScreen());
                        },
                        child: Image.asset(height: 30,width:30,"images/imggg.png",fit: BoxFit.fill,)),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?
                StreamBuilder<QuerySnapshot>(
                    // stream:db,
                   stream: FirebaseFirestore.instance.collection("Events").where("uid",isEqualTo:auth.currentUser!.uid ).snapshots(),

                builder: (context,snapshot)
                    {
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
                          snapshot.data!.docs.isEmpty)
                      {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 68.0),
                            child: Text(
                              "If you can see this text, it means your submission is being reviewed or that you aren’t hosting any shows soon.",
                              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600, color: Color(0xffc0c0c0)),
                            ),
                          ),
                        );
                      }
                      else{
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index)
                            {
                              log("length "+ snapshot.data!.docs.length.toString());
                              double datainMeter= GetLocation.DistanceInMeters(
                                  double.parse(snapshot.data!.docs[index]["latitude"].toString()),
                                  double.parse(snapshot.data!.docs[index]["longitude"].toString()),
                                  double.parse(Get.find<GetStorageController>()
                                      .box.read(E_LATITUDE)
                                      .toString()),
                                  double.parse(Get.find<GetStorageController>()
                                      .box.read(E_LONGITUDE)
                                      .toString()));
                              log(datainMeter.toString());
                              if(datainMeter < 50000){
                              
                              return   MyTicketWidget(
                                onTap: (){
                                  if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="Free"){
                                    Get.to(()=>MyTicketFreePage(
                                      docId: snapshot.data!.docs[index].id.toString(),
                                      caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                      price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                      genre: snapshot.data!.docs[index]["genre"].toString() ,
                                      img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                      location: snapshot.data!.docs[index]["street_address"].toString(),
                                      date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                      title: snapshot.data!.docs[index]["event_title"].toString(),
                                      who_play: snapshot.data!.docs[index]["who_play"].toString(),
                                    ));
                                  }
                                  else if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$5 (Third-Party ticket broker)"
                                          ||snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$10 (Third-Party ticket broker)"
                                          ||snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$15 (Third-Party ticket broker)"
                                      )
                                      {
                                        Get.to(()=>DashboardThirdPartyScreen(
                                          docId: snapshot.data!.docs[index].id.toString(),
                                          caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                          price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                          genre: snapshot.data!.docs[index]["genre"].toString() ,
                                          img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                          location: snapshot.data!.docs[index]["street_address"].toString(),
                                          date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                          title: snapshot.data!.docs[index]["event_title"].toString(),
                                          who_play: snapshot.data!.docs[index]["who_play"].toString(),
                                        ));
                                      }
                                  else{
                                    Get.to(()=>MyPaidTicketScreen(
                                      docId: snapshot.data!.docs[index].id.toString(),
                                      caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                      price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                      genre: snapshot.data!.docs[index]["genre"].toString() ,
                                      img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                      location: snapshot.data!.docs[index]["street_address"].toString(),
                                      date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                      title: snapshot.data!.docs[index]["event_title"].toString(),
                                      who_play: snapshot.data!.docs[index]["who_play"].toString(),
                                    ));
                                  }
                                },
                                txt1: snapshot.data!.docs[index]["event_title"].toString(),
                                txt2: snapshot.data!.docs[index]["when_is_it"].toString(),
                                txt3: snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                img: snapshot.data!.docs[index]["banner_pic"].toString(),);
                                // if(Get.find<GetStorageController>().box.read(COMMONS.EVENT_DOC_ID).toString() == auth.currentUser!.uid.toString()){
                                //   return
                                //     MyTicketWidget(
                                //       onTap: (){
                                //         if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="Free"){
                                //           Get.to(()=>MyFreeTicketScreen(
                                //             img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                //             location: snapshot.data!.docs[index]["street_address"].toString(),
                                //             date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                //             title: snapshot.data!.docs[index]["who_play"].toString(),
                                //           ));
                                //         }
                                //         else{
                                //           Get.to(()=>MyTicketExpScreen(
                                //             docId: snapshot.data!.docs[index].id.toString(),
                                //             img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                //             location: snapshot.data!.docs[index]["street_address"].toString(),
                                //             date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                //             title: snapshot.data!.docs[index]["who_play"].toString(),
                                //           ));
                                //         }
                                //       },
                                //       txt1: snapshot.data!.docs[index]["event_title"].toString(),
                                //       txt2: snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                //       txt3: snapshot.data!.docs[index]["city_address"].toString(),
                                //       img: snapshot.data!.docs[index]["banner_pic"].toString(),);
                                // }
                                // else{
                                //   return
                                //     MyTicketWidget(
                                //       onTap: (){
                                //         if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="Free"){
                                //           Get.to(()=>ConcertInformationScreen(
                                //             docId: snapshot.data!.docs[index].id.toString(),
                                //             caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                //             price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                //             genre: snapshot.data!.docs[index]["genre"].toString() ,
                                //             img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                //             location: snapshot.data!.docs[index]["street_address"].toString(),
                                //             date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                //             title: snapshot.data!.docs[index]["who_play"].toString(),
                                //           ));
                                //         }
                                //         else{
                                //           Get.to(()=>ConcertInformationBuyTicScreen(
                                //             docId: snapshot.data!.docs[index].id.toString(),
                                //             caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                //             price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                //             genre: snapshot.data!.docs[index]["genre"].toString() ,
                                //             img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                //             location: snapshot.data!.docs[index]["street_address"].toString(),
                                //             date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                //             title: snapshot.data!.docs[index]["who_play"].toString(),
                                //           ));
                                //         }
                                //       },
                                //       txt1: snapshot.data!.docs[index]["event_title"].toString(),
                                //       txt2: snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                //       txt3: snapshot.data!.docs[index]["city_address"].toString(),
                                //       img: snapshot.data!.docs[index]["banner_pic"].toString(),);
                                // }
                              }
                              else{
                               return SizedBox.shrink();
                              }

                            });
                      }
                    }
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
                              Get.offAll(()=>ConcertDashboardScreen());

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
      ),
    );
  }

customBottonIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // InkWell(
        //     onTap: (){
        //       // Get.to(()=>ConcertPaymentScreen());
        //     },
        //     child: Image.asset(height: 30,width:30,"images/wallet.png",fit: BoxFit.fill,)),
       InkWell(
         onTap: (){
           Get.to(()=>CreateEventScreen_1(event_create_user: "null",));

           //Get.to(()=>ConcertPaymentScreen());
         // Get.to(()=>CreateEventScreen_1());
         },
         child: Container(
           height: 40,
           width: 260,
           alignment: Alignment.center,
           decoration: BoxDecoration
             (
             color: Colors.black,
             borderRadius: BorderRadius.circular(20),
           ),
           child: CustomText(text: "New Event",size: 13,color: Colors.white,),
         ),
       ),

      ],
    );
}
}
