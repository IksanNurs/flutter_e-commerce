import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:showroom_app/auth/register.dart';
import 'package:showroom_app/component/button_global.dart';
import 'package:showroom_app/screens/main_screen.dart';
import 'package:showroom_app/screens/main_screen_owner.dart';
import 'package:showroom_app/utils/colors_constant.dart';
import '../component/text_form.dart';
import '../component/text_label.dart';
import '../models/ResponseModel.dart';
import '../services/auth_services.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  
  Future<ResponseModel>? _futureLogin;
  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (_futureLogin == null) ? loginScreen(context) : builderLogin());
  }

  Padding loginScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Masuk',
                  style: GoogleFonts.poppins(
                      fontSize: 26, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 24),
                TextLabel(
                  label: 'Email',
                ),
                SizedBox(height: 8),
                TextFormFields(controller: _emailController),
                SizedBox(
                  height: 10,
                ),
                TextLabel(
                  label: 'Kata Sandi',
                ),
                SizedBox(height: 8),
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
                                )),
                      // alignLabelWithHint: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Lupa Kata Sandi?',
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () async
                      // {
                      //   Navigator.push(
                      //     context,
                      //       MaterialPageRoute(builder: (context) => MainScreen()
                      //     ),
                      //   );
                      // },
                      {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _futureLogin = AuthServices.login(
                            email: _emailController.text,
                            password_hash: _passController.text);
                      });
                    }
                  },
                  child: ButtonGlobal(
                    label: 'Masuk',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum punya akun?',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: ColorsConstant.primaryText,
                          fontWeight: FontWeight.w600),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        ' Daftar',
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w700),
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

  FutureBuilder<ResponseModel> builderLogin() {
    return FutureBuilder<ResponseModel>(
      future: _futureLogin,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.status != 200) {
            Fluttertoast.showToast(
                msg: snapshot.data!.message.toString(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            return Login();
          } else {
            if (snapshot.data!.issales == 1) {
              Fluttertoast.showToast(
                  msg: snapshot.data!.message.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
              return MainScreenOwner();
            } else {
              Fluttertoast.showToast(
                  msg: snapshot.data!.message.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1);
              return MainScreen();
            }
          }
        } else if (snapshot.hasError) {
          return Text('Terjadi Kesalahan');
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }
}
