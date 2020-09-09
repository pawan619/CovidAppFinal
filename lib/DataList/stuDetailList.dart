import 'package:covidCare/model/stuDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StuDetailList extends StatelessWidget {
  const StuDetailList({Key key, @required this.stuDetail, @required this.onTap})
      : super(key: key);
  final StuDetail stuDetail;
  final VoidCallback onTap;

  @override
  /*Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          "Date:  ${stuDetail.date}                    Temp:  ${stuDetail.temp}.c",
          style: TextStyle(fontSize: 16)),
      subtitle: Text(stuDetail.mask.toString(), style: TextStyle(fontSize: 16)),
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
          Text(stuDetail.date,
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          SizedBox(width: 15.0),
          if (stuDetail.temp < 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              stuDetail.temp.toString() + " .c",
              style: TextStyle(fontSize: 18.0, color: Colors.green[700]),
            ),
          ],
          if (stuDetail.temp > 100.0) ...<Widget>[
            Expanded(child: Container()),
            Text(
              stuDetail.temp.toString() + " .c",
              style: TextStyle(fontSize: 18.0, color: Colors.red[700]),
            ),
          ],
        ]),
        Row(children: <Widget>[
          SizedBox(height: 20.0),
          SizedBox(width: 10.0),
          Text(stuDetail.mask, style: TextStyle(fontSize: 16.0)),
        ]),
      ],
    );
  }
}
