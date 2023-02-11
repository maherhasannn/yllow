import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/auth/login/controller/login_controller.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/view/concert_dashboard_screen.dart';

import 'admin_panel_detail.dart';

class AdminRequestScreen extends StatelessWidget {
  final db = FirebaseFirestore.instance.collection("Events").where("event_publish",isEqualTo: "Unpublish").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Center(child: Image.asset("images/p_3.png",fit: BoxFit.fill,height: 70,width: 70,)),

                    InkWell(
                        onTap: (){
                          Get.find<LoginController>().signOut();
                        },
                        child: Icon(Icons.logout,color: Colors.orangeAccent,)),
                  ],
                ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Admin Panel",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:30,
                  ),
                ),
                Text(
                  "Requests",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:20,
                  ),
                ),
              ],
            ),
            Divider(color: Colors.black,thickness: 2,),
                SizedBox(height: 30,),
                // customTxtAndImage(txt:"Duck Pals Fall Show",img: "images/e2.png"),
                // SizedBox(height: 30,),
                // customTxtAndImage(txt:"Playboi Carti King Vamp Tour",img: "images/e2.png"),
                // SizedBox(height: 30,),
                // customTxtAndImage(txt:"Duck Pals Fall Show #2",img: "images/e2.png"),
                // SizedBox(height: 30,),
                // customTxtAndImage(txt:"Duck Pals Fall Show",img: "images/imgg_22.png"),
                // SizedBox(height: 30,),
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
                            padding:  EdgeInsets.only(top: 68.0),
                            child: Text(
                              "No Events Title Found",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        );
                      }
                      else {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if(snapshot.data!.docs[index]["event_title"].toString() == "Deny"){
                                return SizedBox.shrink();
                              }

                              else{
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child:  customTxt(txt: snapshot.data!.docs[index]["event_title"].toString(),onTap: (){
                                        Get.to(()=>AdminPDetailScreen(
                                          docId:snapshot.data!.docs[index].id ,
                                          index: snapshot.data!.docs[index],));

                                      }),
                                    ),
                                  ],
                                );
                              }

                            }
                        );
                      } }),



              ],
            ),
          ),
        ),
      ),
    );
  }
  customTxtAndImage({final txt, final img})
  {
    return InkWell(
      onTap: (){
     //   Get.to(()=>AdminPDetailScreen());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Text(
       txt,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize:18,
          fontWeight: FontWeight.w700,
          decoration: TextDecoration.underline,
          decorationThickness: 2
        ),
      ),
           Image.asset(img,fit: BoxFit.fill,height: 20,width: 20,)
        ],
      ),
    );

  }
  customTxt({final txt,onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize:18,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationThickness: 2
        ),
      ),
    );

  }

}
