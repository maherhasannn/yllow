import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/comming_soon/coming_soon_screen.dart';
import 'package:new_yellow/screens/concert_dashboard/view/concert_dashboard_screen.dart';
import 'package:new_yellow/screens/profile/controler/profile_controler.dart';
import 'package:new_yellow/utils/common.dart';
import 'package:new_yellow/utils/custom_dialog.dart';

import '../../../auth/login/controller/login_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: CustomBottomNavBar(index: 1,),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Center(child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 70,width: 70,)),
                SizedBox(height: 40,),
                CustomText(text: "Hi ${Get.find<GetStorageController>().box.read(COMMONS.NAME)},",size: 20,bold: FontWeight.w700,color: Colors.black,),
                CustomText(text: "Watch me do a front-flip",size: 20,color: Colors.black,),
                SizedBox(height: 40,),
                CustomText(text: "PREFERENCES",size: 14,color: Color(0xffd4d4d4),bold: FontWeight.w500,),
                SizedBox(height: 10,),
                customNotification(),
                SizedBox(height: 30,),
                CustomText(text: "PERSONAL INFORMATION",size: 14,color: Color(0xffd4d4d4),bold: FontWeight.w500,),
                SizedBox(height: 10,),
                customPersonalInfo(hint:Get.find<GetStorageController>().box.read(COMMONS.EMAIL_ID),icon:"images/call.png"),
                SizedBox(height: 30,),
                CustomText(text: "YLLOW WRISTBAND",size: 14,color: Color(0xffd4d4d4),bold: FontWeight.w500,),
                customSupport(
                    onTap:(){
                      Get.to(()=>CommingSoonScreen());
                    },
                    text: "Pair Wristband"),
                // SizedBox(height: 10,),
                //
                // customPersonalInfo(hint: "COMING SOON",icon:"images/scann.png",onTap: (){
                //   Get.to(()=>CommingSoonScreen());
                // }),

                SizedBox(height: 30,),
                CustomText(text: "SUPPORT",size: 14,color: Color(0xffd4d4d4),bold: FontWeight.w500,),
                SizedBox(height: 10,),
                customSupport(
                    onTap:(){
                      Get.to(()=>ConcertDashboardScreen());
                      },
                    text: "Concert Dashboard"),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1,),
                ),
                customSupport(
                    onTap:(){},
                   text: "Terms & Conditions"),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1,),
                ),
                customSupport(
                    onTap:(){},text: "Privacy Policy"),

                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1,),
                ),
                customSupport(
                    onTap:(){},
                   text: "Rate Our App"),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Divider(color: Colors.black.withOpacity(0.3),thickness: 1,),
                ),
                customSupport(
                    onTap:(){
                      Get.find<GetStorageController>().removeStorage();
                    },text: "Logout"),

                SizedBox(height: 20,),
                Center(child: CustomText(text: "Version 1.4.1 Early Release",size: 12,color: Colors.black,bold: FontWeight.w500,)),
                SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  customNotification()
  {
    return InkWell(
      onTap: ()
      {
        Dialouge_Box.notificationDialog();

      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: "Notifications",size: 12,color: Colors.black,bold: FontWeight.w500,),
          Obx(() =>  Get.find<ProfileController>().notificationArrowClick.value ?  Icon(Icons.arrow_forward_ios_rounded,size: 20,color: Colors.black.withOpacity(0.5),):cutomContainer(),
          ),
            ],
      ),
    );


  }
  cutomContainer(){
    return
     Obx(() =>  Container(
       height: 20,
       width: 20,
       alignment: Alignment.center,
       decoration: BoxDecoration(
         //color:  Colors.green,
       ),
       child: Get.find<ProfileController>().notificationClicked.value ?  Icon(Icons.check_box,color: Colors.green,):Icon(Icons.clear,color: Colors.red,size: 25,),
     ));
  }


  customSupport({final text,final onTap}){
    return
      Padding(
      padding:  EdgeInsets.only(top: 10),
      child: InkWell(
        onTap:onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
          [
           Hero(
               tag: "hero_anim6",
               child: CustomText(text:text ,size: 16)),
            Icon(Icons.arrow_forward_ios_rounded,size: 20,color: Colors.black.withOpacity(0.5),) ,
          ],
        ),
      ),
    );
  }

  customPersonalInfo({final hint,final icon,var onTap}){
    return  InkWell(
      onTap:onTap ,
      child: CustomText(text:hint ,size: 16),
    );
  }
}
