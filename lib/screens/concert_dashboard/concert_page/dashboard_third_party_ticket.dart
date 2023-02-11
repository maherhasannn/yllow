import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/main_ticket_pages/cobtroller/concert_information_controller.dart';

class DashboardThirdPartyScreen extends StatelessWidget {
  DashboardThirdPartyScreen({ this.img, this.title, this.date, this.location, this.caption, this.price, this.genre, this.docId, this.who_play});
  final img;
  final title;
  final who_play;
  final date;
  final location;
  final caption;
  final price;
  final genre;
  final docId;
  final controller = Get.put(ConcertInfoController());

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "THIRD PARTY TICKET BROKER",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:20,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 430,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(img),fit: BoxFit.fill)
                ),

              ),
              SizedBox(height: 20,),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize:20,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                who_play,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize:16,

                ),
              ),
              SizedBox(height: 20,),
              Text(
                formate_Date(date),
                style: TextStyle(
                  color: Color(0xffc0c0c0),
                  fontWeight: FontWeight.w700,
                  fontSize:16,

                ),
              ),
              SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ConstrainedBox(

                constraints: BoxConstraints(maxWidth: 160),
                child: Text(
                  location,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Text("Genre: ${genre}",  style: TextStyle(
                color: Color(0xffc0c0c0),
                fontWeight: FontWeight.w700,
                fontSize:16,
              ),

              ),
              SizedBox(height: 10,),
              Text("Price: \$ ${price}",  style: TextStyle(
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
              customTextField(),
              SizedBox(height: 30,),
              Center(child: CustomText(text: "Cancel Event",size: 12,bold: FontWeight.w700,color: Colors.black,underLine: TextDecoration.underline,)),
              SizedBox(height: 30,),

            ],
          ),
        ),
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
              // SizedBox(height: 20,),
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
              //             location,
              //             style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w700,
              //               fontSize:16,
              //               decoration: TextDecoration.underline,
              //             ),
              //           ),
              //         ),
              //         SizedBox(height: 10,),
              //         Text("Genre: ${genre}",  style: TextStyle(
              //           color: Colors.black.withOpacity(0.5),
              //           fontWeight: FontWeight.w700,
              //           fontSize:16,
              //         ),
              //
              //         ),
              //         SizedBox(height: 10,),
              //         Text("Price: \$ ${price}",  style: TextStyle(
              //           color: Colors.orangeAccent,
              //           fontWeight: FontWeight.w700,
              //           fontSize:16,
              //         ),),
              //
              //         SizedBox(height: 10,),
              //         Text("Caption:",  style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.w700,
              //           fontSize:16,
              //         ),),
              //
              //         SizedBox(height: 10,),
              //         ConstrainedBox(
              //           constraints: BoxConstraints(maxWidth: 250),
              //           child: Text(caption,  style: TextStyle(
              //             color: Colors.black.withOpacity(0.5),
              //             fontWeight: FontWeight.w700,
              //             fontSize:16,
              //           ),),
              //         ),
              //         SizedBox(height: 70,),
              //         customTextField(),
              //         SizedBox(height: 30,),
              //         Center(child: CustomText(text: "Cancel Event",size: 12,bold: FontWeight.w700,color: Colors.black,underLine: TextDecoration.underline,)),
              //         SizedBox(height: 30,),
              //
              //       ],
              //     ),
              //   );
              // })

            ],
          ),
        ),
      ),
    );
  }


  customTextField(){
    return
      TextFormField
        (
        decoration: InputDecoration
          (
          prefixIcon:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(height: 20,width:20,"images/insta.png",fit: BoxFit.fill,),
                  SizedBox(width: 10,),
                  Image.asset(height: 20,width:20,"images/Spotify logo.png",fit: BoxFit.fill,),
                ],
              ),
              Row(
                children: [
                  CustomText(text: "Share link",size: 12,color: Colors.black,),
                  SizedBox(width: 10,),
                  Image.asset(height: 20,width:20,"images/link.png",fit: BoxFit.fill,),
                ],
              )
            ],
          ),

        ),
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
