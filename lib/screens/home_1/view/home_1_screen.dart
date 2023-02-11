
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:new_yellow/screens/main_ticket_pages/concert_information_explanation/concert_info_screen.dart';
import 'package:new_yellow/utils/common.dart';

import '../../../global_widget/custom_text.dart';
import '../../../global_widget/loader.dart';
import '../../../utils/location.dart';
import '../../../utils/re_usable_dialog.dart';
import '../../concert_dashboard/concert_page/concert_third_party_ticket_screen.dart';
import '../../main_ticket_pages/concert_information_explanation/concert_inf_exp_buy_ticket.dart';
import '../../main_ticket_pages/my_ticket/view/my_free_ticket.dart';
import '../../main_ticket_pages/my_ticket/view/my_ticket_expanded_screen.dart';
import '../widget/custom_home_header.dart';

class Home_1_Screen extends StatefulWidget {
  const Home_1_Screen({Key? key}) : super(key: key);

  @override
  State<Home_1_Screen> createState() => _Home_1_ScreenState();

}

class _Home_1_ScreenState extends State<Home_1_Screen> {
  void initState(){
    super.initState();
    _getUserName();
  }
  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {

        Get.find<GetStorageController>().writeStorage(COMMONS.NAME, value['name'].toString());
        Get.find<GetStorageController>().writeStorage(COMMONS.EMAIL_ID, value['email'].toString());
      });
    });
  }
  final db = FirebaseFirestore.instance.collection("Events").where("event_publish",isEqualTo: "Publish").snapshots();


  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // log("getlocation"+  Get.find<GetStorageController>().box.read(COMMONS.locationEnable).toString()) ;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomBottomNavBar(index: 0,),
      body:
      SafeArea(

        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                CustomHomeHeader(),
                SizedBox(height: 20,),
                CustomText(text: "Welcome back",size: 16,color: Colors.black,bold: FontWeight.w500,),
                CustomText(text: "You’re still at home? lol",size: 21,bold: FontWeight.w800,color: Colors.black,),
                SizedBox(height: 20,),
              Row(children:
              [
                Image.asset("images/date_range.png",height: 20,width: 20,fit: BoxFit.fill,),
                SizedBox(width: 5,),
                Text(
                  "Today",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:12,
                  ),
                ),
                SizedBox(width: 5,),
                Expanded(child: Divider(color: Colors.black.withOpacity(0.5),thickness: 1,)),
              ],),
                SizedBox(height:Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"? 20:60,),
              Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?
             StreamBuilder<QuerySnapshot>(
                 stream:db,
                 builder: (context,snapshot)
                 {
                   if (!snapshot.hasData) {
                     return Center(
                       child: Padding(
                         padding: const EdgeInsets.only(top: 120),
                         child: kLoader(),
                       ),
                       //CircularProgressIndicator(),
                     );
                   }
                   else if (!snapshot.hasData ||
                       snapshot.hasError ||
                       snapshot.data == null ||
                       snapshot.data!.docs.isEmpty)
                   {
                     return
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,

                         children: [
                           Center(child: Image.asset("images/no_concert.png",height: 34,width: 34,fit: BoxFit.fill,)),
                           Padding(
                             padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
                             child: CustomText(text: "More concerts near you any day now...",size: 16,bold: FontWeight.w700,color: Colors.black,),
                           ),

                           Padding(
                             padding:  EdgeInsets.only(left: 40.0,right: 40,top: 30),
                             child: CustomText(text: "Doesn’t look like there are any upcoming events in your area. Check back soon to be first to find out about new shows",size: 14,bold: FontWeight.w300,color: Color(0xff4E4E4E),),
                           ),

                           // Padding(
                           //   padding:  EdgeInsets.only(top: 30),
                           //   child: InkWell(
                           //       onTap: () async
                           //       {
                           //
                           //         log("clickeddddddddddddddddddddd");
                           //
                           //         Position position =
                           //         await GetLocation.getGeoLocationPosition().whenComplete(() {
                           //
                           //           setState(() {
                           //             Get.find<GetStorageController>().writeStorage(COMMONS.locationEnable, "true");
                           //           });
                           //           Get.offAll(()=>Home_1_Screen());
                           //
                           //         });
                           //         setState(() {
                           //           log("latitude "+position.latitude.toString());
                           //
                           //           Get.find<GetStorageController>()
                           //               .box
                           //               .write(P_LATITUDE, position.latitude.toString());
                           //           Get.find<GetStorageController>()
                           //               .box
                           //               .write(P_LONGITUDE, position.longitude.toString());
                           //           Get.find<GetStorageController>()
                           //               .box
                           //               .write(E_LATITUDE, position.latitude.toString());
                           //           Get.find<GetStorageController>()
                           //               .box
                           //               .write(E_LONGITUDE, position.longitude.toString());
                           //         });
                           //       },
                           //       child: Center(child: CustomText(text: " Open Settings",size: 16,bold: FontWeight.w700,color: Color(0xff4E4E4E),))),
                           // ),
                         ],);
                   }
                   else{
                     return ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         shrinkWrap: true,
                         physics: NeverScrollableScrollPhysics(),
                         itemBuilder: (context,index)
                         {
                           log("lati"+Get.find<GetStorageController>()
                               .box.read(E_LATITUDE)
                               .toString());
                           double datainMeter= GetLocation.DistanceInMeters(
                               double.parse(snapshot.data!.docs[index]["latitude"].toString()),
                               double.parse(snapshot.data!.docs[index]["longitude"].toString()),
                               double.parse(Get.find<GetStorageController>()
                                   .box.read(E_LATITUDE)
                                   .toString()),
                               double.parse(Get.find<GetStorageController>()
                                   .box.read(E_LONGITUDE)
                                   .toString()));

                           if(datainMeter < 50000)
                           {
                             return  HomeListItem(
                               onTap: (){
                                 if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="Free"){
                                   Get.to(()=>ConcertInformationScreen(
                                     docId: snapshot.data!.docs[index].id.toString(),
                                     caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                     instagram: snapshot.data!.docs[index]["instagram_link"].toString(),
                                     spotify: snapshot.data!.docs[index]["spotfy_link"].toString(),
                                     price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                     genre: snapshot.data!.docs[index]["genre"].toString() ,
                                     img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                     city: snapshot.data!.docs[index]["city_address"].toString(),
                                     street: snapshot.data!.docs[index]["street_address"].toString(),
                                     state: snapshot.data!.docs[index]["state_address"].toString(),
                                     postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                     date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                     title: snapshot.data!.docs[index]["who_play"].toString(),
                                   ));
                                 }
                                else if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$5 (Third-Party ticket broker)"
                                 ||snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$10 (Third-Party ticket broker)"
                                     ||snapshot.data!.docs[index]["how_much_ticket"].toString()=="\$15 (Third-Party ticket broker)"
                                 )
                                 {

                                   Get.to(()=>ConcertInformationThirdParTicScreen(
                                     city: snapshot.data!.docs[index]["city_address"].toString(),
                                     street: snapshot.data!.docs[index]["street_address"].toString(),
                                     state: snapshot.data!.docs[index]["state_address"].toString(),
                                     postalCode: snapshot.data!.docs[index]["zip_code"].toString(),
                                     link_to_buy_ticket: snapshot.data!.docs[index]["link_to_buy_ticket"].toString(),
                                     instagram: snapshot.data!.docs[index]["instagram_link"].toString(),
                                     spotify: snapshot.data!.docs[index]["spotfy_link"].toString(),
                                     docId: snapshot.data!.docs[index].id.toString(),
                                     caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                     price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                     genre: snapshot.data!.docs[index]["genre"].toString() ,
                                     img: snapshot.data!.docs[index]["concert_pic"].toString(),
                                     date: snapshot.data!.docs[index]["when_is_it"].toString(),
                                     title: snapshot.data!.docs[index]["who_play"].toString(),
                                   ));
                                 }
                                 else{

                                   Get.to(()=>ConcertInformationBuyTicScreen(
                                     instagram: snapshot.data!.docs[index]["instagram_link"].toString(),
                                     spotify: snapshot.data!.docs[index]["spotfy_link"].toString(),
                                     docId: snapshot.data!.docs[index].id.toString(),
                                     caption: snapshot.data!.docs[index]["event_caption"].toString(),
                                     price:  snapshot.data!.docs[index]["how_much_ticket"].toString(),
                                     genre: snapshot.data!.docs[index]["genre"].toString() ,
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
                               txt1: snapshot.data!.docs[index]["event_title"].toString(),
                               txt2: snapshot.data!.docs[index]["how_much_ticket"].toString(),
                               txt3: snapshot.data!.docs[index]["city_address"].toString(),
                               img: snapshot.data!.docs[index]["banner_pic"].toString(),);

                           }
                           else{
                             return
                               SizedBox.shrink();

                           }

                         });
                   }
                 }
             ):
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,

               children: [
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
                          Get.offAll(()=>Home_1_Screen());

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
}
