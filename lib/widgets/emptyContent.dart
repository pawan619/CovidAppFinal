import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({Key key, this.title = 'Data Not Found', this.message})
      : super(key: key);
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 32.0, color: Colors.black54),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
