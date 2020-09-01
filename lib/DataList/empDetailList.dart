import 'package:covidCare/model/empDetail.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/model/emp.dart';

class EmpDetailList extends StatelessWidget {
  const EmpDetailList({Key key, @required this.empDetail, @required this.onTap})
      : super(key: key);
  final EmpDetail empDetail;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "Date:  ${empDetail.date}                    Temp:  ${empDetail.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(empDetail.mask.toString(), style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
