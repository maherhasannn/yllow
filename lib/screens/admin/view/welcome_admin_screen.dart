import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admin_panel_request.dart';

class WelcomeAdminScreen extends StatelessWidget {
  const WelcomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [

                  SizedBox(height: MediaQuery.of(context).size.height*0.4,),
               InkWell(
                 onTap: (){
                   // Navigator.push(
                   //     context,
                   //     MaterialPageRoute(
                   //         builder: (context) => NameRegistration()));

                   Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (context) => AdminRequestScreen()));
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(bottom: 32),
                   child: Center(
                     child: Text("Admin Request",
                       textAlign: TextAlign.center,
                       style: GoogleFonts.inter(
                           color: Colors.black,
                           fontSize: 20,
                           fontWeight: FontWeight.w800
                       ),
                     ),
                   ),
                 ),
               ),

             ],
           ),
         ),
       ),
    );
  }
}
