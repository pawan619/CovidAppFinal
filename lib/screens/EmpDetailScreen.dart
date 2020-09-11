import 'package:covidCare/model/empDetail.dart';
import 'package:covidCare/size_config.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/DataList/empDetailList.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidCare/ColorClass.dart';

class EmpDetailScreen extends StatefulWidget {
  const EmpDetailScreen({@required this.database, @required this.emp});
  final Database database;
  final Emp emp;

  static Future<void> show(BuildContext context, Emp emp,
      {Database database}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => EmpDetailScreen(database: database, emp: emp),
      ),
    );
  }

  @override
  _EmpDetailScreenState createState() => _EmpDetailScreenState();
}

class _EmpDetailScreenState extends State<EmpDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        backgroundColor: greyColor2,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Employee Details",
              style: GoogleFonts.poppins(),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[primaryColor, secondaryColor])),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
                  color: Colors.white,
                  child: _card(widget.emp),
                ),
                Container(
                  height: 400,
                  color: Colors.white,
                  child: _buildContents(context, widget.emp),
                ),
              ],
            ),
          )),
    );
  }

  Widget _card(Emp emp) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        height: 220,
        width: double.maxFinite,
        child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Row(children: <Widget>[
                new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                              emp.img,
                            )))),
                SizedBox(width: 10.0),
                // Container(
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Column(children: <Widget>[
                    Text(emp.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    SizedBox(height: 1.0),
                    Text("Depart: " + emp.depart,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    Text("Email: " + emp.email,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    SizedBox(height: 1.0),
                    Text("Phone no: " + emp.phone.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                  ],
                ),
              ]),
            )));
  }

  Widget _buildContents(BuildContext context, Emp emp) {
    return StreamBuilder<List<EmpDetail>>(
      stream: widget.database.empDetailStream(emp: emp),
      builder: (context, snapshot) {
        return Container(
          child: ListItemsBuilder<EmpDetail>(
              snapshot: snapshot,
              itemBuilder: (context, empDetail) => EmpDetailList(
                    empDetail: empDetail,
                    onTap: () {},
                  )),
        );
      },
    );
  }
}
