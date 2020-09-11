import 'package:flutter/material.dart';

class Stu {
  Stu(
      {@required this.id,
      @required this.name,
      @required this.temp,
      @required this.depart,
      @required this.mask,
      @required this.phone,
      @required this.email,@required this.img,});
  final String id, name, depart, mask, email,img;
  final double temp;
  final int phone;

  Map<String, dynamic> toMap() {
    return {
      's_id': id,
      's_name': name,
      's_temp': temp,
      's_depart': depart,
      's_mask': mask,
      's_email': email,
      's_phone': phone,
      's_img':img,
    };
  }
}
