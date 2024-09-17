import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/screens/profile_screen.dart';

import '../component/text_label.dart';
import '../models/UserModel.dart';
import '../services/auth_services.dart';
import '../utils/colors_constant.dart';
class ProfileScreenV2 extends StatefulWidget {
  const ProfileScreenV2({super.key});

  @override
  State<ProfileScreenV2> createState() => _ProfileScreenV2State();
}

class _ProfileScreenV2State extends State<ProfileScreenV2> with TickerProviderStateMixin{
  late final TabController _tabController;
  Future<UserModel>? _futureUser;
  AuthServices serviceAPI = AuthServices();
  
  void initState() {
    // TODO: implement initState
    _futureUser = serviceAPI.getUserSelf();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  } 
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
          'Akun',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData){
                UserModel dataProfile = snapshot.data!;
                return Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.account_circle_outlined,
                            size: 100.0,
                          ),
                          TextLabel(label: dataProfile.name.toString(),),
                          Text(
                            dataProfile.email.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorsConstant.secondaryText
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                                );
                              });
                            },
                            child: Text(
                              'Lihat profile',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorsConstant.greenColor
                              ),
                            ),
                          ),
                          SizedBox(height:20),
                          TabBar(
                            labelColor: Colors.black,
                            controller: _tabController,
                            tabs: <Widget>[
                              Tab(
                                text: 'Proses',
                                icon: Icon(
                                  Icons.flight,
                                ),
                              ),
                              Tab(
                                text: 'Pengiriman',
                                icon: Icon(
                                  Icons.luggage
                                ),
                              ),
                              Tab(
                                text: 'Penilaian',
                                icon: Icon(Icons.explore),
                              ),
                            ],
                          ),
                          
                        ],
                      ),
                    ),
                    SizedBox(height:8),
                    
                  ],
                );
              
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
      ),
    );
  }
}