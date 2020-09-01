import 'package:flutter/material.dart';
import 'package:covidCare/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/DataList/empList.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:covidCare/screens/EmpDetailScreen.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
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
    return StreamBuilder<List<Emp>>(
      stream: database.empStream(),
      builder: (context, snapshot) {
        return ListItemsBuilder<Emp>(
            snapshot: snapshot,
            itemBuilder: (context, emp) => EmpList(
                  emp: emp,
                  onTap: () => EmpDetailScreen.show(context, emp,
                      database: Provider.of<Database>(context)),
                ));
      },
    );
  }

  void togglePass() {
    setState(() {
      print("Hello");
    });
  }
}
