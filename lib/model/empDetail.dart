import 'package:flutter/material.dart';

class EmpDetail {
  EmpDetail({@required this.temp, @required this.mask, @required this.date});
  final String mask, date;
  final double temp;

  Map<String, dynamic> toMap() {
    return {
      'emp_temp': temp,
      'emp_mask': mask,
      'emp_date': date,
    };
  }
}
