import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/concert_dashboard/create_event/controller/event_controller.dart';
import 'package:new_yellow/screens/main_ticket_pages/cobtroller/concert_information_controller.dart';
import 'package:share_plus/share_plus.dart';

import '../../../stripe_payment_screen/controller.dart';

class BuyTicketScreen extends StatefulWidget {
  BuyTicketScreen({ this.img, this.title, this.date, this.location, this.caption, this.price, this.genre, this.docId, this.spotify, this.instagram});
  final img;
  final title;
  final date;
  final location;
  final caption;
  final price;
  final genre;
  final spotify;
  final instagram;
  final docId;

  @override
  State<BuyTicketScreen> createState() => _BuyTicketScreenState();
}

class _BuyTicketScreenState extends State<BuyTicketScreen> {
  final controller = Get.put(ConcertInfoController());

  final eventCont = Get.put(EventController());

  var paymentEdtText = TextEditingController();

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    paymentEdtText.text = widget.price;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(widget.img),fit: BoxFit.cover)
                ),

              ),
              SizedBox(height: 20,),
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize:20,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                "Playboi Carti, Ken Carson",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize:16,

                ),
              ),
              SizedBox(height: 20,),
              Text(
                widget.date,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w700,
                  fontSize:16,

                ),
              ),
              SizedBox(height: 20,),
              Obx(() {
                return   controller.isClicked.value?
                Center(
                  child: InkWell(
                    onTap: (){
                      controller.isClicked.value = false;
                    },
                    child: Column(
                      children: [
                        Text(
                          "Swipe down",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize:12,

                          ),
                        ),
                        Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 25,)
                      ],
                    ),
                  ),
                ):SizedBox.shrink();
              }),
              SizedBox(height: 20,),
              Obx(() {
                return   controller.isClicked.value?SizedBox.shrink() :
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ConstrainedBox(

                      constraints: BoxConstraints(maxWidth: 160),
                      child: Text(
                        widget.location,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize:16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Genre: ${widget.genre}",  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w700,
                      fontSize:16,
                    ),

                    ),
                    SizedBox(height: 10,),
                    Text("Price: \$ ${widget.price}",  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w700,
                      fontSize:16,
                    ),),

                    SizedBox(height: 10,),
                    Text("Caption:",  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize:16,
                    ),),

                    SizedBox(height: 10,),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(widget.caption,  style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w700,
                        fontSize:16,
                      ),),
                    ),
                    SizedBox(height: 70,),
                    customTextField(),
                    SizedBox(height: 30,),
                    Center(child: CustomText(text: "Want to attend this show?",size: 18,bold: FontWeight.w700,color: Colors.black,)),
                    SizedBox(height: 20,),
                    Center(child: CustomText(text: "Note: Pressing “Buy Tickets” will take you to an external link where you will be able to purchase tickets for this event.",size: 10,bold: FontWeight.w400,color: Colors.black.withOpacity(0.5),)),
                    SizedBox(height: 10,),
                    Center(child: CustomText(text: "Tickets to this show are not sold by Yllow. ",size: 12,bold: FontWeight.w400,color: Color(0xffC0C0C0),)),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: ()async
                      {
                        log("checkout button clicked");
                        log(widget.docId);
                        await makePayment();
                        eventCont.eventSold(id: widget.docId).then(({
                         // makePayment
                         //   Get.find<PaymentController>().makePayment(amount: "150", currency: "USD"),

                            }));

                      //  Get.find<PaymentController>().makePayment(amount: "150", currency: "USD");

                        //    Get.find<EventController>().eventSold(id: docId);
                      },
                      child:
                      Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration
                          (
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: CustomText(text: "Buy Tickets",size: 13,color: Colors.white,),
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                );
              })

            ],
          ),
        ),
      ),
    );
  }

  customTextField(){
    return
      TextFormField
        (
        style: TextStyle(fontSize: 14,color: Colors.black,),
        controller: eventCont.shareLinkEditingController,
        decoration: InputDecoration
          (
          prefixIcon:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap:(){
                        eventCont.shareLinkEditingController.text = widget.instagram;
                      },child: Image.asset(height: 20,width:20,"images/insta.png",fit: BoxFit.fill,)),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap:(){
                        eventCont.shareLinkEditingController.text = widget.spotify;
                      },
                      child: Image.asset(height: 20,width:20,"images/Spotify logo.png",fit: BoxFit.fill,)),
                ],
              ),
              InkWell(
                onTap:()async{
                  // _onShare method:
                  //  final box = findRenderObject() as RenderBox?;

                  await Share.share(
                    widget.title,
                    subject: widget.caption,
                    //sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
                  );
                },
                child: Row(
                  children: [
                    CustomText(text: "Share link",size: 12,color: Colors.black,),
                    SizedBox(width: 10,),
                    Image.asset(height: 20,width:20,"images/link.png",fit: BoxFit.fill,),
                  ],
                ),
              )
            ],
          ),

        ),
      );
  }

  cusColumn({final image,final title}){
    return Column(
      children:
      [
        Image.asset(image,fit: BoxFit.fill,height: 30,width: 30,),
        SizedBox(height: 15,),
        CustomText(text: title,size: 14,color: Colors.black,bold: FontWeight.w700,)
      ],
    );
  }

  cTextField() {
    return Container(
      height: 35,
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10
          ),
          border: Border.all(color: Colors.black.withOpacity(0.5),width: 1)
      ),
      width:double.infinity,
      child: TextFormField(
        controller: paymentEdtText,
        decoration: InputDecoration(
            hintText: "1 Ticket",
            hintStyle: TextStyle(fontSize: 14),
            //suffix: Text("FINAL TOTAL \$ ${price}"),
            contentPadding: EdgeInsets.all(10),
            border: InputBorder.none
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
