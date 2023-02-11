import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:new_yellow/stripe_payment_screen/controller.dart';
import 'package:new_yellow/stripe_payment_screen/stripe_payment_screen.dart';

import '../create_event/controller/event_controller.dart';
import '../create_event/view/create_event_screen.dart';

class ConcertPaymentScreen extends StatelessWidget {
  var contr = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
bottomSheet: customBottonIcon(context: context),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.7),),
                      Spacer(),
                      Center(child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 60,width: 60,)),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Payment",size: 24,bold: FontWeight.w700,color: Colors.black,),

                      Center(child: Image.asset("images/wallet.png",fit: BoxFit.fill,height: 30,width: 30,)),

                    ],
                  ),
                ),
                SizedBox(height: 40,),
                Center(child: CustomText(text: "Type your venmo username here",size: 14,bold: FontWeight.w400,color: Colors.black.withOpacity(0.4),)),
                SizedBox(height: 20,),
                cTextField(width: MediaQuery.of(context).size.width,controller:contr.event_user_controller),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text: "You’ll typically receive payouts for shows within 24 hours after your event is over.",size: 10,bold: FontWeight.w400,color: Colors.black.withOpacity(0.4),),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text: "Note: Even if you aren’t charging for tickets, we confirm your Venmo to prevent fraud.",size: 12,bold: FontWeight.w600,color: Colors.black,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  customBottonIcon({final context}){
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Center(child: CustomText(text: "Need help?",size: 14,bold: FontWeight.w600,color: Colors.black,underLine: TextDecoration.underline,)),
          SizedBox(height: 20,),
         Obx(() =>  Get.find<PaymentController>().stripeBtnClicked.value? Container(height: 30,width: 30,child: CircularProgressIndicator(),):
         InkWell(
           onTap: () {
             //  Get.to(()=>StripePaymentScreen());
             if (
             contr
                 .event_user_controller.text ==
                 ""){
               Get.snackbar(
                 "Error",
                 "Your field is not selected",
                 snackPosition: SnackPosition.BOTTOM,
                 backgroundColor: Colors.red,
                 colorText: Colors.white,
               );
             }
             else{
               Get.to(()=>CreateEventScreen_1(event_create_user: contr.event_user_controller.text,));

             }

             // Get.find<PaymentController>().makePayment(amount: "150", currency: "USD");
           },
           child:
           Container(
             height: 45,
             width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.symmetric(horizontal: 20),
             alignment: Alignment.center,
             decoration: BoxDecoration
               (
               color: Colors.black,
               borderRadius: BorderRadius.circular(20),
             ),
             child: CustomText(text: "Confirm",size: 13,color: Colors.white,),
           ),
         ),)

        ],
      ),
    );
  }

  cTextField({final width,required final controller}) {
    return Container(
      height: 35,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20
          ),
          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
      ),
      width:width,
      child: TextFormField(
        controller: controller,
        validator:
            (value) {
          if (value!.isEmpty) {
            return "Field is Empty";
          }
        },
        decoration: InputDecoration(
            hintText: "@",
            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none
        ),
      ),
    );
  }

}
