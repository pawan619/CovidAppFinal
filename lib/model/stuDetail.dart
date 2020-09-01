import 'package:flutter/material.dart';

class StuDetail {
  StuDetail({@required this.temp, @required this.mask, @required this.date});
  final String mask, date;
  final double temp;

  Map<String, dynamic> toMap() {
    return {
      's_temp': temp,
      's_mask': mask,
      's_date': date,
    };
  }
}
