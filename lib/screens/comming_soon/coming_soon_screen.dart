import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/view/consert_tips_screen.dart';
import 'package:new_yellow/screens/profile/view/profile_screen.dart';

class CommingSoonScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customBottonIcon(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.05,),
               
                SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                Center(child: CustomText(text: "Y L L O W",size: 32,bold: FontWeight.w700,color: Colors.black,)),
                Center(child: CustomText(text: "EARLY RELEASE",size: 16,bold: FontWeight.w700,color: Colors.black,)),
                SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                Center(child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 136,width: 136,)),
                SizedBox(height: MediaQuery.of(context).size.height*0.08,),
                Center(child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:10,),
                  child: CustomText(text: "Yllow Wristband pairing coming soon!",size: 16,bold: FontWeight.w600,color: Colors.black,),
                )),
                SizedBox(height: 40,),
                Center(child: Image.asset("images/comming.png",fit: BoxFit.fill,height: 28,width: 28,)),
                SizedBox(height:5,),
                Center(child: CustomText(text: "Learn More",size: 14,bold: FontWeight.w600,color: Color(0xffA3A3A3),underLine: TextDecoration.underline,)),

                SizedBox(height: MediaQuery.of(context).size.height*0.27,),
                SizedBox(height: 10,),
                          ],
            ),
          ),
        ),
      ),
    );
  }
  customBottonIcon(){
    return Container(
      height: 100,
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(()=>ProfileScreen());
            },
            child: Container(
              height: 40,
              width: 220,
              alignment: Alignment.center,
              decoration: BoxDecoration
                (
                color: Colors.transparent,
              ),
              child: CustomText(text: "Back",size: 24,color: Color(0xff999999),bold: FontWeight.w700,),
            ),
          ),
          // SizedBox(height: 10,),
          // InkWell(
          //     onTap: (){
          //    //   Get.to(()=>ConcertTipsScreen());
          //     },
          //     child: Image.asset(height: 20,width:20,"images/p_2.png",fit: BoxFit.fill,)),
        ],
      ),
    );
  }

}
