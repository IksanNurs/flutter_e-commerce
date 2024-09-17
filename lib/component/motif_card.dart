import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ProductModel.dart';
import '../utils/colors_constant.dart';
class MotifProduct extends StatefulWidget {
  const MotifProduct({super.key, required this.motifProduct});
  final List<Motif>? motifProduct;

  @override
  State<MotifProduct> createState() => _MotifProductState();
}

class _MotifProductState extends State<MotifProduct> {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _motifP = widget.motifProduct!;

  }

  List<Motif>? _motifP;
  int selectedMotif = -1;
  int selectedMotifId = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 10,),
        itemBuilder: (context, index) => buildMotif(index, _motifP![index].id!, _motifP![index].image!),
        itemCount: _motifP!.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildMotif(int index, int id, String imageProduct) {
    return GestureDetector(
      onTap: () async{
        setState((){
          selectedMotif = index;
          selectedMotifId = id;
          print(selectedMotifId);
        });
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('selectedMotifId');
        await prefs.setInt('selectedMotifId', selectedMotifId);

      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: selectedMotif == index ? ColorsConstant.greenColor : ColorsConstant.greyColor
        ),
        child: Center(
          child: Image(
            width:40,
            height: 40,
            image: NetworkImage('http://34.101.126.151:8008/img/motif/' +id.toString() + '-' +imageProduct),
          ),
          // child: Text(
          //   _motifP![index].name.toString(),
          //   style: GoogleFonts.poppins(
          //     fontSize: 16,
          //     color: selectedSize == index ? Colors.white : ColorsConstant.secondaryText,
          //     fontWeight: FontWeight.bold
          //   ),
          //   textAlign: TextAlign.center,
          // )
        ),
      ),
    );
  }
}