import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/cart_screen.dart';
import 'package:showroom_app/screens/chat_screen.dart';
import 'package:showroom_app/screens/home_screen.dart';
import 'package:showroom_app/screens/profile_screen.dart';
import 'package:showroom_app/screens/profile_screen_2.dart';
import '../utils/colors_constant.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: body(),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget body()
  {
      switch (currentIndex) {
        case 0:
          return  HomeScreen();
          break;
        case 1:
          return  CartScreen();
          break;
        case 2:
          return  ChatScreen();
          break;
        case 3:
          return  ProfileScreenV2();
          break;
        default:
        return  HomeScreen();
      }
  }

  Widget _bottomBar(){
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
                'assets/bottomNav/shopping-cart.png',
                width: 30,
                height: 30,
                color: currentIndex == 1 ? Colors.white : ColorsConstant.primaryText
              ),
              SizedBox(height: 8,),
              Text(
                'Keranjang',
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
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/bottomNav/messages.png',
                width: 30,
                height: 30,
                color: currentIndex == 2 ? Colors.white : ColorsConstant.primaryText
              ),
              SizedBox(height: 8,),
              Text(
                'Pesan',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: currentIndex == 2 ? Colors.white : ColorsConstant.primaryText,
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