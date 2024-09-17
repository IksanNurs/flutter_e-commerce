import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors_constant.dart';

class Categories extends StatefulWidget {
  const Categories({super.key, this.nameCategory});
  final nameCategory;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> nameCategory = ['Tas','Topi','Songket','Sandal','Baju','Celanaaaaaaaaaaaaaaaaa'];
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        // padding: EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10,),
        itemBuilder: (context, index) => buildCategory(index),
        itemCount: nameCategory.length,
        scrollDirection: Axis.horizontal,
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
        width: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedCategory == index ? ColorsConstant.greenColor : ColorsConstant.greyColor
        ),
        child: Center(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            nameCategory[index],
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