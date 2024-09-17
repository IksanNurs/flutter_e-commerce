import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import '../models/ProductModel.dart';

class SizeProduct extends StatefulWidget {
  const SizeProduct({super.key, required this.sizeProduct});
  final List<Size>? sizeProduct;

  @override
  State<SizeProduct> createState() => _SizeProductState();
}

class _SizeProductState extends State<SizeProduct> {
  
  @override
  void initState() {
    super.initState();
    _sizeP = widget.sizeProduct!;
  }

  List<Size>? _sizeP;
  int selectedSize = -1;
  int selectedSizeId = 0;


  @override
  Widget build(BuildContext context) {
    return Container(
      height:56,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10,),
        itemBuilder: (context, index) => buildCategory(index,_sizeP![index].id),
        itemCount: _sizeP!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
  
  Widget buildCategory(int index, id) {
    return GestureDetector(
      onTap: () async{
        setState((){
          selectedSize = index;
          selectedSizeId = id;
          
          print('size ' +selectedSizeId.toString());
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('selectedSizeId');
        await prefs.setInt('selectedSizeId', selectedSizeId);

      },
      child: Container(
        height: 56,
        width: 56,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          // borderRadius: BorderRadius.all(Radius.circular(200)),
          color: selectedSize == index ? ColorsConstant.greenColor : ColorsConstant.greyColor
        ),
        child: Center(
          child: Text(
            // _sizeP[index],
            _sizeP![index].name.toString(),
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: selectedSize == index ? Colors.white : ColorsConstant.secondaryText,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}