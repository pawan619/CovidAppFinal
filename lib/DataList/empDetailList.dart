import 'package:covidCare/model/empDetail.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/model/emp.dart';

class EmpDetailList extends StatelessWidget {
  const EmpDetailList({Key key, @required this.empDetail, @required this.onTap})
      : super(key: key);
  final EmpDetail empDetail;
  final VoidCallback onTap;

  @override
  /* Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "Date:  ${empDetail.date}                    Temp:  ${empDetail.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(empDetail.mask.toString(), style: TextStyle(fontSize: 16)),
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
            // Icon(Icons.account_circle, color: Colors.grey, size: 60),
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
          Text(empDetail.date,
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          SizedBox(width: 15.0),
          if (empDetail.temp < 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              empDetail.temp.toString() + " .c",
              style: TextStyle(fontSize: 18.0, color: Colors.green[700]),
            ),
          ],
          if (empDetail.temp > 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              empDetail.temp.toString() + " .c",
              style: TextStyle(fontSize: 18.0, color: Colors.red[700]),
            ),
          ],
        ]),
        Row(children: <Widget>[
          SizedBox(height: 20.0),
          SizedBox(width: 10.0),
          Text(empDetail.mask, style: TextStyle(fontSize: 16.0)),
        ]),
      ],
    );
  }
}
