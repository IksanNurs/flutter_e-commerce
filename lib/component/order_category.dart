import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors_constant.dart';

class OrderCategory extends StatefulWidget {
  const OrderCategory({super.key});

  @override
  State<OrderCategory> createState() => _OrderCategoryState();
}

class _OrderCategoryState extends State<OrderCategory> {
  List<String> category = ['Belum diproses','Proses pengiriman','Selesai',];
  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.separated(
        // padding: EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10,),
        itemBuilder: (context, index) => buildCategory(index),
        itemCount: category.length,
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
        height: 100,
        width: MediaQuery.of(context).size.width * 0.45,
        padding: EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectedCategory == index ? ColorsConstant.greenColor : ColorsConstant.greyColor
        ),
        child: Center(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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