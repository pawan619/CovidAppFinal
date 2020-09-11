import 'package:flutter/material.dart';

class Emp {
  Emp({
    @required this.id,
    @required this.name,
    @required this.temp,
    @required this.depart,
    @required this.mask,
    @required this.img,
    @required this.phone,
    @required this.email,
  });
  final String id, name, depart, mask, img, email;
  final double temp;
  final int phone;

  Map<String, dynamic> toMap() {
    return {
      'emp_id': id,
      'emp_name': name,
      'emp_temp': temp,
      'emp_depart': depart,
      'emp_mask': mask,
      'emp_img': img,
      'emp_email': email,
      'emp_phone': phone,
    };
  }
}
