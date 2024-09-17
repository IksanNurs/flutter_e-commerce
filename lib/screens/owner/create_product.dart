
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showroom_app/component/text_label.dart';

import '../../component/button_global.dart';
import '../../component/text_form.dart';
import '../../services/auth_services.dart';
import '../../utils/colors_constant.dart';
import 'camera_screen.dart';
import 'list_product.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key, required this.idCategory});
  final int? idCategory;

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  List<TextEditingController> listController = [TextEditingController()];
  // File? _imageFile;
  String baseImage = "";

  File? _image ;
  final _picker = ImagePicker();

  void initState() {
    id = widget.idCategory!;
    _idCategory = widget.idCategory!.toString();
    super.initState();
  }

  String? _idCategory;
  int? id;

  final _formKey = GlobalKey<FormState>();
  final _nameProduct = TextEditingController();
  final _descProduct = TextEditingController();
  final _stockProduct = TextEditingController();
  final _priceProduct = TextEditingController();
  final _weightProduct = TextEditingController();
  AuthServices _authServices = AuthServices();
  Future<bool>? _futurePostProduct;


  Future chooseImage(type) async {
    var imagePick;
    if(type=="camera"){
      imagePick = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 10);
    }
    else{
      imagePick = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    setState(() {
      if(imagePick != null){
        _image = File(imagePick.path);
        baseImage = base64Encode(_image!.readAsBytesSync());
      }
      else{
        print('No image selected.');
      }
    });
    
  // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  // setState(() {
  //   if (pickedFile != null) {
  //     _image = File(pickedFile.path);
  //   } else {
  //     print('No image selected.');
  //   }
  // });
} 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Deskripsi Produk',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Content(context)
    );
  }

  SafeArea Content(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    width: 300,
                    height: 200,
                    color: Colors.grey[200],
                    child: (_image != null) ? 
                    Image.file(
                      _image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover
                    ) : 
                    FlutterLogo() 
                    // child: (_imageFile != null) ? Image.file(_imageFile!) : const SizedBox()
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: ColorsConstant.mainColor,
                        ),
                        onPressed: () {
                          chooseImage("camera");
                        },
                        child: Text(
                          'Scan camera',
                            style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 7,),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: ColorsConstant.mainColor,
                        ),
                        onPressed: (){
                          chooseImage("gallery");
                        },
                        child: Text(
                          'Scan galery',
                            style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextLabel(label: 'Nama Produk'),
                    SizedBox(height: 5,),
                    TextFormFields(controller: _nameProduct,),
                    SizedBox(height:20),
                    TextLabel(label: 'Deskripsi Produk'),
                    SizedBox(height: 5,),
                    TextFormFields(controller: _descProduct,),
                    SizedBox(height:20),
                    TextLabel(label: 'Persediaan Produk (Satauan)'),
                    SizedBox(height: 5,),
                    TextFormFields(controller: _stockProduct,),
                    SizedBox(height:20),
                    TextLabel(label: 'Harga Produk (Rp)'),
                    SizedBox(height: 5,),
                    TextFormFields(controller: _priceProduct,),
                    SizedBox(height: 20,),
                    TextLabel(label: 'Berat Produk (Kg)'),
                    SizedBox(height: 5,),
                    TextFormFields(controller: _weightProduct,),
                    // Text(
                    //   'Motif Produk',
                    //     style: GoogleFonts.poppins(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: ColorsConstant.greenColor
                    //   ),
                    // ),
                    // SizedBox(height: 5,),
                    // ListView.builder(
                    //   itemCount: listController.length,
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(top: 15),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Container(
                    //               width: MediaQuery.of(context).size.width * 0.7,
                    //               height: 50,
                    //               child: TextFormField(
                    //                 decoration: InputDecoration(
                    //                   focusColor: ColorsConstant.greenColor,
                    //                   contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    //                   border: OutlineInputBorder(
                    //                     borderRadius: BorderRadius.circular(10)
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             index != 0
                    //             ? GestureDetector(
                    //               onTap: (){
                    //                 setState(() {
                    //                   listController[index].clear();
                    //                   listController[index].dispose();
                    //                   listController.removeAt(index);
                    //                 });
                    //               },
                    //               child: Icon(
                    //                 Icons.delete,
                    //                 color: Color(0xFF6B74D6),
                    //                 size: 35,
                    //               ),
                    //             )
                    //             : const SizedBox()
                    //           ],
                    //         ),
                    //     );
                    //   },
                    // ),
                    // SizedBox(height: 6,),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       listController.add(TextEditingController());
                    //     });
                    //   },
                    //   child: Center(
                    //     child: Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //       decoration: BoxDecoration(
                    //           color: ColorsConstant.mainColor,
                    //           borderRadius: BorderRadius.circular(10)
                    //       ),
                    //       child: Icon(Icons.add, color: Colors.white)
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () async{
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            print(_idCategory);
                            _formKey.currentState!.save();
                            Map<String, String> body = {
                              'name': _nameProduct.text,
                              'category_id' : _idCategory.toString(),
                              'price' : _priceProduct.text,
                              'stock' : _stockProduct.text,
                              'weight' : _weightProduct.text,
                              'deskripsi' : _descProduct.text
                            };
                            print(body);
                            _futurePostProduct = _authServices.postProduct(body, _image!.path);
                            Fluttertoast.showToast(
                              msg: 'Berhasil menambahkan product',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => ListProductScreen(idCategory: id,)),
                              // (Route route) => false
                            );
                          });
                        }
                      },
                      child: ButtonGlobal(
                        label: 'Simpan',
                      ),
                    )
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 50,
                    //   child: TextButton(
                    //     style: TextButton.styleFrom(
                
                    //       backgroundColor: ColorsConstant.greenColor,
                    //     ),
                    //     onPressed: () {
                    //     },
                    //     child: Text(
                    //       'Simpan',
                    //         style: GoogleFonts.poppins(
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white
                    //       ),
                    //     )
                    //   ),
                    // ),
                  ]
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
  
  // FutureBuilder<bool> builderPostProduct() {
  //   return FutureBuilder<bool>(
  //     future: _futurePostProduct,
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         Fluttertoast.showToast(
  //           msg: 'Pastikan mengisi form benar. HP/Email tidak boleh sama',
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //         );
  //         return CreateProduct(idCategory: id,);
  //       } else  {
          // Fluttertoast.showToast(
          //   msg: 'Berhasil menambahkan product',
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          // );
  //         return ListProductScreen(idCategory: id,);
  //       }
  //       // return Center(child: const CircularProgressIndicator());
  //     },
  //   );
  // }
}