import 'package:flutter/material.dart';
import '../size_config.dart';
// import '../shared/styling.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final VoidCallback onEditingComplete;
  final FormFieldSetter<String> onSaved;
  final GestureTapCallback onTap;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool isEmail;
  final bool isPassword;
  final bool obscureText;
  final int maxLength;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final bool autoValidate;
  final bool isDense;

  MyTextFormField(
      {Key key,
      this.labelText,
      this.hintText,
      this.onChanged,
      this.onFieldSubmitted,
      this.onEditingComplete,
      this.onSaved,
      this.onTap,
      this.controller,
      this.isEmail,
      this.isPassword,
      this.validator,
      this.keyboardType,
      this.obscureText: false,
      this.maxLength,
      this.focusNode,
      this.decoration,
      this.prefixIcon,
      this.suffixIcon,
      this.autoValidate: false,
      this.isDense})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: isDense,
        labelStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: SizeConfig.textMultiplier * 2.2),
        hintStyle: TextStyle(
            fontFamily: "Montserrat",
            fontSize: SizeConfig.textMultiplier * 2.2),
        contentPadding: EdgeInsets.all(SizeConfig.heightMultiplier * 1),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey[400])),
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      onFieldSubmitted: onFieldSubmitted,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      focusNode: focusNode,
      autovalidate: autoValidate,
    );
  }
}
