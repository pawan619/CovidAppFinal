import 'package:flutter/material.dart';
import 'package:covidCare/model/emp.dart';

class EmpList extends StatelessWidget {
  const EmpList({Key key, @required this.emp, @required this.onTap})
      : super(key: key);
  final Emp emp;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle, size: 46),
      title: Text(emp.name + "                   Temp:  ${emp.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(emp.depart.toString(), style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
