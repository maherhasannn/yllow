import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_yellow/auth/welcome_screen/welcome_screen.dart';
import 'package:new_yellow/screens/admin/view/admin_panel_request.dart';
import 'package:new_yellow/screens/admin/view/welcome_admin_screen.dart';
import 'package:video_player/video_player.dart';

import '../sign_up/view/name_screen.dart';




class LoadingScreenGif extends StatefulWidget {
  const LoadingScreenGif({Key? key}) : super(key: key);
  @override
  _LoadingScreenGifState createState() => _LoadingScreenGifState();
}

class _LoadingScreenGifState extends State<LoadingScreenGif> with TickerProviderStateMixin {

  VideoPlayerController? _controller;
  @override
  void initState() {
    //_controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')..initialize().then((value)
    _controller = VideoPlayerController.asset('video/test1.mp4')..initialize().then((value)
    {
      setState(() {
        // _controller!.play();
        if(_controller!.value.isPlaying){
          _controller?.pause();
        }else{
          _controller?.play();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose(){
    _controller!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:
          Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller?.value.size?.width ?? 0,
                    height: _controller?.value.size?.height ?? 0,
                    child: VideoPlayer(_controller!),
                  ),
                ),
              ),

              LoginWidget()

            ],
          ),
        )
    );
  }
}
class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage("images/simpson_person.gif"),
            //     fit: BoxFit.fill
            // )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(" "),
              Column(
                children: [
                  Container(
                    child: Text("Y L L O W ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Color(0xffFFFFFF),
                          fontSize: 30,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  Text("EARLY RELEASE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Color(0xffFFFFFF),
                        fontSize: 14,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                InkWell(
                  onTap: (){
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => AdminRequestScreen()));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NameRegistration()));

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => WelcomeAdminScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Text("Tap to continue",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800
                      ),
                    ),
                  ),
                ),
              ),

            ],
          )

      ),
    );
  }
}















// GestureDetector(
// onTap: (){
// Navigator.push(context, MaterialPageRoute(builder: (context)=>NameRegistration()));
// },
// child: Text("Tap to continue",style: GoogleFonts.inter(
// fontSize: 20.0,
// fontWeight: FontWeight.w800,
// color: Color(0xffFFFFFF)
// ),)
// ),