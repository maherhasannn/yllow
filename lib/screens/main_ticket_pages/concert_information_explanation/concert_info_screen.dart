import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/main_ticket_pages/cobtroller/concert_information_controller.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../concert_dashboard/create_event/controller/event_controller.dart';

class ConcertInformationScreen extends StatelessWidget {
  ConcertInformationScreen({ this.img, this.title, this.date, this.city, this.caption, this.price, this.genre, this.docId, this.instagram, this.spotify, this.postalCode, this.state, this.street});
final img;
final title;
final date;
final caption;
final price;
final genre;
final instagram;
final spotify;
  final city;
final postalCode;
final state;
final street;
final docId;
  final controller = Get.put(ConcertInfoController());
  final eventController = Get.put(EventController());
  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  static String formate_Date(String datetime) {
    if (datetime.toString() == "" || datetime.toString() == "null") {
      return "";
    }

    DateTime time = DateTime.parse(datetime);
    String formattedDate=  DateFormat.MMMMEEEEd().add_jm().format(time );
    //String formattedDate = DateFormat.yMMMMd().format(time);
    return formattedDate.toString();
  }
  @override
  Widget build(BuildContext context) {

    log(eventController.shareLinkEditingController.toString());
    log(instagram.toString());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),
      ),
      body: Hero(
        tag: "hero_anim_5",
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 420,
                  margin: EdgeInsets.only(left: 20,right: 20,top: 60),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(img),fit: BoxFit.cover)
                  ),

                ),
                SizedBox(height: 20,),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:20,
                    //  decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(height: 5,),
                Divider(color: Colors.black.withOpacity(0.5),thickness: 1,),
                SizedBox(height: 20,),
                Text(
                  "Playboi Carti, Ken Carson",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:16,

                  ),
                ),
                SizedBox(height: 20,),
                Text(
                 // DateFormat.yMEd().add_jms().format(date ),
                    formate_Date(date),
                  style: TextStyle(
                    color: Color(0xffc0c0c0),
                    fontWeight: FontWeight.w700,
                    fontSize:16,

                  ),
                ),
                 SizedBox(height: 20,),
              // Obx(() {
              //   return   controller.isClicked.value?
              //   Center(
              //     child: InkWell(
              //       onTap: (){
              //         controller.isClicked.value = false;
              //       },
              //       child: Column(
              //         children: [
              //           Text(
              //             "Swipe down",
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w500,
              //               fontSize:12,
              //
              //             ),
              //           ),
              //           Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 25,)
              //         ],
              //       ),
              //     ),
              //   ):SizedBox.shrink();
              // }),
              //   SizedBox(height: 20,),
            // Obx(() {
            //   return   controller.isClicked.value?SizedBox.shrink() :
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //
            //         ConstrainedBox(
            //
            //           constraints: BoxConstraints(maxWidth: 160),
            //           child: Text(
            //          "${state} "+ "${city}"+"${street} "+ "${postalCode}",
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontWeight: FontWeight.w700,
            //               fontSize:16,
            //               decoration: TextDecoration.underline,
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 10,),
            //         Text("Genre: $genre",  style: TextStyle(
            //           color: Colors.black.withOpacity(0.5),
            //           fontWeight: FontWeight.w700,
            //           fontSize:16,
            //         ),
            //
            //         ),
            //     SizedBox(height: 10,),
            //     Text("Price: \$ $price",  style: TextStyle(
            //     color: Colors.orangeAccent,
            //     fontWeight: FontWeight.w700,
            //     fontSize:16,
            //     ),),
            //
            //         SizedBox(height: 10,),
            //         Text("Caption:",  style: TextStyle(
            //           color: Colors.black,
            //           fontWeight: FontWeight.w700,
            //           fontSize:16,
            //         ),),
            //
            //   SizedBox(height: 10,),
            //   ConstrainedBox(
            //     constraints: BoxConstraints(maxWidth: 250),
            //     child: Text(caption,  style: TextStyle(
            //     color: Colors.black.withOpacity(0.5),
            //     fontWeight: FontWeight.w700,
            //     fontSize:16,
            //     ),),
            //   ),
            //         SizedBox(height: 70,),
            //      GetBuilder<EventController>(
            //        init:EventController(),
            //          builder: (context){
            //        return    customTextField();
            //      }),
            //         SizedBox(height: 30,),
            //         Center(child: CustomText(text: "Want to attend this free show?",size: 18,bold: FontWeight.w700,color: Colors.black,)),
            //         SizedBox(height: 30,),
            //        Obx(() =>  eventController.join_free_event.value ?
            //   Padding(
            //          padding:  EdgeInsets.symmetric(horizontal: 25),
            //          child: CustomText(text: "We’ll send you a notification to remind you of your event.",size: 12,bold: FontWeight.w400,color: Colors.black,),
            //        ):
            //        Column(
            //          children: [
            //            Row(
            //              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //              children: [
            //                InkWell(
            //                  onTap:(){
            //                    eventController.eventFreeJoin(id: docId,text: "will_be_there", context: context);
            //                  },
            //                  child:  cusColumn(
            //                    image: "images/e2.png",
            //                    title: "I’ll be there!",
            //                  ),
            //                ),
            //                SizedBox(width: 30,),
            //                InkWell(
            //                  onTap:(){
            //                    eventController.eventFreeJoin(id: docId,text: "may_be_there", context: context);
            //                  },
            //                  child:
            //                  cusColumn(
            //                    image: "images/e1.png",
            //                    title: "Maybe..",
            //                  ),
            //                )
            //              ],
            //            ),
            //            SizedBox(height: 20,),
            //          ],
            //        ),
            //
            //        ),
            //
            //
            //             SizedBox(height: 20,),
            //       ],
            //     ),
            //   );
            // })
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  ConstrainedBox(

                    constraints: BoxConstraints(maxWidth: 160),
                    child: Text(
                      "${street} "+"${city}"+"${state} "+"${postalCode}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize:16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text("Genre: $genre",  style: TextStyle(
                    color: Color(0xffc0c0c0),
                    fontWeight: FontWeight.w700,
                    fontSize:16,
                  ),

                  ),
                  SizedBox(height: 10,),
                  Text("Price: \$ $price",  style: TextStyle(
                    color: Color(0xfff7d117),
                    fontWeight: FontWeight.w700,
                    fontSize:16,
                  ),),

                  SizedBox(height: 10,),
                  Text("Caption:",  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:16,
                  ),),

                  SizedBox(height: 10,),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 250),
                    child: Text(caption,  style: TextStyle(
                      color: Color(0xffc0c0c0),
                      fontWeight: FontWeight.w700,
                      fontSize:16,
                    ),),
                  ),
                  SizedBox(height: 70,),
                  GetBuilder<EventController>(
                      init:EventController(),
                      builder: (context){
                        return    customTextField();
                      }),
                  SizedBox(height: 30,),
                  Center(child: CustomText(text: "Want to attend this free show?",size: 20,bold: FontWeight.w700,color: Colors.black,)),
                  SizedBox(height: 30,),
                  Obx(() =>  eventController.join_free_event.value ?
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 25),
                    child: CustomText(text: "We’ll send you a notification to remind you of your event.",size: 12,bold: FontWeight.w400,color: Colors.black,),
                  ):
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap:(){
                              eventController.eventFreeJoin(id: docId,text: "will_be_there", context: context);
                            },
                            child:  cusColumn(
                              image: "images/e2.png",
                              title: "I’ll be there!",
                            ),
                          ),
                          SizedBox(width: 30,),
                          InkWell(
                            onTap:(){
                              eventController.eventFreeJoin(id: docId,text: "may_be_there", context: context);
                            },
                            child:
                            cusColumn(
                              image: "images/e1.png",
                              title: "Maybe..",
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),

                  ),


                  SizedBox(height: 20,),
                ],
              ),
            )

              ],
            ),
          ),
        ),
      ),
    );
  }


  customTextField(){
    return
      Column(
        children: [
          TextFormField
            (
            style: TextStyle(fontSize: 14,color: Colors.black,),
            controller: eventController.shareLinkEditingController,
            decoration: InputDecoration
              (
              prefixIcon:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap:(){
                            //  eventController.shareLinkEditingController.text = instagram;
                            const url = "https://www.instagram.com";
                            launchURL(url);
                          },child: Image.asset(height: 20,width:20,"images/insta.png",fit: BoxFit.fill,)),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap:(){
                            const url = "https://www.google.com/";
                            launchURL(url);
                            eventController.shareLinkEditingController.text = spotify;
                          },
                          child: Image.asset(height: 20,width:20,"images/Spotify logo.png",fit: BoxFit.fill,)),
                    ],
                  ),
                  InkWell(
                    onTap:()async{
                      // _onShare method:
                      //  final box = findRenderObject() as RenderBox?;

                      await Share.share(
                        title,
                        subject:caption,
                        //sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                      );
                    },
                    child: Row(
                      children: [
                        CustomText(text: "Share link",size: 12,color: Colors.black,),
                        SizedBox(width: 10,),
                        Image.asset(height: 20,width:20,"images/link.png",fit: BoxFit.fill,),
                      ],
                    ),
                  )
                ],
              ),
            border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10)
            ),

          ),

          Divider(color: Colors.black,thickness: 2,),
        ],
      );
  }

  cusColumn({final image,final title}){
    return Column(
      children:
      [
        Image.asset(image,fit: BoxFit.fill,height: 30,width: 30,),
        SizedBox(height: 15,),
        CustomText(text: title,size: 14,color: Colors.black,bold: FontWeight.w700,)
      ],
    );
  }
}
