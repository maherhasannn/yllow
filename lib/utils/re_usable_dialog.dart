import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

//
// class CustomExitAlertDialog extends StatelessWidget {
//   const CustomExitAlertDialog({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoAlertDialog(
//       title: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Are you sure you\nwant to leave?",
//             style: cAlertDialogHeaderTextStyle,
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         CupertinoDialogAction(
//           child: Text(
//             "Yes",
//             style: cAlertDialogButtonTextStyle,
//           ),
//           onPressed: () {
//             Get.offAll(() => SignInView());
//           },
//         ),
//         CupertinoDialogAction(
//           child: Text(
//             "No",
//             style: cAlertDialogButtonTextStyle,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ],
//     );
//   }
// }

class CustomAlertDialog extends StatelessWidget {
  Function()? onPressFunction;
  String headerText, contentText, buttonText;

  CustomAlertDialog(
      {Key? key,
        required this.onPressFunction,
        required this.buttonText,
        required this.contentText,
        required this.headerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("clicked......");
    return AlertDialog(
      backgroundColor: Color(0xffDCF1F6),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Container(
          height: 131,
          width: 243,
          alignment: Alignment.center,
          decoration:  BoxDecoration(color: Color(0xffDCF1F6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                headerText,
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w900,fontSize: 16),
                // textAlign: TextAlign.center,
              ),
              Text(
                contentText,
                textAlign: TextAlign.start,
                 style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                // textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: onPressFunction,
                child: Container(
                  width: 243,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xffDCF1F6),
                    border: Border.all(color: Colors.black.withOpacity(0.3),width: 1)
                  ),
                  child:  Text(buttonText, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14)),
                ),
              ),
              // ElevatedButton(
              //     onPressed: onPressFunction,
              //     child: Text(buttonText, style: TextStyle()),
              //     style: ElevatedButton.styleFrom(
              //         fixedSize: Size(Get.size.width, 55),
              //         backgroundColor: Color(0xffDCF1F6),
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(10),
              //
              //         ),
              //         elevation: 3,
              //         shadowColor: Colors.grey))
            ],
          ),
        ));
  }
}
