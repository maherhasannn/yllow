import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_yellow/screens/home_1/view/home_1_screen.dart';

import '../screens/main_ticket_pages/my_ticket/view/my_ticket_home.dart';
import '../screens/profile/view/profile_screen.dart';
import 'custom_text.dart';
import 'package:get/get.dart';


class CustomBottomNavBar extends StatefulWidget {
  final int? index;
  CustomBottomNavBar({ this.index = 0});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {

  int _selectedIndex = 0;
  PageController? _pageController;
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: 60,
        padding: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: CustomNavigationBar(
           elevation: 0,
            iconSize: Get.height*0.035,
            selectedColor:Colors.white,
            strokeColor: Color(0x30040307),
            unSelectedColor:Colors.black,
            backgroundColor: Colors.white,

            items: [

              CustomNavigationBarItem(
                icon: InkWell(
                  onTap: (){
                      Get.to(()=>Home_1_Screen());
                    },
                  child: Image.asset("images/heartt.png",color:widget.index==0? Colors.black: Colors.grey,),
                ),
                title: CustomText(text: "Home",size:12,fontFamily: "Roboto", color:widget.index==0? Colors.black: Colors.grey,),


              ),

              CustomNavigationBarItem(
                icon: InkWell(
                    onTap: (){
                      Get.to(()=>ProfileScreen());
                    },
                    child:Image.asset("images/uxrrr.png",height: 40,width: 40, fit: BoxFit.fill,color:widget.index==1? Colors.black: Colors.grey,)),
                title: CustomText(text: "User",size:12, color:widget.index==1? Colors.black: Colors.grey,),


              ),
              CustomNavigationBarItem(
                icon: InkWell(
                    onTap: (){
                      Get.to(()=>MyTicketHome());
                    },
                    child:Image.asset("images/music.png",height: 35,width: 35,fit: BoxFit.fill,
                      color:widget.index==2? Colors.black: Colors.grey,)),
                title: CustomText(text: "Tickets",size:12,fontFamily: "Roboto",
                  color:widget.index==2? Colors.black: Colors.grey,
                ),


              ),

            ],
            currentIndex: widget.index??_selectedIndex,
            onTap: (index) {
              // if(index==3 && Get.find<storage_controller>().isGuestMode.value)
              // {
              //   Functions.getLoginConfigDialog();
              //   _selectedIndex = 0;
              // }
              // else{

              _selectedIndex = index;
              // _selectedIndex= AppColor.mainColor,
              _pageController!.animateToPage(index,
                  duration: Duration(milliseconds: 100), curve: Curves.ease);
              // _selectedIndex = index;
              // _pageController!.animateToPage(index,
              //     duration: Duration(milliseconds: 300), curve: Curves.ease);
            }

          //  },
        ),
      );
  }

}
