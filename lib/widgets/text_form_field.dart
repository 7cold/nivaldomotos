import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nivaldomotos/constants/colors.dart';
import 'package:nivaldomotos/constants/fonts.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final Function onSubmited;
  final Function onChanged;
  final TextInputType keyboardType;
  final String hintText;
  final IconData icon;
  final TextStyle textStyle;
  final bool obscure;
  final bool border;
  final TextCapitalization textCapitalization;

  TextInput({
    @required this.controller,
    @required this.validator,
    @required this.keyboardType,
    @required this.hintText,
    @required this.icon,
    @required this.textStyle,
    @required this.obscure,
    @required this.textCapitalization,
    this.onSubmited,
    this.onChanged,
    @required this.border,
  });
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      shadowColor: Color(accentColor).withOpacity(0.22),
      borderRadius: BorderRadius.circular(8),
      child: TextFormField(
        textCapitalization: textCapitalization,
        onFieldSubmitted: onSubmited,
        obscureText: obscure,
        style: textStyle,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        cursorColor: Color(accentColor),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 15, top: 12),
            child: FaIcon(
              icon,
              size: 20,
              color: Colors.grey,
            ),
          ),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: fontBold),
          fillColor: Colors.white,
          errorStyle: signUpErrorStyle,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(primaryColor), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: border == true ? Color(accentColor) : Colors.transparent,
                width: 1),
          ),
        ),
      ),
    );
  }
}
