import 'package:covidCare/model/stuDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StuDetailList extends StatelessWidget {
  const StuDetailList({Key key, @required this.stuDetail, @required this.onTap})
      : super(key: key);
  final StuDetail stuDetail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "Date:  ${stuDetail.date}                    Temp:  ${stuDetail.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(stuDetail.mask.toString(), style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}
