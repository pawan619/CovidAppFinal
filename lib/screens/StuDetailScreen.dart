import 'package:covidCare/model/stuDetail.dart';
import 'package:covidCare/model/stu.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/DataList/stuDetailList.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:covidCare/screens/StuDetailScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidCare/ColorClass.dart';
import 'package:covidCare/size_config.dart';

class StuDetailScreen extends StatefulWidget {
  const StuDetailScreen({@required this.database, @required this.stu});
  final Database database;
  final Stu stu;

  static Future<void> show(BuildContext context, Stu stu,
      {Database database}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => StuDetailScreen(database: database, stu: stu),
      ),
    );
  }

  @override
  _StuDetailScreenState createState() => _StuDetailScreenState();
}

class _StuDetailScreenState extends State<StuDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        backgroundColor: greyColor2,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Student Details",
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
                  child: _card(widget.stu),
                ),
                Container(
                  height: 400,
                  color: Colors.white,
                  child: _buildContents(context, widget.stu),
                ),
              ],
            ),
          )),
    );

    /* return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail Data'),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
     body: _buildContents(context, widget.stu),
    );*/
  }

  Widget _card(Stu stu) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        height: 220,
        width: double.maxFinite,
        child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Row(children: <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 80.0,
                ),
                SizedBox(width: 5.0),
                // Container(
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Column(children: <Widget>[
                    Text(stu.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    SizedBox(height: 1.0),
                    Text("Depart: " + stu.depart,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    Text("Email: " + stu.email,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                    SizedBox(height: 1.0),
                    Text("Phone no: " + stu.phone.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16.0, color: Colors.black)),
                  ],
                ),
              ]),
            )));
  }

  Widget _buildContents(BuildContext context, Stu stu) {
    return StreamBuilder<List<StuDetail>>(
      stream: widget.database.stuDetailStream(stu: stu),
      builder: (context, snapshot) {
        return Container(
          child: ListItemsBuilder<StuDetail>(
              snapshot: snapshot,
              itemBuilder: (context, stuDetail) => StuDetailList(
                    stuDetail: stuDetail,
                    onTap: () {},
                  )),
        );
      },
    );

    //final database = Provider.of<Database>(context);
  }
}
