import 'package:flutter/material.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

class ConcertTipsScreen extends StatelessWidget {
  const ConcertTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
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
                SizedBox(height: 30,),
                CustomLTile(),
                SizedBox(height: 20,),
                customText(txt: "If playing on a college campus make sure to include that in the title"),
                SizedBox(height: 20,),

                customText(txt: "If the event is hosted on (or near) a university put the campus name as the city"),
                SizedBox(height: 20,),

                customText(txt: "If playing on a college campus make sure to include that in the title"),
                SizedBox(height: 20,),

                customText(txt: "Free concerts with “Donations Appreciated” have historically performed the best"),

                SizedBox(height: 20,),

                customText(txt: "If you’re able to, try to organize security. It’ll help keep everything moving"),
                SizedBox(height: 20,),
                customText(txt: "If multiple artists/bands are playing, please seperate them with commas"),
                SizedBox(height: 20,),
                customText(txt: "Need help? Feel free to reach us @projectyllow on Instagram regarding any questions, concerns, or compliments"),
                SizedBox(height: 20,),
                customText(txt: "You can expect about 80% of people who RSVP to a free show to attend"),
                SizedBox(height: 20,),
                customText(txt: "You can expect about 80% of people who RSVP to a free show to attend"),
                SizedBox(height: 20,),

                Center(child: Image.asset("images/e1.png",fit: BoxFit.fill,height: 26,width: 26,)),
                SizedBox(height: 20,),

                Center(child: Image.asset("images/insta.png",fit: BoxFit.fill,height: 20,width: 20,)),
                SizedBox(height: 20,),


              ],
            ),
          ),
        ),
      ),
    );
  }
  CustomLTile(){
    return ListTile(
      horizontalTitleGap: 0,
      title:     Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: "Concert Tips",size: 32,bold: FontWeight.w700,color: Colors.black,),
          Divider(color: Colors.black,thickness: 2,),
        ],
      ),
    );


  }
  customText({final txt}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Container(
        height: 10,
        width: 10,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Color(0xffC0C0C0),
          shape: BoxShape.circle
        ),
      ),
    SizedBox(width: 10,),
    ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: Text(
      txt,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Color(0xffC0C0C0),
        fontSize:16,
      fontWeight: FontWeight.w700,

      ),
      ),
    )

      ],
    );
  }
}
