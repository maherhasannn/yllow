import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/view/create_event_screen.dart';
import 'package:new_yellow/screens/concert_dashboard/view/concert_payment_screen.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';
import 'package:new_yellow/screens/main_ticket_pages/my_ticket/view/my_ticket_expanded_screen.dart';
import 'package:new_yellow/screens/main_ticket_pages/my_ticket/view/my_ticket_home.dart';

import '../../main_ticket_pages/my_ticket/view/my_free_ticket.dart';
import '../../main_ticket_pages/my_ticket/widget/my_ticket_widget.dart';

class ConcertDashboardScreen2 extends StatelessWidget {
  final db = FirebaseFirestore.instance.collection("Events").where("event_publish",isEqualTo: "Publish").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CustomBottomNavBar(),
      body: SafeArea(

        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
                        child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.7),)),
                    Spacer(),
                    Center(child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 60,width: 60,)),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(text: "Concert Dashboard",size: 24,bold: FontWeight.w700,color: Colors.black,),
              ),
              SizedBox(height: 10,),
              Container(
                height: 470,
                child:  Container(
                  height: 470,
                  child:
                  StreamBuilder<QuerySnapshot>(
                      stream:db,
                      builder: (context,snapshot)
                      {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
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
                                "No Events Found",
                                style: TextStyle(fontSize: 20, color: Colors.black),
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
                                return MyTicketWidget(
                                  onTap: (){
                                    if(snapshot.data!.docs[index]["how_much_ticket"].toString()=="Free"){
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
                                    else{
                                      Get.to(()=>MyTicketExpScreen(
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
                                  txt3: snapshot.data!.docs[index]["street_address"].toString(),
                                  img: snapshot.data!.docs[index]["banner_pic"].toString(),);

                              });
                        }
                      }
                  ),
                ),
              ),

              customBottonIcon(),
            ],
          ),
        ),
      ),
    );
  }
  customBottonIcon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: (){
              Get.to(()=>ConcertPaymentScreen());
            },
            child: Image.asset(height: 30,width:30,"images/wallet.png",fit: BoxFit.fill,)),
        InkWell(
          onTap: (){
            Get.to(()=>CreateEventScreen_1());
          },
          child: Container(
            height: 40,
            width: 220,
            alignment: Alignment.center,
            decoration: BoxDecoration
              (
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: CustomText(text: "New Event",size: 13,color: Colors.white,),
          ),
        ),
        Image.asset(height: 30,width:30,"images/imggg.png",fit: BoxFit.fill,),
      ],
    );
  }

}
