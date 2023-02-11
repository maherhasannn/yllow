import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/admin_panel_request.dart';

class AdminController extends GetxController
{
  // Order Accept Button Update in Firebase
  eventPublish({ final id, required final text}) async {

    var collection = FirebaseFirestore.instance.collection("Events");
    return await collection
        .doc(id)
        .update({
      "event_publish":text
    }) // <-- Updated data
        .then((_) {
    if(text == "Deny"){
      Get.snackbar("Event Publish", "Event Deny...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.red,
          colorText: Colors.white
      );
      Get.offAll(()=>AdminRequestScreen());
    }
    else{
      Get.snackbar("Event Publish", "Event Publish Successfully...",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:Colors.green,
          colorText: Colors.white
      );
      Get.offAll(()=>AdminRequestScreen());
    }
      // Get.offAll(()=>Delivery_Requests_Screen());


    }).catchError((error) {

    });
  }


}