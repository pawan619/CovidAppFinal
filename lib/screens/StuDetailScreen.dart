import 'package:covidCare/model/stuDetail.dart';
import 'package:covidCare/model/stu.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/DataList/stuDetailList.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:covidCare/screens/StuDetailScreen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail Data'),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: _buildContents(context, widget.stu),
    );
  }

  Widget _card() {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        height: 220,
        width: double.maxFinite,
        child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: 80.0,
                    ),
                    title: Text(
                      'Sam                                         Teaching',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                    subtitle: Text(
                      'Mob No: 9988774545     Email: Sam@gmail.com',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
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
