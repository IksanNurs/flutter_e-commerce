import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors_constant.dart';

class CardCategory extends StatelessWidget {
  const CardCategory({super.key, this.nameCategory});
  final nameCategory;

  @override
  Widget build(BuildContext context) {
  int selectedCategory = 0;
    return Container(
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorsConstant.greyColor
        ),
        child: Center(
          child: Text(
            nameCategory,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color:  ColorsConstant.secondaryText,
              fontWeight: FontWeight.bold
            ),
          )
        ),
    );
  }
}