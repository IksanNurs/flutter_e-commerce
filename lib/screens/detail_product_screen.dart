import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showroom_app/component/size_product.dart';
import 'package:showroom_app/models/ResponseModel2.dart';
import 'package:showroom_app/screens/chat_screen.dart';
import 'package:showroom_app/screens/checkout_screen.dart';
import 'package:showroom_app/screens/simulation_screen.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import '../component/motif_card.dart';
import '../models/PackageModelV3.dart';
import '../models/ProductModel.dart';
import '../models/ResponseModel2.dart';
import '../models/ResponseModel.dart';
import '../services/auth_services.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key, required this.product, required this.id, });

  final ProductModel product;
  final int? id;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  AuthServices _authServices = AuthServices();
  Future<ResponseModel2>? _futurePostPackage;

  late Future <List<ProductModel>> dataAllProduct;
  ProductModel _product = ProductModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
    
  }

  void _setup() {
    _price = widget.product.price!;
    _name = widget.product.name!;
    _deskripsi = widget.product.deskripsi!;
    _image = widget.product.image!;
    _size = widget.product.size!;
    _motif = widget.product.motif!;
    _idProduct = widget.product.id!;
  }

  int? _idProduct;
  int? _price;
  String? _name;
  String? _deskripsi;
  String? _image;
  List<Size>? _size;
  List<Motif>? _motif;
  bool _like = false;

  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNav(width, context),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Container(
                width: width,
                height: height *0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(34),bottomLeft: Radius.circular(34)),
                  color: ColorsConstant.colorDetail
                ),
                child: Padding(
                padding: const EdgeInsets.only(left: 28,right: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: height*0.25,
                        alignment: Alignment.center,
                        child: Image.network(
                          'http://34.101.126.151:8008/img/product/' + _idProduct.toString() + '-' +_image.toString()
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SimulationScreen()),
                          );
                        },
                        child: Container(
                          height: 56,
                          width: width*0.5,
                          decoration: BoxDecoration(
                            color: ColorsConstant.mainColor,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icon-btn.png'
                                ),
                                SizedBox(width: 8,),
                                Text(
                                  'Simulasikan',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
            
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              // softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              _name.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.end,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              'Rp '+_price.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        _deskripsi.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: ColorsConstant.secondaryText
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Motif',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      MotifProduct(motifProduct: _motif),
                      SizedBox(height: 20,),
                      Text(
                        'Ukuran',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 5,),
                      SizeProduct(sizeProduct: _size),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
            ),
            
          ],
        ),
      ),

    );
  }

  Container BottomNav(double width, BuildContext context) {
    return Container(
      width: width,
      height: 70,
      color: ColorsConstant.greenColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  },
                  child: Image.asset(
                    'assets/bottomNav/messages.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    _like = !_like;
                    print(_like);
                  });
                },
                child: Image.asset(
                  color: (_like) ? Colors.red : Colors.grey[600],
                  'assets/bottomNav/shopping-cart.png',
                  width: 30,
                  height: 30,
                ),
              ),
              GestureDetector(
                onTap: () async{
                  final prefs = await SharedPreferences.getInstance();
                  int? spMotif = prefs.getInt('selectedMotifId');
                  int? spSize = prefs.getInt('selectedSizeId');
                  print(spMotif);
                  print(spSize);
                  print(_idProduct);
                  if(spMotif!=null && spSize!=null){
                      final PackageModelV3  resPostPackage = await _authServices.postPackage(
                        product_id: _idProduct,
                        motif_id: spMotif,
                        size_id: spSize
                      );
                    
                    Fluttertoast.showToast(
                        msg: 'Lanjutkan mengisi data pemesanan',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                    );
                    // final spIdPackage = prefs.setInt('id',id);
                    // print(resPostPackage.data!.package1!.id);
                    // var resPackageById = _authServices.getPackageById(
                    //   resPostPackage.data!.package1!.id!
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckoutScreen(
                        idPackage: resPostPackage.data!.package1!.id,
                        // package: resPackageById,
                      )),
                    );

                    prefs.remove('selectedMotifId');
                    prefs.remove('selectedSizeId');
                    
                  }
                  else{
                    Fluttertoast.showToast(
                        msg: 'Motif dan Size harus diisi',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                    );
                  }
                  // prefs.remove('selectedMotifId');
                  // prefs.remove('selectedSizeId');
                },
                child: Container(
                  height: 70,
                  width: width*0.4,
                  color: ColorsConstant.mainColor,
                  child: Center(
                    child: Text(
                      'Beli Sekarang',
                      textAlign: TextAlign.end,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          
        ],
      ),
    );
  }
}