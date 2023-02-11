import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:new_yellow/global_widget/custom_text.dart';
import 'package:new_yellow/screens/main_ticket_pages/cobtroller/concert_information_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConcertScanQrCode extends StatefulWidget {
  ConcertScanQrCode({required this.docId});
  final docId;

  @override
  State<ConcertScanQrCode> createState() => _ConcertScanQrCodeState();
}

class _ConcertScanQrCodeState extends State<ConcertScanQrCode> {
  @override
  void initState() {
    super.initState();
    scanQR();
  }


  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  String _scanBarcode = 'Unknown';

  final controller = Get.put(ConcertInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "55 tickets sold",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize:14,
              ),
            ),
            Text(
              "1 ticket(s) scanned",
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w700,
                fontSize:14,
              ),
            ),
          ],
        ),
        leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height*0.8,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       image: DecorationImage(image: AssetImage("images/scan_ticket.png"),fit: BoxFit.fill)
              //   ),
              //
              // ),
              // Container(
              //   height: MediaQuery.of(context).size.height*0.8,
              //   width: MediaQuery.of(context).size.width,
              //   alignment: Alignment.center,
              //   child: Center(
              //     child: QrImage(
              //       data: widget.docId,
              //       version: QrVersions.auto,
              //       size: 220,
              //       gapless: false,
              //     ),
              //   ),
              // ),
              SizedBox(height: 20,),
              Center(
                child: Text('Event ID : $_scanBarcode\n',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w700,
                    fontSize:14,
                  ),),
              ),

              SizedBox(height: 20,),
              Center(
                child: Text(
                  "Tickets will automatically scan once in view",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize:14,
                  ),
                ),
              ),
              SizedBox(height: 20,),

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
        decoration: InputDecoration
          (
          prefixIcon:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(height: 20,width:20,"images/insta.png",fit: BoxFit.fill,),
                  SizedBox(width: 10,),
                  Image.asset(height: 20,width:20,"images/Spotify logo.png",fit: BoxFit.fill,),
                ],
              ),
              Row(
                children: [
                  CustomText(text: "Share link",size: 12,color: Colors.black,),
                  SizedBox(width: 10,),
                  Image.asset(height: 20,width:20,"images/link.png",fit: BoxFit.fill,),
                ],
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
}
