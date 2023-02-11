
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
import '../../main_ticket_pages/concert_information_explanation/concert_inf_exp_buy_ticket.dart';
import '../../main_ticket_pages/my_ticket/view/my_free_ticket.dart';
import '../../main_ticket_pages/my_ticket/view/my_ticket_expanded_screen.dart';
import '../widget/custom_home_header.dart';

class EnableMapScreen extends StatefulWidget {
  const EnableMapScreen({Key? key}) : super(key: key);

  @override
  State<EnableMapScreen> createState() => _EnableMapScreenState();

}

class _EnableMapScreenState extends State<EnableMapScreen> {
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


  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

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
                CustomText(text: "You’re still at home? lol",size: 18,bold: FontWeight.w700,color: Colors.black,),
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
                  Expanded(child: Divider(color: Colors.black,thickness: 2,)),
                ],),
                SizedBox(height: 60,),
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
                     onTap: (){
                       getposition() async {

                         Position position =
                         await GetLocation.getGeoLocationPosition().whenComplete(() {



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
                       }
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
