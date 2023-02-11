import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:new_yellow/auth/login/view/login_screen.dart';
import 'dart:math' as math;

import 'package:new_yellow/auth/splash_screen/loading_gif.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/screens/admin/view/admin_panel_request.dart';
import 'package:new_yellow/screens/home_1/view/home_1_screen.dart';

import '../../screens/home_1/view/enable_map_screen.dart';
import '../../utils/common.dart';
import '../../utils/location.dart';
import '../sign_up/view/name_screen.dart';
import '../welcome_screen/welcome_screen.dart';





class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {


  void initState() {
    super.initState();
    _getUserName().whenComplete(() =>  Timer(Duration(seconds: 7), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user)
      {
        if(user==null)
        {
          Get.to(() => WelcomeScreen());
        //  Get.offAll(() =>  NameRegistration());

        }
        else{
          {
            if(Get.find<GetStorageController>().box.read(COMMONS.A_ID) == COMMONS.ADMIN_UID)
            {
              Get.offAll(()=>AdminRequestScreen());
            }
            else{
             // Get.offAll(()=>EnableMapScreen());
              Get.offAll(()=>Home_1_Screen());
            }


          }
        }
      });

    }),);

  }
  // getposition() async {
  //
  //   Position position =
  //   await GetLocation.getGeoLocationPosition().whenComplete(() {
  //     _getUserName().whenComplete(() =>  Timer(Duration(seconds: 7), () {
  //       FirebaseAuth.instance.authStateChanges().listen((User? user)
  //       {
  //         if(user==null)
  //         {
  //           Get.offAll(() =>  NameRegistration());
  //
  //         }
  //         else{
  //           {
  //             if(Get.find<GetStorageController>().box.read(COMMONS.A_ID) == COMMONS.ADMIN_UID)
  //             {
  //               Get.offAll(()=>AdminRequestScreen());
  //             }
  //             else{
  //               Get.offAll(()=>EnableMapScreen());
  //               //Get.offAll(()=>Home_1_Screen());
  //             }
  //
  //
  //           }
  //         }
  //       });
  //
  //     }),);
  //
  //   });
  //   Get.find<GetStorageController>()
  //       .box
  //       .write(P_LATITUDE, position.latitude.toString());
  //   Get.find<GetStorageController>()
  //       .box
  //       .write(P_LONGITUDE, position.longitude.toString());
  //   Get.find<GetStorageController>()
  //       .box
  //       .write(E_LATITUDE, position.latitude.toString());
  //   Get.find<GetStorageController>()
  //       .box
  //       .write(E_LONGITUDE, position.longitude.toString());
  // }
  //

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc((await FirebaseAuth.instance.currentUser!).uid)
        .get()
        .then((value) {
      setState(() {

        Get.find<GetStorageController>().writeStorage(COMMONS.NAME, value['name'].toString());
        Get.find<GetStorageController>().writeStorage(COMMONS.EMAIL_ID, value['email'].toString());
        Get.find<GetStorageController>().writeStorage(COMMONS.A_ID, value['uid'].toString());
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child:Padding(
            padding: const EdgeInsets.only(left: 48,right: 48),
            child: Hero(
              tag: "hero_anim",
              child: Container(
                width: double.infinity,
                height: 294,
                child: Image.asset('images/p_3.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
