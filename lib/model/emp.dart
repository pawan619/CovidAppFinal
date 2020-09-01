import 'package:flutter/material.dart';

class Emp {
  Emp(
      {@required this.id,
      @required this.name,
      @required this.temp,
      @required this.depart,
      @required this.mask});
  final String id, name, depart, mask;
  final double temp;

  Map<String, dynamic> toMap() {
    return {
      'emp_id': id,
      'emp_name': name,
      'emp_temp': temp,
      'emp_depart': depart,
      'emp_mask': mask,
    };
  }
}
