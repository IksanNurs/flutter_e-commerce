import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/utils/colors_constant.dart';

class CategoriesOwner extends StatefulWidget {
  const CategoriesOwner({super.key});

  @override
  State<CategoriesOwner> createState() => _CategoriesOwnerState();
}

class _CategoriesOwnerState extends State<CategoriesOwner> {
  List<String> category = ['Produk','Motif'];
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: ListView.separated(
          // padding: EdgeInsets.symmetric(horizontal: 28),
          separatorBuilder: (context, index) => const SizedBox(width: 10,),
          itemBuilder: (context, index) => buildCategory(index),
          itemCount: category.length,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
}

   Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
      },
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width * 0.4,
        // padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedCategory == index ? ColorsConstant.greenColor : ColorsConstant.greyColor
        ),
        child: Center(
          child: Text(
            category[index],
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: selectedCategory == index ? Colors.white : ColorsConstant.secondaryText,
              fontWeight: FontWeight.bold
            ),
          )
        ),
      ),
    );
  }
}