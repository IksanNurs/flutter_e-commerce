import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/owner/home_screen_owner.dart';
import 'package:showroom_app/screens/owner/sale_screen.dart';
import 'package:showroom_app/screens/owner/profile_screen.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import 'owner/chat_owner.dart';

class MainScreenOwner extends StatefulWidget {
  const MainScreenOwner({super.key});

  @override
  State<MainScreenOwner> createState() => _MainScreenOwnerState();
}

class _MainScreenOwnerState extends State<MainScreenOwner> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
      bottomNavigationBar: _bottomBar(),
    );
  }
  
  Widget body() {
    switch (currentIndex) {
        case 0:
          return  HomeScreenOwner();
          break;
        case 1:
          return  ChatOwner();
          break;
        // case 2:
        //   return  SaleScreen();
        //   break;
        case 2:
          return  ProfileScreenOwner();
          break;
        default:
        return  HomeScreenOwner();
      }
  }
  
  Widget _bottomBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value){
        print(value);
        setState(() {
          currentIndex = value;
        });
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: ColorsConstant.greenColor,
      type: BottomNavigationBarType.fixed,
      items:  <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/bottomNav/home.png',
                width: 30,
                height: 30,
                color: currentIndex == 0 ? Colors.white : ColorsConstant.primaryText
              ),
              SizedBox(height: 8,),
              Text(
                'Home',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: currentIndex == 0 ? Colors.white : ColorsConstant.primaryText,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          label: ""
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/bottomNav/messages.png',
                width: 30,
                height: 30,
                color: currentIndex == 1 ? Colors.white : ColorsConstant.primaryText
              ),
              SizedBox(height: 8,),
              Text(
                'Pesan',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: currentIndex == 1 ? Colors.white : ColorsConstant.primaryText,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          label: ""
        ),
        // BottomNavigationBarItem(
        //   icon: Column(
        //     children: [
        //       Image.asset(
        //         'assets/bottomNav/shop-add.png',
        //         width: 30,
        //         height: 30,
        //         color: currentIndex == 2 ? Colors.white : ColorsConstant.primaryText
        //       ),
        //       SizedBox(height: 8,),
        //       Text(
        //         'Penjualan',
        //         style: GoogleFonts.poppins(
        //           fontSize: 12,
        //           color: currentIndex == 2 ? Colors.white : ColorsConstant.primaryText,
        //           fontWeight: FontWeight.bold
        //         ),
        //       )
        //     ],
        //   ),
        //   label: ""
        // ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/bottomNav/user.png',
                width: 30,
                height: 30,
                color: currentIndex == 3 ? Colors.white : ColorsConstant.primaryText
              ),
              SizedBox(height: 8,),
              Text(
                'Akun',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: currentIndex == 3 ? Colors.white : ColorsConstant.primaryText,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          label: "",

        ),
      ],
    );
  }
}