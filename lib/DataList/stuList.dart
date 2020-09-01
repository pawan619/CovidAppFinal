import 'package:flutter/material.dart';
import 'package:covidCare/model/stu.dart';

class StuList extends StatelessWidget {
  const StuList({Key key, @required this.stu, @required this.onTap})
      : super(key: key);
  final Stu stu;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle, size: 46),
      title: Text(stu.name + "                   Temp:  ${stu.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(stu.depart.toString(), style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
