import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../component/card_product.dart';
import '../../models/ProductModel.dart';
import '../../services/auth_services.dart';
import '../../utils/colors_constant.dart';
import 'create_product.dart';
import 'detail_product_owner.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key, required this.idCategory});
  final int? idCategory;

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  AuthServices _authServices = AuthServices();
  late Future <List<ProductModel>> dataAllProduct;

  String? nameCategory;
  @override
  void initState() {
    final id = widget.idCategory!;
    print(id);
    dataAllProduct = _authServices.getProductByCategory(id);
    super.initState();
    idCategory = widget.idCategory!;
  }

  int? idCategory;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsConstant.mainColor,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => CreateProduct(idCategory: idCategory,)
            ),
          );
        }
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 15),
            child: Column(
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/people.png',
                      height: 50,
                      width: 50,
                    ),
                    Text(
                      'Padang',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(height: 20,),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ayo tambah kreasi produkmu!',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Jadikan aplikasi jualan songketmu semakin menawan dengan sentuhan kreasi berbagai produk!',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorsConstant.secondaryText
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                FutureBuilder<List<ProductModel>>(
                  future: dataAllProduct,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ProductModel> listData = snapshot.data!;
                      return AlignedGridView.count(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2,
                        itemCount: listData.length,
                        itemBuilder: (context, index) {
                          final x = listData[index];
                          void _loadData() {
                            listData[index];
                            // print(listData[index].id);
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _loadData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProductOwner(product: x, id: x.id)
                                  ),
                                );
                              });
                            },
                            child: CardProduct(
                              id: listData[index].id,
                              imageProduct: listData[index].image.toString(),
                              nameProduct: listData[index].name.toString(),
                              priceProduct: listData[index].price.toString(),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return Center(
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}