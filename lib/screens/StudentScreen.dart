import 'package:flutter/material.dart';
import 'package:covidCare/model/stu.dart';
import 'package:covidCare/DataList/stuList.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:covidCare/screens/StuDetailScreen.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildContents(context),
      /* Center(
        child: Text("Employee Screen"),
      ),*/
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Stu>>(
      stream: database.stuStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Stu>(
            snapshot: snapshot,
            itemBuilder: (context, stu) => StuList(
                  stu: stu,
                  onTap: () => StuDetailScreen.show(context, stu,
                      database: Provider.of<Database>(context)),
                ));
      },
    );
  }
}
