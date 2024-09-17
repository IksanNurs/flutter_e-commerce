import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import '../screens/owner/product_screen_owner.dart';

class CardCategoryOwner extends StatelessWidget {
  const CardCategoryOwner({super.key, required this.imageCategory, required this.nameCategory, required this.id});
  final int? id;
  final String imageCategory;
  final String nameCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsConstant.cardBg,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image(
            width:120,
            height:120,
            image: NetworkImage('http://34.101.126.151:8008/img/category/'+id.toString() + '-' +imageCategory)
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            nameCategory,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600
            ),
          ),
        ],
      ),
      
    );
  }
}