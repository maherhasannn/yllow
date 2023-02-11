import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_yellow/auth/login/controller/login_controller.dart';
import 'package:new_yellow/controller/get_storage_controller.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/utils/re_usable_dialog.dart';

import '../../../utils/common.dart';

class CustomHomeHeader extends StatelessWidget {
  const CustomHomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
            tag: "hero_anim",
            child: Image.asset(height: 50,width:50,"images/p_3.png",fit: BoxFit.fill,)),
        Get.find<GetStorageController>().box.read(COMMONS.locationEnable) == "true"?  InkWell(
            onTap:(){
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return  CustomAlertDialog(onPressFunction: ()
                    {
                    Get.back();
                    }, buttonText: "Close",
                        contentText: "We use your location to show you concerts nearby! ",
                        headerText: "");

                  });

            },
            child: Image.asset(height: 25,width:25,"images/p_dots.png",fit: BoxFit.fill,)):
        Image.asset(height: 25,width:25,"images/map_gray_icon.png",fit: BoxFit.fill),

      ],
    );
  }
}
