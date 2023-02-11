
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:new_yellow/auth/sign_up/model/model.dart';
import 'package:new_yellow/auth/welcome_screen/welcome_screen.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/utils/common.dart';

import '../../../screens/home_1/view/home_1_screen.dart';


class SignUpController extends GetxController
{

  final formKey = GlobalKey<FormState>();
  final formKeyy = GlobalKey<FormState>();

  GlobalKey<FormState> nameKey = GlobalKey();
  var isButtonClrChng = false.obs;
  final nController = TextEditingController();
  String? validateEventName(String value) {
    if (value == null || value == '') {
      return "*This field is compulsory";
    }
    return null;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var isLoading = false.obs;
  var isLoadingGoogle = false.obs;
  bool admin = false;
  String isAdmin = "" ;


  void signUpp(
      {var email, var namEd, date, var password}) async {
    isLoading.value = true;

    try {
     // String guestPassword= "123456";

      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
        postDetailsToFirestore(namEd,date),
        isLoading.value = false,
      })
          .catchError((e) {
        isLoading.value = false;
        Get.snackbar(
            "Sign Up Error", e.code.toString(),
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
      });
    } on Exception {
      // TODO
    }
  }



  postDetailsToFirestore(String nameEditingController,var date) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;

    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.date = date;
    userModel.user = "user";
    userModel.name = nameEditingController;
    Get.find<GetStorageController>()
        .writeStorage(
        COMMONS.U_ID,
        user.uid.toString());
    Get.find<GetStorageController>()
        .writeStorage(
        COMMONS.NAME,
        userModel.name.toString());
    await firebaseFirestore
        .collection("Users")
        .doc(user.uid)
        .set(userModel.toMap()).then((value)
    {
      Get.to(() => Home_1_Screen());
    });

  }


}