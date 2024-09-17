import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/chat_screen.dart';
import 'package:showroom_app/screens/checkout_screen.dart';
import 'package:showroom_app/screens/main_screen.dart';
import 'package:showroom_app/utils/colors_constant.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  final _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // bottomNavigationBar: BottomNav(width, context),
      backgroundColor: ColorsConstant.secondaryText,
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _top(context),
            SizedBox(height: 20,),
            _body(context)
          ],
        ),
      ),
    );
  }
  
  Widget _top(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5,left: 28,right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: width*0.25,),
                  Text(
                    'AR 3D',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20,),
        Text(
          'Sesuaikan Kamera dengan objek ',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 20,),
        Container(
          height: height*0.35,
          child: Image.asset('assets/simulation.png')
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: _messageController,
              // maxLines: 2,
              keyboardType: TextInputType.emailAddress,
              cursorColor: ColorsConstant.primaryText,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.create_rounded),
                suffixIcon: Icon(Icons.camera_alt_rounded),
                hintText: 'Masukkan Alamat',
                hintStyle: TextStyle(
                    fontFamily: 'poppins'
                ),
                // alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
             ),
          ),
        )
      ],
      
    );
}
  
  Widget _body(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   decoration: BoxDecoration(
                     // color: ColorsConstant.cardBg,
                    //  color: ColorsConstant.cardBg,
                    color: Colors.black,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   width: width * 0.3,
                   height: 100,
                   child: Image.asset(
                     'assets/product-1.png'
                   ),
                 ),
                 SizedBox(width: 15,),
                 Container(
                   width: width*0.45,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         maxLines: 2,
                         overflow: TextOverflow.clip,
                         'Songket Kondangan',
                         style: GoogleFonts.poppins(
                           fontSize: 16,
                           fontWeight: FontWeight.w600
                         ),
                       ),
                       SizedBox(height: 5,),
                       Text(
                         'Rp 199.000',
                         style: GoogleFonts.poppins(
                           fontSize: 16,
                           fontWeight: FontWeight.w400
                         ),
                       ),
                       SizedBox(height: 5,),
                       Text(
                         'Motif',
                         style: GoogleFonts.poppins(
                           fontSize: 16,
                           fontWeight: FontWeight.w600
                         ),
                       ),
                       SizedBox(height: 5,),
                       Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset('assets/motif.png'),
                          SizedBox(width: 3,),
                          Image.asset('assets/motif.png'),
                          SizedBox(width: 3,),
                          Image.asset('assets/motif.png'),
                        ],
                      ),
                     ],
                   ),
                 )
               ],
             ),
          ],
        ),
    );
  }
  

  // Container BottomNav(double width, BuildContext context) {
  //   return Container(
  //     width: width,
  //     height: 70,
  //     color: ColorsConstant.greenColor,
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(left: 50),
  //               child: GestureDetector(
  //                 onTap: () {
  //                   Navigator.push(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => MainScreen(
                        
  //                     )),
  //                   );
  //                 },
  //                 child: Image.asset(
  //                   'assets/bottomNav/messages.png',
  //                   width: 30,
  //                   height: 30,
  //                 ),
  //               ),
  //             ),
  //             Image.asset(
  //               'assets/bottomNav/shopping-cart.png',
  //               width: 30,
  //               height: 30,
  //             ),
  //             GestureDetector(
  //               onTap: (){
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(builder: (context) => CheckoutScreen()),
  //                 );
  //               },
  //               child: Container(
  //                 height: 70,
  //                 width: width*0.4,
  //                 color: ColorsConstant.mainColor,
  //                 child: Center(
  //                   child: Text(
  //                     'Beli Sekarang',
  //                     textAlign: TextAlign.end,
  //                     style: GoogleFonts.poppins(
  //                       fontSize: 16,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
          
  //       ],
  //     ),
  //   );
  // }
  
}