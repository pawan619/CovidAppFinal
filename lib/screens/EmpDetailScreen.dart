import 'package:covidCare/model/empDetail.dart';
import 'package:flutter/material.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/DataList/empDetailList.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/widgets/list_item_builder.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Detail Data'),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: _buildContents(context, widget.emp),
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

    //final database = Provider.of<Database>(context);
  }
}
