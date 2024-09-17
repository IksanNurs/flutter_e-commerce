import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/button_global.dart';
import '../component/text_form.dart';
import '../component/text_label.dart';
import '../models/ResponseModel.dart';
import '../models/ResponseModel2.dart';
import '../screens/main_screen.dart';
import '../services/auth_services.dart';
import '../utils/colors_constant.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();


  bool obsecurePass = true;
  Future<ResponseModel2>? _futureRegister;
  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body:  (_futureRegister == null) ? registerScreen(context) : builderRegister()
    );
  }

  Padding registerScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34,vertical:20),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daftar',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height:24),
                TextLabel(
                  label: 'Username',
                ),
                SizedBox(height:8),
                TextFormFields(controller: _nameController),
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
                SizedBox(height:10),
                TextLabel(
                  label: 'Password',
                ),
                SizedBox(height:8),
                TextFormField(
                  validator: (value) {
                    if(value == null || value.isEmpty)
                    {
                      return 'Field Tidak Boleh Kosong';
                    }
                    return null;
                  } ,
                  controller: _passController,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: ColorsConstant.primaryText,
                  obscureText: obsecurePass,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.black38,
                        )
                      : const Icon(
                          Icons.visibility_outlined,
                          color: Colors.blue,
                        )
                    ),
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins'
                    ),
                    // alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
                SizedBox(height:50),
                GestureDetector(
                  onTap: () async
                  {
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        _futureRegister = AuthServices.register(
                            email: _emailController.text,
                            phone: _phoneController.text,
                            name: _nameController.text,
                            password_hash: _passController.text);
                      });
                    }
                  },
                  child: ButtonGlobal(
                    label: 'Daftar',
                  ),
                ),
                SizedBox(height:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah punya akun?',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: ColorsConstant.primaryText,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        ' Login',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<ResponseModel2> builderRegister() {
    return FutureBuilder<ResponseModel2>(
      future: _futureRegister,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.status != 200) {
            Fluttertoast.showToast(
                msg: snapshot.data!.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
            );
            return Register();
          }
          else {
            Fluttertoast.showToast(
                msg: snapshot.data!.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
            );
            return MainScreen();
          }
        } else if (snapshot.hasError) {
          return Text('Terjadi Kesalahan');
        }

        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}