import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/button_global.dart';
import '../../component/text_form.dart';
import '../../component/text_label.dart';
import '../../models/UserModel.dart';
import '../../services/auth_services.dart';
import '../../utils/colors_constant.dart';
import '../main_screen_owner.dart';

class ProfileScreenOwner extends StatefulWidget {
  const ProfileScreenOwner({super.key});

  @override
  State<ProfileScreenOwner> createState() => _ProfileScreenOwnerState();
}

class _ProfileScreenOwnerState extends State<ProfileScreenOwner> {
  Future<UserModel>? _futureUser2;
  AuthServices serviceAPI = AuthServices();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    _futureUser2 = serviceAPI.getUserSelf();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel>(
          future: _futureUser2,
          builder: (context, snapshot) {
            if (snapshot.hasData){
              UserModel dataProfile = snapshot.data!;
              var _emailController = TextEditingController(text: dataProfile.email);
              var _phoneController = TextEditingController(text: dataProfile.phone);
              var _nameController = TextEditingController(text: dataProfile.name);
              return Column(
                children: [
                  Center(
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 100.0,
                    ),
                  ),
                  SizedBox(height:8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextLabel(
                            label: 'Nama',
                          ),
                          SizedBox(height:8),
                          TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            cursorColor: ColorsConstant.primaryText,
                            validator: (value) {
                              if(value == null || value.isEmpty)
                              {
                                return 'Field Tidak Boleh Kosong';
                              }
                              return null;
                            } ,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  fontFamily: 'poppins'
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))
                              )
                            ),
                          ),
                          // TextFormFields(controller: _nameController),
                          SizedBox(height:10),
                          TextLabel(
                            label: 'Email',
                          ),
                          SizedBox(height:8),
                          TextFormFields(controller: _emailController),
                          SizedBox(height:10),
                          TextLabel(
                            label: 'No HP / WA',
                          ),
                          SizedBox(height:8),
                          TextFormFields(controller: _phoneController),
                          SizedBox(height:30),
                          GestureDetector(
                            onTap: () async{
                              if (_formKey.currentState!.validate()) {
                                var res = await serviceAPI.putUserSelf(
                                  email: _emailController.text,
                                  name: _nameController.text,
                                  phone: _phoneController.text
                                );
                                setState(() {
                                  Navigator.pushNamed(
                                    context,
                                    '/main-owner',
                                  );
                                  Fluttertoast.showToast(
                                    msg: 'Berhasil mengubah profile',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                  );
                                });
                                
                              }
                            },
                            child: ButtonGlobal(
                              label: 'Save Profile',
                            ),
                          ),
                          SizedBox(height:10),
                          OutlinedButton(
                            onPressed: ()async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.clear();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const Login()),
                              // );
                              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route route) => false);
                              // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              // Login()), (Route route) => false);
                            }, 
                            style: OutlinedButton.styleFrom(
                              fixedSize: Size(width, 54),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              side: BorderSide(color: ColorsConstant.greenColor, width: 2)
                            ),
                            child: Text(
                              'Logout',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ColorsConstant.greenColor
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
                  )
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