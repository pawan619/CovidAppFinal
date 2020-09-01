import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../size_config.dart';

class CustomBTN extends StatelessWidget {
  // Custom Colors
  static const Color trainColor = Color(0xff00bcd4);

  // Variable for Buttons
  final String text;
  final Color color;
  final Color textColor;
  final double minWidth;
  final double height;
  final double elevation;
  final VoidCallback onPressed;
  final ShapeBorder shape;

  // Button Constructor
  CustomBTN({
    Key key,
    this.text,
    this.color: trainColor,
    this.textColor: Colors.white,
    this.minWidth,
    this.height,
    this.elevation: 5.0,
    @required this.onPressed,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: SizeConfig.textMultiplier * 2.2),
      ),
      textColor: textColor,
      color: color,
      minWidth: minWidth,
      height: height,
      elevation: elevation,
      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
      shape: shape,
    );
  }
}
