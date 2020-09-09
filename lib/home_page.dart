/*import 'package:covidCare/Emps/empList.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/services/auth.dart';
import 'package:covidCare/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/widgets/platform_alert_dialog.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Future<void> _createEmp(BuildContext context) async {
    final database = Provider.of<Database>(context);
    await database.createEmp(Emp(
        name: 'Bob', temp: 80.2, depart: 'Non-Teaching', mask: 'with Mask'));
  }

  @override
  Widget build(BuildContext context) {
    /*final database = Provider.of<Database>(context);
    database.empStream();*/

    return Scaffold(
      appBar: AppBar(
        title: Text('Covid Care'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      body: _buildContents(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createEmp(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Emp>>(
      stream: database.empStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final emps = snapshot.data;
          final children = emps
              .map((emp) => EmpList(
                    emp: emp,
                    onTap: () {},
                  ))
              .toList();
          return ListView(children: children);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}*/

import 'package:covidCare/screens/EmployeeScreen.dart';
import 'package:covidCare/screens/StudentScreen.dart';
import 'package:covidCare/screens/search.dart';
import 'package:covidCare/size_config.dart';
import 'package:covidCare/widgets/MyTextFormField_c.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorClass.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/widgets/platform_alert_dialog.dart';
import 'package:covidCare/services/auth.dart';
import 'package:covidCare/services/database.dart';

class HomePage extends StatefulWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final database = Provider.of<Database>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _myAppBar(),
        body: TabBarView(children: [
          EmployeeScreen(),
          StudentScreen(),
        ]),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: () => SearchData.show(context,
              database: Provider.of<Database>(context)),
        ),
      ),
    );
  }

  // Custom AppBar
  Widget _myAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConfig.screenHeight / 4),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new,
                color: signUpColor, size: SizeConfig.imageSizeMultiplier * 7),
            onPressed: () => widget._confirmSignOut(context),
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.filter_list,
            color: homeBtnColor,
            size: SizeConfig.imageSizeMultiplier * 7,
          ),
          onPressed: () {},
        ),
        bottom: TabBar(
            indicatorColor: homeBtnColor,
            labelColor: homeBtnColor,
            labelStyle: GoogleFonts.nunito(),
            unselectedLabelColor: greyColor,
            tabs: [
              Tab(
                text: "Employees",
                icon: ImageIcon(AssetImage("assets/images/employeeWhite.png"),
                    size: SizeConfig.imageSizeMultiplier * 8),
              ),
              Tab(
                text: "Students",
                icon: ImageIcon(
                  AssetImage("assets/images/studentWhite.png"),
                  size: SizeConfig.imageSizeMultiplier * 8,
                ),
              ),
            ]),
        title: Image.asset(
          "assets/images/ccLogo.png",
          height: SizeConfig.imageSizeMultiplier * 10,
          // width: 40.0,
        ),
      ),
    );
  }

  Widget searchBar() {
    return MyTextFormField(
      labelText: "Search",
    );
  }
}
