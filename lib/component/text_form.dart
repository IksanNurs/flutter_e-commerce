import 'package:flutter/material.dart';

import '../utils/colors_constant.dart';

class TextFormFields extends StatelessWidget {
  const TextFormFields({super.key, required this.controller,});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            cursorColor: ColorsConstant.primaryText,
            validator: (value) {
              if(value == null || value.isEmpty)
              {
                return 'FIeld Tidak Boleh Kosong';
              }
              return null;
            } ,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                  fontFamily: 'poppins'
              ),
              // alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
              )
            ),
          )
        ],
      ),
      // controller: controller,
      // keyType: TextInput.keyType,
    );
  }
}