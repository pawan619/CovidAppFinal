/*import 'package:covidCare/screens/EmployeeScreen.dart';
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
}*/

import 'package:covidCare/screens/EmployeeScreen.dart';
import 'package:covidCare/screens/StudentScreen.dart';
import 'package:covidCare/services/auth.dart';
import 'package:covidCare/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ColorClass.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/widgets/platform_alert_dialog.dart';
import 'package:covidCare/services/database.dart';
import 'package:covidCare/screens/search.dart';

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
  Icon searchIcon = Icon(
    Icons.search,
    color: Colors.grey,
  );
  Widget appLogo = Image.asset("assets/images/ccLogo.png",
      height: SizeConfig.imageSizeMultiplier * 10);
  int _currentIndex = 0;
  final List<Widget> _children = [EmployeeScreen(), StudentScreen()];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(SizeConfig.heightMultiplier * 10),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: appLogo,
            actions: [
              IconButton(
                icon: searchIcon,
                onPressed: () => SearchData.show(context,
                    database: Provider.of<Database>(context)),
              ),
              SizedBox(width: SizeConfig.widthMultiplier * 2),
              IconButton(
                icon: Icon(
                  Icons.power_settings_new,
                  color: loginColor,
                ),
                onPressed: () => widget._confirmSignOut(context),
              ),
            ],
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/employeeWhite.png"),
                size: SizeConfig.imageSizeMultiplier * 8,
              ),
              title: Text("Employees", style: GoogleFonts.poppins()),
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage("assets/images/studentWhite.png"),
                size: SizeConfig.imageSizeMultiplier * 8,
                // color: Colors.white,
              ),
              title: Text("Students", style: GoogleFonts.poppins()),
            ),
          ],
        ),
      ),
    );
  }
}
