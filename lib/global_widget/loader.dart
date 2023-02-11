import 'package:flutter/material.dart';

class kLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child:Image.asset("images/p_3.png",height: 120,width: 120,),
        ),
      ],
    );
  }

}

