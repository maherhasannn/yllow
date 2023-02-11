import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/model/event_model.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/view/application_submitted.dart';
import 'package:new_yellow/screens/main_ticket_pages/my_ticket/view/my_ticket_home.dart';
import 'package:new_yellow/utils/common.dart';
import 'package:new_yellow/utils/location.dart';
import 'package:path/path.dart' as Path;

import '../../../../stripe_payment_screen/controller.dart';
import '../../../../utils/re_usable_dialog.dart';


class EventController extends GetxController
{
  var controlller = TextEditingController();
  var who_play=TextEditingController();
  var event_user_controller=TextEditingController();
  var event_title=TextEditingController();
 var genre=TextEditingController();
  var when_is_it=TextEditingController();
 var when_door_open=TextEditingController();
  var streetAddress=TextEditingController();
  var cityAddress=TextEditingController();
  var stateAddress=TextEditingController();
  var zipCodeAddress=TextEditingController();
  var phone=TextEditingController();
  var conform_phone=TextEditingController();
  var how_much_ticket=TextEditingController();
  var buy_ticket=TextEditingController();
  var available_ticket=TextEditingController();
  var event_caption=TextEditingController();
  var link_to_buy_ticket=TextEditingController();
  var instagram_link=TextEditingController();
  var spotfy_link=TextEditingController();
  var banner_pic=TextEditingController();
  var concert_pic=TextEditingController();
  var shareLinkEditingController=TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final formKey3 = GlobalKey<FormState>();
  final formKey4 = GlobalKey<FormState>();

  TimeOfDay pickedTime = TimeOfDay(hour: 00, minute: 00);

  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var join_free_event = false.obs;




  var selectedImagePath = "".obs;
  var selectedImageSize = "".obs;
  ImagePicker imagePicker = ImagePicker();
  //2
  var selectedImagePath2 = "".obs;
  var selectedImageSize2 = "".obs;
  ImagePicker imagePicker2 = ImagePicker();

  File? file;
  File? file2;
  var downloadURL;
  var downloadURL2;
  DateTime selectedDate = DateTime.now();


  Future<void> selectDate(BuildContext context) async {
   final DateTime? picked = await showDatePicker(
    context: context,
    builder: (BuildContext context, Widget? child) {
     return Theme(
      data: ThemeData(
       primarySwatch: Colors.grey,
       splashColor: Colors.black,
       textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
       ),
       accentColor: Colors.black,
       colorScheme: ColorScheme.light(
           primary: Colors.green,
           primaryVariant: Colors.black,
           secondaryVariant: Colors.black,
           onSecondary: Colors.black,
           onPrimary: Colors.white,
           surface: Colors.black,
           onSurface: Colors.black,
           secondary: Colors.black),
       dialogBackgroundColor: Colors.white,
      ),
      child: child ?? Text(""),
     );
    },
    initialDate: selectedDate,
    firstDate:DateTime.now(),
    lastDate: DateTime(2050),
   );
   if (picked != null && picked != selectedDate)
   {
    DateTime date_format= DateTime.parse(picked.toString());
   // var dtnew = DateFormat('MM/dd/yyyy').format(picked);
         when_is_it.text = date_format.toString();
    }
   }

  Future<Null> selectStartTime(BuildContext context) async {
   final TimeOfDay? response = await showTimePicker(
    builder: (BuildContext context, Widget ?child) {
     return Theme(
      data: ThemeData(
       primarySwatch: Colors.grey,
       splashColor: Colors.white,
       textTheme: TextTheme(
        subtitle1: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
       ),
       accentColor: Colors.black,
       colorScheme: ColorScheme.light(
           primary: Colors.black,
           primaryVariant: Colors.black,
           secondaryVariant: Colors.black,
           onSecondary: Colors.black,
           onPrimary: Colors.white,
           surface: Colors.white,
           onSurface: Colors.black,
           secondary: Colors.white),
       dialogBackgroundColor: Colors.white,
      ),
      child: child ??Text(""),
     );
    },
    context: context,
    initialTime: pickedTime,
   );
   if (response != null && response != pickedTime) {
    var df = DateFormat("h:mm a");
    var dt = df.parse(response.format(context));
    var finaltime =  DateFormat('HH:mm').format(dt);
    when_door_open.text = finaltime.toString();
   }
  }


  Future getImage(ImageSource imageSource) async {
   // ignore: deprecated_member_use
   final pickedFile =
   await imagePicker.getImage(source: imageSource, imageQuality: 85);
   if (pickedFile != null) {
    print("get image if");
    selectedImagePath.value = pickedFile.path;
    file = File(pickedFile.path);
    selectedImageSize.value =
        ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
            .toStringAsFixed(2) +
            "Mb";
   } else {
    print("get image else");
    Get.snackbar(
     "Error",
     "No image selected",
     snackPosition: SnackPosition.BOTTOM,
     backgroundColor: Colors.red,
     colorText: Colors.white,
    );
   }
   update();
   // await uploadImageToFirebase();
   print("get image upload function");
   update();
   //  await updateImage(downloadURL.toString());
  }
//2
 Future getImage2(ImageSource imageSource2) async {
  // ignore: deprecated_member_use
  final pickedFile2 =
  await imagePicker2.getImage(source: imageSource2, imageQuality: 85);
  if (pickedFile2 != null) {
   print("get image if");
   selectedImagePath2.value = pickedFile2.path;
   file2 = File(pickedFile2.path);
   selectedImageSize2.value =
       ((File(selectedImagePath2.value)).lengthSync() / 1024 / 1024)
           .toStringAsFixed(2) +
           "Mb";
  } else {
   print("get image else");
   Get.snackbar(
    "Error",
    "No image selected",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
   );
  }
  update();
  // await uploadImageToFirebase();
  print("get image upload function");
  update();
  //  await updateImage(downloadURL.toString());
 }

 uploadImageToFirebase({
 required var who_play,
  required var genre,
  required var when_is_it,
  required var when_door_open,
  required var phone,
  required var how_much_ticket,
  required var available_ticket,
  required var event_caption,
  required var instagram_link,
  required var link_to_buy_ticket,
  required var spotfy_link,
  required var city_address,
  required var state_address,
  required var street_address,
  required var zip_code,
  required var event_title,
  required var event_create_user,
 }) async {
  String filename = Path.basename(file!.path);
  String filename2 = Path.basename(file2!.path);

  Reference storageReference = FirebaseStorage.instance.ref().child("posts" + filename);
  Reference storageReference2= FirebaseStorage.instance.ref().child("posts" + filename2);

  isLoading.value = true;
  final UploadTask uploadTask = storageReference.putFile(file!);
  final TaskSnapshot downloadUrl = (await uploadTask);
  //2
  final UploadTask uploadTask2 = storageReference2.putFile(file2!);
  final TaskSnapshot downloadUrl2 = (await uploadTask2);

  ///
  print("get image upload task");
  downloadURL = await downloadUrl.ref.getDownloadURL().whenComplete(() {
   print("get image get url");
   isLoading.value = false;

  }
  );


  downloadURL2 = await downloadUrl2.ref.getDownloadURL().whenComplete(() {
   print("get image get url");
   isLoading.value = false;

  }
  );


  await addEventDetailFirestore(
   link_to_buyt_ticket: link_to_buy_ticket,
    city_address: city_address,
       state_address: state_address,
       event_title: event_title,
      who_play: who_play,
      genre: genre,
      when_is_it:
      when_is_it,
      when_door_open:
      when_door_open,
      street_address: street_address,
      phone: phone,
       how_much_ticket: how_much_ticket,
      available_ticket: available_ticket,
      event_caption: event_caption,
   instagram_link: instagram_link,
        spotfy_link: spotfy_link,
      banner_pic: downloadURL, concert_pic: downloadURL2,
      zip_code: zip_code,
      event_create_user: event_create_user
  );
  print(downloadURL.toString() + "down");
 }

 addEventDetailFirestore({
  required var  who_play,
  required var genre,
  required var when_is_it,
  required var when_door_open,
  required var phone,
  required var how_much_ticket,
  required var available_ticket,
  required var event_caption,
  required var instagram_link,
  required var link_to_buyt_ticket,
  required var spotfy_link,
  required var banner_pic,
  required var concert_pic,
  required var city_address,
  required var state_address,
  required var street_address,
  required var zip_code,
  required var event_title,
  required var event_create_user,
 }) async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  isLoading2.value = true;
  User? user = _auth.currentUser;

  EventModel eventModel = EventModel();
  eventModel.event_title = event_title;
  eventModel.street_address = street_address;
  eventModel.zip_code = zip_code;
  eventModel.city_address = city_address;
  eventModel.who_play = who_play;
  eventModel.genre = genre;
  eventModel.when_is_it = when_is_it;
  eventModel.when_door_open = when_door_open;
  eventModel.state_address = state_address;
  eventModel.phone = phone;
  eventModel.how_much_ticket = how_much_ticket;
  eventModel.available_ticket = available_ticket;
  eventModel.event_caption = event_caption;
  eventModel.instagram_link = instagram_link;
  eventModel.link_to_buy_ticket = link_to_buyt_ticket;
  eventModel.spotfy_link = spotfy_link;
  eventModel.banner_pic = banner_pic;
  eventModel.concert_pic = concert_pic;
  eventModel.event_create_user = event_create_user;
  eventModel.will_be_there = "";
  eventModel.participants = {};
  eventModel.ticket_sold = "";
  eventModel.uid = user!.uid;
  eventModel.longitude = Get.find<GetStorageController>().box.read(E_LONGITUDE).toString();
  eventModel.latitude = Get.find<GetStorageController>().box.read(E_LATITUDE).toString();
  eventModel.event_publish = "Unpublish";
  Get.find<GetStorageController>()
      .writeStorage(COMMONS.EVENT_DOC_ID, user.uid.toString());
  await firebaseFirestore
      .collection("Events")
      .doc()
      .set(eventModel.toMap())
      .then((value) {
   isLoading2.value = false;
   Get.offAll(()=>ApplicationSubmitted());
  });
 }

 // Event Sold Update in Firebase
 eventSold({ final id}) async {
  log("Event Sold clickedddd");
  var collection = FirebaseFirestore.instance.collection("Events");
  return await collection
      .doc(id)
      .update({
   "ticket_sold":"ticket_sold",
   "participants":{
       "uid":FirebaseAuth.instance.currentUser!.uid,
    // Get.find<GetSTorageController>().getloginModel()!.data!.userInfo!.userId!.toString():true,
    // Get.find<GetSTorageController>().box.read(USER_ID):true,

   },
  }) // <-- Updated data
      .then((_) {
 //  Get.find<PaymentController>().makePayment(amount: "150", currency: "USD");

   Get.snackbar("Event Join", "Event Join Successfully...",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor:Colors.green,
       colorText: Colors.white
   );

   // Get.offAll(()=>MyTicketHome());


  }).catchError((error) {

  });
 }

 // Event Sold Update in Firebase
 eventFreeJoin({ final id, required final text,required final context}) async {

  var collection = FirebaseFirestore.instance.collection("Events");
  return await collection
      .doc(id)
      .update({
   "will_be_there":text,
   "participants":{
    "uid":FirebaseAuth.instance.currentUser!.uid,
    // Get.find<GetSTorageController>().getloginModel()!.data!.userInfo!.userId!.toString():true,
    // Get.find<GetSTorageController>().box.read(USER_ID):true,

   },
  }) // <-- Updated data
      .then((_) {
   Get.snackbar("Event Update", "Event Updated Successfully...",
       snackPosition: SnackPosition.BOTTOM,
       backgroundColor:Colors.green,
       colorText: Colors.white
   );
   if(text == "may_be_there"){
    join_free_event.value = true;
    showDialog(
        context: context,
        builder: (BuildContext context) {
         return  CustomAlertDialog(onPressFunction: ()
         {
          Navigator.pop(context);
         }, buttonText: "OK",
             contentText: "No pressure. We’ll send you a notification to remind you of your event if you feel like going.",
             headerText: "Notification");

        });
   }
   else{
    join_free_event.value = true;

    showDialog(
        context: context,
        builder: (BuildContext context) {
         return  CustomAlertDialog(onPressFunction: ()
         {
          Navigator.pop(context);
         }, buttonText: "OK",
             contentText: "Sweet! We’ll send you a notification before the show to remind you of your event. ",
             headerText: "Notification");

        });
   }
  // Get.offAll(()=>MyTicketHome());

  }).catchError((error) {

  });
 }


}