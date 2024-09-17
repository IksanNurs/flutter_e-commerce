import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/component/button_global.dart';
import 'package:showroom_app/models/PackageModleV2.dart';
import 'package:showroom_app/screens/main_screen.dart';
import 'package:showroom_app/utils/colors_constant.dart';

import '../models/PackageModel.dart';
import '../models/PackageModelV3.dart';
import '../models/PackageModelV4.dart';
import '../models/ProductModel.dart';
import '../services/auth_services.dart';
import 'invoice.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({super.key, required this.idPackage});
  // final PackageModelV2? package; 
  int? idPackage;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final AuthServices _authServices = AuthServices();
  Future<PackageModelV4>?  _futurePostPackage;

  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePostPackage = _authServices.getPackageById(widget.idPackage!);

    print(_futurePostPackage);
  }

  final  _formKey = GlobalKey<FormState>(); 
  final _addressController = TextEditingController();
  final _opsiController = TextEditingController();
  final _messageController = TextEditingController();
  int _valueDelivery = 1;
  int _valueMethode = 1;
  int _jne = 60000;
  int _jnt = 40000;

  
  int _counter = 1;
  int? idPackage;
  int? motifIdPackage;
  int? sizeIdPackage;
  int? productIdPackage;
  int? totalPrice = 0;
  int? _totalPrice = 0;
  int? _delivery = 0;
  int? _totalAllPrice = 0;
  int? priceDelivery = 0;

  void _addCounter(){
    setState(() {
      _counter++;
      _totalPrice = totalPrice! * _counter;
      if(_valueDelivery == 1){
        priceDelivery = _jnt;
      }else{
        priceDelivery = _jne;
      }
      _totalAllPrice = _totalPrice! + priceDelivery!;
      print(_totalAllPrice);
      print(_totalPrice);
      print(_counter);
    });
  }

  void _minCounter(){
    setState(() {
      if(_counter != 1){
        _counter--;
        _totalPrice = totalPrice! * _counter;
      if(_valueDelivery == 1){
        priceDelivery = _jnt;
      }else{
        priceDelivery = _jne;
      }
      _totalAllPrice = _totalPrice! + priceDelivery!;
      print(_totalAllPrice);
      print(_totalPrice);
      print(_counter);
      }
    });
  }
  
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 20),
        //   child: GestureDetector(
        //     onTap: (){
        //       Navigator.pop(context);
        //     },
        //     child: Icon(
        //       Icons.arrow_back,
        //       color: Colors.black87,
        //       size: 40,
        //     ),
        //   ),
        // ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Menyiapkan Pesanan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(width, context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical:15),
          child: FutureBuilder<PackageModelV4>(
            future: _futurePostPackage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('ter');
                PackageModelV4? dataGetPackage = snapshot.data!;
                final x = dataGetPackage.data!.package!.note;
                idPackage = dataGetPackage.data!.package!.id;
                print('idp' +idPackage.toString());
                motifIdPackage = dataGetPackage.data!.package!.motif!.id;
                sizeIdPackage = dataGetPackage.data!.package!.size!.id;
                productIdPackage = dataGetPackage.data!.package!.product!.id;

                // print(x);
                final priceProduct = dataGetPackage.data!.package!.product!.price; 
                final priceMotif = dataGetPackage.data!.package!.motif!.price;
                totalPrice = (priceProduct!) + (priceMotif!);
                if(isFirst == true){
                  print('sasa');
                  isFirst = false;
                  _totalPrice = (priceProduct) + (priceMotif);
                  if(_valueDelivery == 1){
                    priceDelivery = _jnt;
                  }else{
                    priceDelivery = _jne;
                  }
                  _totalAllPrice = _totalPrice! + priceDelivery!;
                }
                // print(totalPrice);
                // print(snapshot);
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  // color: ColorsConstant.cardBg,
                                  color: ColorsConstant.cardBg,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                width: width * 0.3,
                                height: 100,
                                child: Image(
                                  width:70,
                                  height:70,
                                  image: NetworkImage(
                                    'http://34.101.126.151:8008/img/product/' + dataGetPackage.data!.package!.product!.id.toString() + '-' + dataGetPackage.data!.package!.product!.image.toString()
                                  )
                                ),
                              ),
                              SizedBox(width: 15,),
                              Container(
                                width: width*0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      maxLines: 2,
                                      // '',
                                      // snapshot.data!.package!.product!.name.toString(),
                                      dataGetPackage.data!.package!.product!.name.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(
                                      'Motif : ' +dataGetPackage.data!.package!.motif!.name.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: ColorsConstant.secondaryText
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp '+ totalPrice.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: _minCounter,
                                              child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width:7),
                                            Text(
                                              '$_counter',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            SizedBox(width:7),
                                            GestureDetector(
                                              onTap: _addCounter,
                                              child: Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Pengiriman',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.all(15),
                        color: ColorsConstant.cardBg,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alamat',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: _addressController,
                              validator: (value) {
                                if(value == null || value.isEmpty)
                                {
                                  return 'FIeld Tidak Boleh Kosong';
                                }
                                return null;
                              },
                              maxLines: 2,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: ColorsConstant.primaryText,
                              decoration: const InputDecoration(
                                hintText: 'Masukkan Alamat',
                                hintStyle: TextStyle(
                                    fontFamily: 'poppins'
                                ),
                                // alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                )
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'Opsi Pengiriman',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            DropdownButtonFormField (
                              validator: (value) {
                                if(value == null)
                                {
                                  return 'FIeld Tidak Boleh Kosong';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                contentPadding: const EdgeInsets.only(left:15),
                              ),
                              value: _valueDelivery,
                              onChanged: (int? value) {
                                setState(() {
                                  _valueDelivery = value!;
                                  print('text');
                                  print(_valueDelivery);
                                  // var priceDelivery = 0;
                                  if(_valueDelivery == 1){
                                    priceDelivery = _jnt;
                                  }else{
                                    priceDelivery = _jne;
                                  }
                                  _totalAllPrice = _totalPrice! + priceDelivery!;
                                });
                              },
                              items: <DropdownMenuItem<int>>[
                                new DropdownMenuItem(
                                  child: new Text('JNT - 40.000'),
                                  value: 1,
                                ),
                                new DropdownMenuItem(
                                  child: new Text('JNE - 60.000'),
                                  value: 2,
                                ),]
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Metode Pembayaran',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      DropdownButtonFormField (
                        validator: (value) {
                          if(value == null)
                          {
                            return 'FIeld Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          contentPadding: const EdgeInsets.only(left:15),
                        ),
                        // value: widget.usermodel.sex!,
                        onChanged: (int? value) {
                          setState(() {
                            _valueMethode = value!;
                          });
                        },
                        items: <DropdownMenuItem<int>>[
                          new DropdownMenuItem(
                            child: new Text('Payment Gateway'),
                            value: 1,
                          ),
                        ]
                      ),
                      // ButtonGlobal(label: 'Metode Pembayaran',),
                      SizedBox(height: 20,),
                      Text(
                        'Tinggalkan Pesan',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        validator: (value) {
                          if(value == null || value.isEmpty)
                          {
                            return 'FIeld Tidak Boleh Kosong';
                          }
                          return null;
                        },
                        controller: _messageController,
                        maxLines: 4,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: ColorsConstant.primaryText,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Pesan',
                          hintStyle: TextStyle(
                              fontFamily: 'poppins'
                          ),
                          // alignLabelWithHint: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        'Rincian Pembayaran',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      SizedBox(height: 5,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Harga',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                'Rp ' + _totalPrice.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Ongkir',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                priceDelivery.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5,),
                          SizedBox(height: 5,),
                          Container(
                            width: width,
                            height: 2,
                            decoration: BoxDecoration(
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Pembayaran',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                              Text(
                                'Rp ' + _totalAllPrice.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      
                    ],
                  ),
                );
              }
              else if (snapshot.hasError) {
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
        ),
      ),
    );
  }

  Container BottomNav(double width, BuildContext context) {
    return Container(
      width: width,
      height: 100,
      color: ColorsConstant.greenColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Metode Pembayaran',
            //   style: GoogleFonts.poppins(
            //     fontSize: 16,
            //     color: Colors.white,
            //     fontWeight: FontWeight.w400
            //   ),
            // ),
            // SizedBox(height: 5,),
            // Row(
            //   children: [
            //     Image.asset('assets/metode.png'),
            //     SizedBox(width: 15,),
            //     Text(
            //       'COD',
            //       style: GoogleFonts.poppins(
            //         fontSize: 16,
            //         color: Colors.white,
            //         fontWeight: FontWeight.w400
            //       ),
            //     )
            //   ],
            // ),
            
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () async{
                if (_formKey.currentState!.validate()) {
                  
                  final PackageModelV3  resputPackage = await _authServices.putPackageById(
                    address: _addressController.text,
                    note: _messageController.text,
                    id: idPackage,
                    motif_id: motifIdPackage,
                    size_id: sizeIdPackage,
                    product_id: productIdPackage,
                    method_id: _valueMethode,
                    shipping_id: _valueDelivery
                  );
                  print(resputPackage.data!.package1!.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InvoiceScreen(
                      counter: _counter,
                      priceDelivery: priceDelivery,
                      totalPrice: _totalPrice,
                      totalAllPrice: _totalAllPrice,
                      idPackage: resputPackage.data!.package1!.id,
                    )),
                  );
                  Fluttertoast.showToast(
                      msg: 'Berhasil Melakukan pesanan. Silahkan lanjutkan pembayaran',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                  );
                  // print('log');
                  // print(_valueDelivery);
                  // print('log2');
                  // print(_valueMethode);
                  // print('idp' +idPackage.toString());
                  // print(motifIdPackage);
                  // print(sizeIdPackage);
                  // print(productIdPackage);
                }
              },
              child: Container(
                height: 64,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorsConstant.greenColor,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}