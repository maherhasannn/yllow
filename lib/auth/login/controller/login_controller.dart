import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';

import '../../../../utils/common.dart';
import '../../../screens/admin/view/admin_panel_request.dart';
import '../../../screens/home_1/view/home_1_screen.dart';
import '../view/login_screen.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final loginFormKeyyyy = GlobalKey<FormState>();
  var isLoading = false.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isPasswordHide = false;
  var obscureText ;
  bool admin = false;
  String isAdmin = "" ;


  final FirebaseAuth _auth = FirebaseAuth.instance;



  Future signInn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }
  @override
  void initState() {
    //  isPasswordHide = false;
    obscureText = false;

    super.onInit();
  }
  var isButtonClrChng = false.obs;

  signIn(String email,String password ) async
  {

   // String guestPassword= "123456";
    isLoading.value = true;

    //if (formKey.currentState!.validate()) {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
      isLoading.value  = false,
      Get.find<GetStorageController>()
          .writeStorage(COMMONS.U_ID, value.user!.uid.toString()),
      getUserData(),

    Get.find<GetStorageController>()
          .writeStorage("login", "true"),
    })
        .catchError((e) {
      isLoading.value = false;
      Get.snackbar(
          "Sign in Error", e.code.toString(),
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    });
  }


  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value)
    {
      Get.find<GetStorageController>()
          .writeStorage("login", "true");
      Get.find<GetStorageController>()
          .writeStorage("admin", "true");
     // Get.find<GetStorageController>().removeStorage();
      print("go to login screen");
      Get.offAll(LoginScreen());
    });

  }
  getUserData() async{
    print("lllhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    QuerySnapshot snapshot =await FirebaseFirestore.instance
        .collection("Users").where("email" ,isEqualTo: emailController.text).get();
    log("admin "+snapshot.docs[0]["user"]);
    if(snapshot.docs[0]["user"] == "admin")
    {
      Get.offAll(()=>AdminRequestScreen());
    }
    else{

      Get.offAll(()=>Home_1_Screen());

    }
  }

}
