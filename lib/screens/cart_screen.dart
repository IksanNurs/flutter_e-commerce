import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/utils/colors_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  List imageList = [
    'assets/product-1.png',
    'assets/product-1.png',
    'assets/product-1.png',
  ];

  List productList = [
    'Songket Kondangahun',
    'Songket Kondangabjusasasasabujn',
    'Songket Kondangan'
  ];

  List motifList = [
    'Batik',
    'Pandai Sikek',
    'Silungkakng'
  ];

  List priceList = [
    'Rp199.000',
    'Rp199.000',
    'Rp199.000'
  ];

  bool isChecked = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Keranjang',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        height: 89,
        color: ColorsConstant.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    Text(
                      'Rp 199.000',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(130, 45),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () { },
                  child: Text(
                    'Checkout',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: ColorsConstant.mainColor
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical:15),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: imageList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Checkbox(
                              splashRadius: 20,
                              value: isChecked,
                              activeColor: ColorsConstant.mainColor, 
                              onChanged: (bool? value){
                                setState(() {
                                  isChecked = value!;
                                });
                              }
                            ),
                            Container(
                              color: ColorsConstant.cardBg,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  imageList[index],
                                  height: 90,
                                  width: 80
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 2,
                                    productList[index].toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(height:10), 
                                  Text(
                                    'Motif : '+motifList[index],
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  SizedBox(height:10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        priceList[index],
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(width:7),
                                          Text(
                                            '122',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          SizedBox(width:7),
                                          Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } ,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}