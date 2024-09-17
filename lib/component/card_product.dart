import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/detail_product_screen.dart';
import 'package:showroom_app/utils/colors_constant.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key, required this.id, required this.imageProduct, required this.nameProduct, required this.priceProduct});
  final int? id;
  final String imageProduct;
  final String nameProduct;
  final String priceProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsConstant.cardBg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image(
              width:100,
              height:100,
              image: NetworkImage('http://34.101.126.151:8008/img/product/' + id.toString() + '-' +imageProduct)
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            nameProduct,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),
          Text(
            'Rp '+priceProduct,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600
            ),
          )
        ],
      ),
    );
  }
}