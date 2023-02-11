import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_buttom_nav_bar.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/controller/event_controller.dart';
import 'package:new_yellow/screens/home_1/widget/home_list_item.dart';

import 'create_event_3.dart';
import 'create_event_screen_4.dart';

class CreateEventScreen_2 extends StatefulWidget {
  CreateEventScreen_2({
   required this.who_play,
    required  this.genre,
    required this.street_address,
    required this.state_address,
    required this.city_address,
    required this.zip_code,
    required this.event_create_user,
    required this.event_title});
  final event_title;
  final who_play;
  final genre;
  final street_address;
  final city_address;
  final state_address;
  final zip_code;
  final event_create_user;

  @override
  State<CreateEventScreen_2> createState() => _CreateEventScreen_2State();
}

class _CreateEventScreen_2State extends State<CreateEventScreen_2> {
  var contr = Get.find<EventController>();
  List<String> _locations = ['Free','\$5 at the door', '\$10 at the door', '\$15 at the door','\$5','\$10','\$15','\$5 (Third-Party ticket broker)','\$10 (Third-Party ticket broker)','\$15 (Third-Party ticket broker)'];
  List<String> _available_tickets = ['10','25', '50', '75','100','150','200','Unlimited'];
  String? _selectedLocation; // Option 2
  String? selectAvailable; // Option 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 110,

        child: Column(
          children: [

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(text: "Note: Events that handle transactions through the app cannot be cancelled. If you are not using a Third-Party broker to sell tickets, please leave “Link to buy tickets” empty.",size: 10,bold: FontWeight.w600,color: Colors.black,),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                if (
                contr
                    .how_much_ticket.text ==
                    "" ||
                    contr
                        .when_door_open.text ==
                        ""|| contr
                    .when_is_it.text ==
                    "" ||
                    contr
                        .link_to_buy_ticket.text ==
                        ""|| contr
                    .available_ticket.text ==
                    ""
                ) {
                  print("if error");
                  Get.snackbar(
                    "Error",
                    "One of your field is not selected",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
                else{
                  Get.to(()=>CreateEventScreen_3
                    (
                    link_to_buy_ticket: contr.link_to_buy_ticket.text,
                      who_play: widget.who_play,
                      event_title: widget.event_title,
                      state_address: widget.state_address,
                      street_address: widget.street_address,
                      zip_code: widget.zip_code,
                      city_address: widget.city_address,
                      genre: widget.genre,
                      when_is_it: contr.when_is_it.text ,
                      when_door_open:  contr.when_door_open.text,
                      how_much_ticket: contr.how_much_ticket.text,
                      available_ticket: contr.available_ticket.text, event_create_user: widget.event_create_user,

                  ));

                }

              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration
                  (
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomText(text: "Next",size: 13,color: Colors.white,),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Form(
            key: contr.formKey2,
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
                          child: Icon(Icons.arrow_back_ios,color: Colors.black.withOpacity(0.5),size: 20,)),

                      Spacer(),
                      CustomText(text: "New Event",size: 24,bold: FontWeight.w700,),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dotContainer(color: Colors.black),
                    SizedBox(width: 10,),
                    dotContainer(color: Colors.black),
                    SizedBox(width: 10,),
                    dotContainer(color: Colors.white),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                  onTap: ()
                  {
                    contr.selectDate(context);
                  },
                    hint_text: "MM/DD/YYYY",
                    txt: "When is your event?",context: context,
                    controller: contr.when_is_it,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                dateTextField(
                  onTap: (){
                    contr.selectStartTime(context);
                  },
                    hint_text: "Start time",
                    txt: "When do doors open?",context: context,
                    controller: contr.when_door_open,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text:"How much are tickets?" ,size: 16,bold: FontWeight.w600,color: Colors.black,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.015,),

                Container(
                  alignment: Alignment.center,
                  height:  MediaQuery.of(context).size.height*0.07,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF5F5F5)
                  ),
                  padding: const EdgeInsets.only(left: 15,right: 20),
                  child: DropdownButton(
                    dropdownColor:Color(0xffF5F5F5),
                    isExpanded: true,
                    underline: Text(""),
                    hint: Text('Select...'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue as String?;
                        contr.how_much_ticket.text=_selectedLocation!;
                        log("how much: "+ contr.how_much_ticket.text.toString());
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

                customTextField(
                    hint_text: "Required if using a Third-Party broker",
                    txt: "Link to buy tickets*",context: context,
                    controller: contr.link_to_buy_ticket,
                    validation:
                        (value) {
                      if (value!.isEmpty) {
                        return "Field is Empty";
                      }}
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(text:"How many tickets are available?" ,size: 16,bold: FontWeight.w600,color: Colors.black,),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.015,),

                Container(
                  alignment: Alignment.center,
                  height:  MediaQuery.of(context).size.height*0.07,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF5F5F5),
                  ),
                  padding: const EdgeInsets.only(left: 15,right: 20),
                  child: DropdownButton(
                    dropdownColor: Color(0xffF5F5F5),
                    isExpanded: true,
                    underline: Text(""),
                    hint: Text('Space Capacity...'), // Not necessary for Option 1
                    value: selectAvailable,
                    onChanged: (newValue) {
                      setState(() {
                        selectAvailable = newValue as String?;
                        contr.available_ticket.text=selectAvailable!;
                        log("how much: "+ contr.available_ticket.text.toString());
                      });
                    },
                    items: _available_tickets.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.025,),

              ],
            ),
          ),
        ),
      ),
    );
  }

  customTextField({final txt,var context,final hint_text,var controller,var validation}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
          ),
          SizedBox(height: 5,),
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 6,left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10)
            ),
            width:MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: controller,
              validator: validation,
              decoration: InputDecoration(
                  hintText: hint_text,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      );
  }

  dotContainer({final color}){
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black,width: 1)
      ),
    );
  }
  dateTextField({final txt,var context,final hint_text,var controller,var validation,var onTap}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(text:txt ,size: 16,bold: FontWeight.w600,color: Colors.black,),
          ),
          SizedBox(height: 5,),
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 6,left: 10),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10)
            ),
            width:MediaQuery.of(context).size.width,
            child: TextFormField(
              controller: controller,
              validator: validation,
              onTap: onTap,
              decoration: InputDecoration(
                  hintText: hint_text,
                  contentPadding: EdgeInsets.all(10),
                  border: InputBorder.none
              ),
            ),
          ),
        ],
      );
  }
}
