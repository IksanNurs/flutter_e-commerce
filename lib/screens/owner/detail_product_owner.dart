import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../component/motif_card.dart';
import '../../component/size_product.dart';
import '../../component/text_form.dart';
import '../../component/text_label.dart';
import '../../models/ProductModel.dart';
import '../../services/auth_services.dart';
import '../../utils/colors_constant.dart';

class DetailProductOwner extends StatefulWidget {
  const DetailProductOwner({super.key, required this.product, required this.id});
  final ProductModel product;
  final int? id;

  @override
  State<DetailProductOwner> createState() => _DetailProductOwnerState();
}

class _DetailProductOwnerState extends State<DetailProductOwner> {
  AuthServices _authServices = AuthServices();

  late Future <List<ProductModel>> dataAllProduct;
  ProductModel _product = ProductModel();
  final _formKeyMotif = GlobalKey<FormState>();
  final _formKeySize = GlobalKey<FormState>();
  final _sizeProduct = TextEditingController();
  final _nameMotif = TextEditingController();
  final _priceMotif = TextEditingController();

  File? _imagePicked ;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imagePicked = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  } 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
    
  }
  @override
  Widget _buildImage() {
    if (_imagePicked == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Text(_imagePicked!.path);
    }
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Motif',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showDialog(useSafeArea: true,
                                context: context, 
                                builder: (context) => AlertDialog(
                                  content: Container(
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: _formKeyMotif,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              'Tambahkan Motif Produk',
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            TextLabel(label: 'Nama Motif',),
                                            SizedBox(height: 5,),
                                            TextFormFields(controller: _nameMotif),
                                            SizedBox(height: 20,),
                                            TextLabel(label: 'Harga Motif',),
                                            SizedBox(height: 5,),
                                            TextFormFields(controller: _priceMotif),
                                            SizedBox(height: 20,),
                                            TextLabel(label: 'Gambar Motif',),
                                            SizedBox(height: 5,),
                                            Container(
                                              color: ColorsConstant.greenColor,
                                              child: TextButton(
                                                onPressed: getImage, 
                                                child: _buildImage()
                                              )
                                            ),
                                            SizedBox(height: 20,),
                                            Center(
                                              child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: ColorsConstant.mainColor,
                                                  ),
                                                  onPressed: ()async{
                                                    if(_formKeyMotif.currentState!.validate()){
                                                      setState(() {
                                                        // print(_idProduct);
                                                        _formKeyMotif.currentState!.save();
                                                        Map<String, String> body = {
                                                          'name': _nameMotif.text,
                                                          'price' : _priceMotif.text,
                                                          'product_id' : _idProduct.toString()
                                                        };
                                                        // print(body);
                                                        
                                                        final prefs = _authServices.postMotif(body, _imagePicked!.path);
                                                        Fluttertoast.showToast(
                                                            msg: 'Berhasil Menambahkan Motif Product',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                        );
                                                        _formKeyMotif.currentState!.reset();
                                                        Navigator.of(context).pop();

                                                      });
                                                }
                                                  }, 
                                                  child: Text(
                                                    'Tambahkan',
                                                      style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    ),
                                                  )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorsConstant.greenColor
                              ),
                              child: Center(
                                child: Icon(
                                  color: Colors.white,
                                  Icons.add
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
                      MotifProduct(motifProduct: _motif),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ukuran',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              showDialog(useSafeArea: true,
                                context: context, 
                                builder: (context) => AlertDialog(
                                  content: Container(
                                    height: 250,
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: _formKeySize,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              textAlign: TextAlign.center,
                                              'Tambahkan Ukuran Produk',
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black
                                              ),
                                            ),
                                            SizedBox(height: 20,),
                                            TextLabel(label: 'Ukuran Product (Inisial)',),
                                            SizedBox(height: 5,),
                                            TextFormFields(controller: _sizeProduct),
                                            SizedBox(height: 20,),
                                            Center(
                                              child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context).size.width * 0.4,
                                                child: TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: ColorsConstant.mainColor,
                                                  ),
                                                  onPressed: ()async{
                                                    if(_formKeySize.currentState!.validate()){
                                                      setState(() {
                                                        final prefs =  _authServices.postSizeProduct(
                                                          _idProduct,
                                                          _sizeProduct.text
                                                        );
                                                        Fluttertoast.showToast(
                                                            msg: 'Berhasil Menambahkan Ukuran',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                        );
                                                        _formKeySize.currentState!.reset();
                                                        Navigator.of(context).pop();
                                                      });
                                                      
                                                    }
                                                  }, 
                                                  child: Text(
                                                    'Tambahkan',
                                                      style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white
                                                    ),
                                                  )
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: ColorsConstant.greenColor
                              ),
                              child: Center(
                                child: Icon(
                                  color: Colors.white,
                                  Icons.add
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10,),
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
}