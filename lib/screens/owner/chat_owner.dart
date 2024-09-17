import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors_constant.dart';

class ChatOwner extends StatelessWidget {
  const ChatOwner({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsConstant.greenColor,
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _top(),
            _body(context)
          ],
        )
      ),
    );
  }
  
  Widget _top() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/profile.png'),
          SizedBox(width: 8,),
          Text(
            'Showroom',
            style: GoogleFonts.poppins(
              fontSize: 16, 
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
  
  Widget _body(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          color: Colors.white
        ),
        child: Column(
          children: [
            Text('hello')
          ],
        ),
    );
  }
}