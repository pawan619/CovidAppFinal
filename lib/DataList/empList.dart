import 'package:flutter/material.dart';
import 'package:covidCare/model/emp.dart';

class EmpList extends StatelessWidget {
  const EmpList({Key key, @required this.emp, @required this.onTap})
      : super(key: key);
  final Emp emp;
  final VoidCallback onTap;

  @override
  /*Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.account_circle, size: 46),
      title: Text(emp.name + "                   Temp:  ${emp.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(emp.depart.toString(), style: TextStyle(fontSize: 16)),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }*/

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.account_circle, color: Colors.grey, size: 60),
            Expanded(
              child: _buildContents(context),
            ),
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          SizedBox(width: 10.0),
          Text(emp.name, style: TextStyle(fontSize: 18.0, color: Colors.black)),
          SizedBox(width: 15.0),
          if (emp.temp < 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              emp.temp.toString() + " .c",
              style: TextStyle(fontSize: 16.0, color: Colors.green[700]),
            ),
          ],
          if (emp.temp > 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              emp.temp.toString() + " .c",
              style: TextStyle(fontSize: 16.0, color: Colors.red[700]),
            ),
          ],
        ]),
        Row(children: <Widget>[
          SizedBox(width: 10.0),
          Text(emp.depart, style: TextStyle(fontSize: 16.0)),
          Expanded(child: Container()),
          Text(emp.mask, style: TextStyle(fontSize: 16.0)),
        ]),
      ],
    );
  }
}
