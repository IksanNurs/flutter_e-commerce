import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/owner/create_product.dart';
import '../../component/card_category_owner.dart';
import '../../component/categories.dart';
import '../../utils/colors_constant.dart';

class ProductScreenOwner extends StatefulWidget {
  const ProductScreenOwner({super.key});

  @override
  State<ProductScreenOwner> createState() => _ProductScreenOwnerState();
}

class _ProductScreenOwnerState extends State<ProductScreenOwner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsConstant.mainColor,
        child: Icon(Icons.add),
        onPressed: (){
          // Navigator.push(
          //   context,
          //     MaterialPageRoute(builder: (context) => CreateProduct()
          //   ),
          // );
        }
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: 40,
            ),
          ),
        ),
        // automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Tas',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsConstant.greyColor,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      hintText: "Pencarian Barang",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsConstant.primaryText
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Categories(),
                SizedBox(height: 20,),
                // SingleChildScrollView(
                //   child: Padding(
                //     padding: const EdgeInsets.only(bottom: 20),
                //     child: GridView.count(
                //       shrinkWrap: true,
                //       crossAxisSpacing: 15,
                //       mainAxisSpacing: 5,
                //       crossAxisCount: 2,
                //       children: [
                //         CardProductOwner(
                //           imageProduct: 'assets/product-1.png', 
                //           nameProduct: 'Dompet', 
                //         ),
                //         CardProductOwner(
                //           imageProduct: 'assets/product-1.png', 
                //           nameProduct: 'Dompet', 
                //         ),
                //         CardProductOwner(
                //           imageProduct: 'assets/product-1.png', 
                //           nameProduct: 'Dompet', 
                //         ),
                        
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )
          )
        )
      )
    );
  }
}