//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class StripePaymentScreen extends StatefulWidget {
//   const StripePaymentScreen({Key? key}) : super(key: key);
//
//   @override
//   State<StripePaymentScreen> createState() => _StripePaymentScreenState();
// }
//
// class _StripePaymentScreenState extends State<StripePaymentScreen> {
//
//   Map<String, dynamic>? paymentIntentData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: Text("Stripe Payment Gateway",style: TextStyle(fontSize: 16),),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           InkWell(
//             onTap: ()async{
//               await makePayment();
//             },
//             child: Container(
//               height: 40,
//               width:Get.width,
//               margin: EdgeInsets.symmetric(horizontal: 40),
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color:Colors.black,
//                   borderRadius: BorderRadius.circular(Get.height*0.010)
//               ),
//               child: Text("Pay",
//                 textAlign: TextAlign.center,style: TextStyle(
//                     fontSize: Get.height*0.022,
//                     fontFamily: "Roboto",
//                     fontWeight: FontWeight.w600,
//                     color: Colors.white
//                 ),),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> makePayment()async
//   {
//     try {
//       paymentIntentData = await createPaymentInter("20",'USD');
//       //
//       await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentData!['client_secret'],
//           applePay: PaymentSheetApplePay(
//             merchantCountryCode: 'US',
//           ),
//           googlePay: PaymentSheetGooglePay(
//             merchantCountryCode: 'US',
//             testEnv: true,
//           ),
//           style: ThemeMode.dark,
//           // merchantCountryCode:'US',
//           merchantDisplayName: 'KHALID'
//
//       ));
//
//
//       displayPaymentSheet();
//
//       // await Stripe.instance.initPaymentSheet(
//       //   paymentSheetParameters: SetupPaymentSheetParameters(
//       //     paymentIntentClientSecret: jsonResponse['paymentIntent'],
//       //     merchantDisplayName: 'Flutter Stripe Store Demo',
//       //     customerId: jsonResponse['customer'],
//       //     customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
//       //     style: ThemeMode.light,
//       //     testEnv: true,
//       //     merchantCountryCode: 'SG',
//       //   ),
//       // );
//
//
//     }  catch (e) {
//       print(e.toString());
//     }
//
//   }
//   displayPaymentSheet()async
//   {
//
//     // Stripe.instance.presentPaymentSheet(
//     //   parameters: PresentPaymentSheetParameters(clientSecret: paymentIntentData!['client_secret'],
//     //   confirmPayment: true,
//     //   ),
//     //
//     // )
//     // ;
//     //      setState((){
//     //        paymentIntentData = null;
//     //      });
//
//     try {
//       await Stripe.instance.presentPaymentSheet(
//           parameters: PresentPaymentSheetParameters(
//             clientSecret: paymentIntentData!['client_secret'],
//             confirmPayment: true,
//           )).then((newValue){
//
//
//         print('payment intent'+paymentIntentData!['id'].toString());
//         print('payment intent'+paymentIntentData!['client_secret'].toString());
//         print('payment intent'+paymentIntentData!['amount'].toString());
//         print('payment intent'+paymentIntentData.toString());
//         //orderPlaceApi(paymentIntentData!['id'].toString());
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("paid successfully")));
//
//         paymentIntentData = null;
//
//       }).onError((error, stackTrace){
//         print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
//       });
//
//
//     } on StripeException catch (e) {
//       print('Exception/DISPLAYPAYMENTSHEET==> $e');
//       showDialog(
//           context: context,
//           builder: (_) => AlertDialog(
//             content: Text("Cancelled "),
//           ));
//     } catch (e) {
//       print('$e');
//     }
//
//   }
//
//   createPaymentInter(String amountt, String currency)async
//   {
//     try {
//       Map<String,dynamic> body = {
//         'amount':calculateAmount(amountt),
//         'currency':currency,
//         'payment_method_types[]':'card'
//       };
//
//       var response = await http.post(Uri.parse("http://api.stripe.com/v1/payment_intent"),
//           body: body,
//           headers:
//           {
//             // 'Authorization' : 'Bearer sk_test_51LSQiULnTGqzZlXrgmxY4gksD0nLqJCaOi80mkwQ6nF8he69rfbfHPGfgpOXpX9z4YtYcchFRk53QKZxvWaNuaOz00isldZgeX',
//             'Authorization' : 'Bearer sk_test_51M3k0XCWJrqhLfnNMpniCzdKGCgF138lmGiGMHSvuxiEHSuxbO7j7hwUmibykujEXkMZnifm7gDyCAcUYVG6NG2q009XLw73t8',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           }
//       );
//
//       return jsonDecode(response.body.toString());
//     }  catch (e) {
//       print(e.toString());
//     }
//   }
//   calculateAmount(String amount){
//     final price = int.parse(amount) *100;
//     return price.toString();
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stripe Payment'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Make Payment'),
          onPressed: ()async{
            await makePayment();
          },
        ),
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10', 'USD');
      //Payment Sheet
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
              // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
              style: ThemeMode.dark,
              merchantDisplayName: 'Adnan')).then((value){
      });


      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {

    try {
      await Stripe.instance.presentPaymentSheet(
      ).then((value){
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green,),
                      Text("Payment Successfull"),
                    ],
                  ),
                ],
              ),
            ));
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;

      }).onError((error, stackTrace){
        print('Error is:--->$error $stackTrace');
      });


    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text("Cancelled "),
          ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51M3k0XCWJrqhLfnNMpniCzdKGCgF138lmGiGMHSvuxiEHSuxbO7j7hwUmibykujEXkMZnifm7gDyCAcUYVG6NG2q009XLw73t8',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100 ;
    return calculatedAmout.toString();
  }

}