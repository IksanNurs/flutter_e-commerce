import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/component/card_product.dart';
import 'package:showroom_app/component/categories.dart';
import 'package:showroom_app/utils/colors_constant.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../component/card_category.dart';
import '../models/CategoryModel.dart';
import '../models/ProductModel.dart';
import '../services/auth_services.dart';
import 'detail_product_screen.dart';

final List<String> imgList = [
  'assets/banner.png',
  'assets/banner.png',
  'assets/banner.png'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchProduct = TextEditingController();

  late Future<List<CategoryModel>> dataCategory;
  late Future<List<ProductModel>> dataAllProduct;

  AuthServices serviceAPI = AuthServices();

  @override
  void initState() {
    dataCategory = serviceAPI.getCategory();
    dataAllProduct = serviceAPI.getAllProduct();
    
    super.initState();
  }

  int selectedAllProduct = 0;
  int selectedCategory = -1;
  String text = '';

  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<Widget> imgSliders = imgList
  .map((item) => Container(
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
          ],
        ),
      ))
  .toList();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    double height = MediaQuery.of(context).size.height * 2;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
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
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.notifications,
                      color: Colors.black,
                      size: 30,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    CarouselSlider(
                      items: imgSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? ColorsConstant.secondaryColor
                                        : ColorsConstant.mainColor)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 28),
                  padding: EdgeInsets.symmetric(horizontal: 17, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorsConstant.greyColor,
                  ),
                  child: TextFormField(
                    controller: _searchProduct,
                    onChanged: (_searchProduct){
                      if(_searchProduct == ''){
                        dataAllProduct = serviceAPI.getAllProduct();
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: (){
                          dataAllProduct = serviceAPI.getProductBySearch(_searchProduct.text);
                        },
                      ),
                      hintText: "Mau beli apa hari ini",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorsConstant.primaryText
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          dataAllProduct = serviceAPI.getAllProduct();
                        });
                      },
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width *0.3,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorsConstant.greenColor
                        ),
                        child: Center(
                          child: Text(
                            'All Product',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<CategoryModel>>(
                  future: dataCategory,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CategoryModel> listData = snapshot.data!;
                      return SizedBox(
                        height: 35,
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          itemBuilder: (context, index) {
                            final x = listData[index];
                            void _loadData() {
                              listData[index];
                              print(listData[index].id);
                              dataAllProduct = serviceAPI.getProductByCategory(x.id!);
                            }
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _loadData();
                                  selectedCategory = index;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: MediaQuery.of(context).size.width * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedCategory == index
                                        ? ColorsConstant.greenColor
                                        : ColorsConstant.greyColor),
                                child: Center(
                                  child: Text(
                                  listData[index].name.toString(),
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: selectedCategory == index
                                          ? Colors.white
                                          : ColorsConstant.secondaryText,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            );
                            // return CardCategory(nameCategory: listData[index].name.toString(),);
                          },
                          itemCount: listData.length,
                          scrollDirection: Axis.horizontal,
                        ),
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
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bebaskan Keinginanmu!',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Tambahkan motif kesukaanmu ke dalam barang yang kamu inginkan!     ',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorsConstant.secondaryText),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
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
                            print(listData[index].id);
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _loadData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailProduct(product: x, id: x.id)),
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
          ),
        ),
      ),
    );
  }
}
