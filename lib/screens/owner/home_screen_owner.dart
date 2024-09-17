import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:showroom_app/component/card_category_owner.dart';
import 'package:showroom_app/component/categories_owner.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import '../../component/text_form.dart';
import '../../component/text_label.dart';
import '../../models/CategoryModel.dart';
import '../../services/auth_services.dart';
import 'list_product.dart';

class HomeScreenOwner extends StatefulWidget {
  const HomeScreenOwner({super.key});

  @override
  State<HomeScreenOwner> createState() => _HomeScreenOwnerState();
}

class _HomeScreenOwnerState extends State<HomeScreenOwner> {
  final _formKey = GlobalKey<FormState>();
  final _nameProduct = TextEditingController();
  AuthServices _authServices = AuthServices();

  Future<List<CategoryModel>>? dataCategory;

  File? _image ;
  final _picker = ImagePicker();

Future getImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
} 

  List<String> items = [
    "Produk",
    "Motif",
  ];
  int selectedCategory = 0;

  @override
  void initState() {
    dataCategory = _authServices.getCategory();
    super.initState();
  }

  @override
  Widget _buildImage() {
    if (_image == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Text(_image!.path);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsConstant.mainColor,
        child: Icon(Icons.add),
        onPressed: (){
          showDialog(useSafeArea: true,
            context: context, 
            builder: (context) => AlertDialog(
              content: Container(
                height: 350,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Tambahkan Kategori Produk Baru',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextLabel(label: 'Nama Kategori Produk',),
                        SizedBox(height: 5,),
                        TextFormFields(controller: _nameProduct),
                        SizedBox(height: 20,),
                        Text(
                          'Gambar Kategori',
                           style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorsConstant.greenColor
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          color: ColorsConstant.greenColor,
                          child: TextButton(
                            onPressed: getImage, 
                            child: _buildImage()
                          )
                        ),
                        // GestureDetector(
                        //   onTap: () async{
                        //     final result = await FilePicker.platform.pickFiles();
                        //     print(result);
                        //   },
                        //   child: Container(
                        //     height: 50,
                        //     width: MediaQuery.of(context).size.width,
                        //     decoration: BoxDecoration(
                        //       color: ColorsConstant.greenColor,
                        //       borderRadius: BorderRadius.circular(10)
                        //     ),
                        //     child: Center(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Icon(Icons.upload_file, color: Colors.white,),
                        //               Text(
                        //                 'Pilih gambar',
                        //                   style: GoogleFonts.poppins(
                        //                   fontSize: 16,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.white
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                                if(_formKey.currentState!.validate()){
                                  print(_nameProduct);
                                  _formKey.currentState!.save();
                                  Map<String, String> body = {
                                    'name': _nameProduct.text,
                                  };
                                  var res =_authServices.postCategory(body, _image!.path);
                                  Fluttertoast.showToast(
                                    msg: 'Berhasil menambahkan product',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    '/main-owner'
                                  );
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
                // DefaultTabController(
                //   length: items.length, 
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Material(
                //         child: Container(
                //           height: 55,
                //           color: Colors.white,
                //           child: TabBar(  
                //             isScrollable: true,
                //             physics: const ClampingScrollPhysics(),
                //             padding: EdgeInsets.only(top: 10, bottom: 10),
                //             unselectedLabelColor: ColorsConstant.greyColor,
                //             indicatorSize: TabBarIndicatorSize.label,
                //             indicator: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: ColorsConstant.greenColor
                //             ),
                //             tabs: [
                //               Tab(
                //                 child: Container(
                //                   height: 100,
                //                   width: MediaQuery.of(context).size.width * 0.4,
                //                   // padding: EdgeInsets.symmetric(horizontal: 28),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(10),
                //                     color: ColorsConstant.greyColor,
                //                   ),
                //                   child: Align(
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       'Produk',
                //                       style: GoogleFonts.poppins(
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.bold
                //                       ),
                //                     )
                //                   ),
                //                 ),
                //               ),
                //               Tab(
                //                 child: Container(
                //                   height: 35,
                //                   width: MediaQuery.of(context).size.width * 0.25,
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(10),
                //                     border: Border.all(color: Colors.pinkAccent,width: 1),
                //                     color: ColorsConstant.greyColor
                //                   ),
                //                   child: Align(
                //                     alignment: Alignment.center,
                //                     child: Text(
                //                       'Motif'
                //                       // items.toString()
                //                     ),
                //                   ),
                //                 ),
                //               ),
                              
                //             ],
                //           )
                //         ),
                //       )
                //     ],
                //   )
                // )
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ayo tambah kreasi kategori produkmu!',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      'Jadikan aplikasi jualan songketmu semakin menawan dengan sentuhan kreasi berbagai motif produk!',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: ColorsConstant.secondaryText
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                FutureBuilder<List<CategoryModel>>(
                  future: dataCategory,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CategoryModel> listData = snapshot.data!;
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
                            // print('oke');
                            // print(listData[index].id);
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _loadData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListProductScreen(idCategory: x.id)
                                  ),
                                );
                              });
                            },
                            child: CardCategoryOwner(
                              id: listData[index].id,
                              imageCategory: listData[index].image.toString(),
                              nameCategory: listData[index].name.toString(),
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
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        )
      ),
    );
  }
  
}
