import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/payment_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/OrderModel.dart';
import '../models/PackageModelV4.dart';
import '../services/auth_services.dart';
import '../utils/colors_constant.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key, required this.idPackage, required this.counter, required this.totalPrice, required this.totalAllPrice, required this.priceDelivery});
  final int? idPackage;
  final int? counter;
  final int? totalPrice;
  final int? totalAllPrice;
  final int? priceDelivery;


  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final AuthServices _authServices = AuthServices();
  Future<PackageModelV4>?  _futureGetPackage;

  void initState() {
    super.initState();
    _futureGetPackage = _authServices.getPackageById(widget.idPackage!);
    print(_futureGetPackage);
    _counter = widget.counter;
    _totalPrice = widget.totalPrice;
    _totalAllPrice = widget.totalAllPrice;
    _priceDelivery = widget.priceDelivery;

  }

  String? nameProduct ='';
  String? address ='';
  String? motif ='';
  int? _counter;
  int? _totalPrice;
  int? _totalAllPrice;
  int? _priceDelivery;
  int? package_id;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Invoice Pesanan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical:15),
          child: FutureBuilder<PackageModelV4>(
            future: _futureGetPackage,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                PackageModelV4? dataGetPackage = snapshot.data!;
                nameProduct = dataGetPackage.data!.package!.product!.name;
                address = dataGetPackage.data!.package!.address;
                motif = dataGetPackage.data!.package!.motif!.name;
                package_id = dataGetPackage.data!.package!.id;
                print(dataGetPackage.data!.package!.id);
                return Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: ColorsConstant.cardBg,
                    borderRadius: BorderRadius.all(Radius.circular(15),)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Produk',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          nameProduct.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Motif : ' + motif.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Alamat Pengiriman : ',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          address.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Jumlah',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                               _counter.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Harga Barang',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Rp ' +_totalPrice.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ongkir Barang',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Rp ' +_priceDelivery.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Harga',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Text(
                              'Rp ' +_totalAllPrice.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  )
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
        )
      ),
      bottomNavigationBar: BottomNav(width, context),
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
            SizedBox(height: 5,),
            GestureDetector(
              onTap: () async{
                final OrderMordel resPostOrder = await _authServices.postOrder(
                  package_id,
                  _totalAllPrice
                );
                print('mid');
                final midTrans = resPostOrder.data!.midtransPaymentUrl;
                print(midTrans);
                Fluttertoast.showToast(
                    msg: resPostOrder.message.toString(),
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentScreen(
                    linkMidtrans: midTrans,
                  )),
                );
                
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
                    'Bayar',
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