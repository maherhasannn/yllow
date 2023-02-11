import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_yellow/auth/login/view/login_screen.dart';
import 'package:new_yellow/auth/sign_up/view/name_screen.dart';


class GetStorageController extends GetxController implements GetxService {
  final box = GetStorage();
   var mapEnabled = "true".obs;

  @override
  void onInit() {
    imageurl.value = readStorage("image").toString();
    uID.value = readStorage("uid").toString();
    super.onInit();
  }
  var imageurl = "".obs;
  var uID = "".obs;
  bool isHavingData = false;

  ToggleIsHavingData(bool value) {
    isHavingData = value;
    update();
  }

  Future<void> initstorage() async {
    await GetStorage().initStorage;
    // box.writeIfNull("country_code", "us");
    // print("country code is ${box.read("country_code")}");
  }

  String? writeStorage(String key, String value) {
    box.write(key, value);
    return null;
  }


  String? readStorage(String key) {
    return box.read(key);
  }

  Future<void> removeStorage() async {
    await box.erase().then((value) async {
      log("<--------------Get Storage Remove Before-------------->");
      log(box.getKeys().toString());
      log(box.getValues().toString());
      FirebaseAuth.instance.signOut();
      await box.erase().then((value) async {
        ToggleIsHavingData(false);
        print("remove storage");
        update();
        //   Get.offAll(() => LoginScreen());
    });
  });}
  // Future<void> removeStorage() async {
  //   log("<--------------Get Storage Remove Before-------------->");
  //   log(box.getKeys().toString());
  //   log(box.getValues().toString());
  //  FirebaseAuth.instance.signOut();
  //   await box.erase().then((value) async {
  //     ToggleIsHavingData(false);
  //     print("remove storage");
  //     update();
  //   //   Get.offAll(() => LoginScreen());
  //   });
  //   log("<--------------Get Storage Remove After-------------->");
  //   log(box.getKeys().toString());
  //   log(box.getValues().toString());
  // }

}
