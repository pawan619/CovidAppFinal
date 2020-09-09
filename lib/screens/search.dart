import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:covidCare/services/database.dart';
import 'package:provider/provider.dart';
import 'package:covidCare/DataList/empList.dart';
import 'package:covidCare/model/emp.dart';
import 'package:covidCare/widgets/list_item_builder.dart';
import 'package:covidCare/screens/EmpDetailScreen.dart';
import 'package:covidCare/screens/StuDetailScreen.dart';
import 'package:covidCare/ColorClass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covidCare/size_config.dart';
import 'package:covidCare/model/stu.dart';
import 'package:covidCare/DataList/stuList.dart';
import 'package:covidCare/model/repository.dart';

//SearchBar searchBar;
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class SearchData extends StatefulWidget {
  const SearchData({@required this.database});
  final Database database;

  static Future<void> show(BuildContext context, {Database database}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => SearchData(database: database),
      ),
    );
  }

  @override
  _SearchDataState createState() => new _SearchDataState();
}

class _SearchDataState extends State<SearchData> {
  Repository repo = Repository();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _searchTextcontroller = TextEditingController();
  List<String> _type = ["Choose type"];
  List<String> _department = ["Choose department.."];
  List<String> _mask = ["Choose mask status", "With Mask", "Without Mask"];
  String _maskSelected = "Choose mask status";
  String _selectedType = "Choose type";
  String _selectedDepartment = "Choose department..";

  bool disableDropdown = true;

  final namecontroller = TextEditingController();
  String radioItem = 'Employee';
  int group = 1;
  String nameVal, fval, nval, tval, dval, mval;

  @override
  void initState() {
    _type = List.from(_type)..addAll(repo.getDataSource());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//        backgroundColor: greyColor2,
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Search Data",
              style: GoogleFonts.poppins(),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[primaryColor, secondaryColor])),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    _scaffoldKey.currentState.openEndDrawer();
                  })
            ],
          ),
          endDrawer: _customDrawer(),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 180,
                  color: Colors.white,
                  child: _card(context),
                ),
                Container(
                  height: 400,
                  color: Colors.white,
                  child: _buildContents(context, nval, dval, mval),
                ),
              ],
            ),
          )),
    );
  }

  Widget _customDrawer() {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.heightMultiplier * 5,
            vertical: SizeConfig.heightMultiplier * 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Search by filter",
                style: GoogleFonts.roboto(
                    fontSize: SizeConfig.heightMultiplier * 3,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            Text("Type", style: GoogleFonts.poppins(color: greyColor)),
            DropdownButton<String>(
              isExpanded: true,
              isDense: true,
              items: _type.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (value) => _onSelectedType(value),
              value: _selectedType,
            ),
            SizedBox(height: 30.0),
            Text("Department", style: GoogleFonts.poppins(color: greyColor)),
            DropdownButton<String>(
              isExpanded: true,
              isDense: true,
              items: _department.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              // onChanged: (value) => print(value),
              onChanged: (value) => _onSelectedDepartment(value),
              value: _selectedDepartment,
            ),
            SizedBox(height: 30.0),
            Text("Mask", style: GoogleFonts.poppins(color: greyColor)),
            DropdownButton(
              isExpanded: true,
              isDense: true,
              value: _maskSelected,
              disabledHint: Text("Select mask"),
              items: _mask.map((dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (value) => _onSelectedMask(value),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: loginColor,
                  onPressed: () {
                    setState(() {
                      print(_selectedType);
                      print(_selectedDepartment);
                      print(_maskSelected);
                      dval = _selectedDepartment;
                      mval = _maskSelected;
                      _buildContents(context, nval, dval, mval);
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    "APPLY",
                    style: GoogleFonts.roboto(color: Colors.white),
                  ),
                ),
                OutlineButton(
                  child: Text("RESET",
                      style: GoogleFonts.roboto(color: loginColor)),
                  borderSide: BorderSide(color: loginColor),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    setState(() {
                      _selectedDepartment = "Choose department..";
                      _department = ["Choose department.."];
                      _selectedType = "Choose type";
                      _maskSelected = "Choose mask status";
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onSelectedType(String value) {
    setState(() {
      _selectedDepartment = "Choose department..";
      _department = ["Choose department.."];
      _selectedType = value;
      _department = List.from(_department)..addAll(repo.getLocalByType(value));
    });
  }

  void _onSelectedDepartment(String value) {
    setState(() => _selectedDepartment = value);
  }

  void _onSelectedMask(String value) {
    setState(() {
      _maskSelected = value;
    });
  }

  Widget _card(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
        height: 180,
        width: double.infinity,
        child: Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(7),
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      SizedBox(width: 50.0),
                      new Radio(
                          value: 1,
                          //title: Text('Radio Button Item 1'),
                          groupValue: group,
                          onChanged: (T) {
                            radioItem = "Employee";
                            namecontroller.text = '';
                            msg();
                            setState(() {
                              group = T;
                            });
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('Employee'),
                      ),
                      Radio(
                          value: 2,
                          groupValue: group,
                          onChanged: (T) {
                            radioItem = "Student";
                            namecontroller.text = '';
                            msg();
                            setState(() {
                              group = T;
                            });
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text('Student'),
                      ),
                    ])),
                Container(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      //
                      new Flexible(
                        child: new TextField(
                          controller: namecontroller,
                          keyboardType: TextInputType.name,
                          onSubmitted: (text) {
                            setState(() {
                              nval = namecontroller.text[0].toUpperCase() +
                                  namecontroller.text.substring(1);
                              _buildContents(context, nval, dval, mval);
                            });
                          },
                          // _buildContents(context, namecontroller.text),
                          // onSaved: (value) =>msg();
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter $radioItem  Name  ',
                            hintText: 'Enter $radioItem Name  ',
                          ),
                        ),
                      ),
                    ])),
              ])),
            )));
  }

  Widget _buildContents(BuildContext context, nval, dval, mval) {
    // final database = Provider.of<Database>(context);
    if (radioItem == 'Employee' && namecontroller.text.isNotEmpty) {
      return StreamBuilder<List<Emp>>(
        stream: widget.database.empStreamSearch('emp_name', nval),
        builder: (context, snapshot) {
          return ListItemsBuilder<Emp>(
              snapshot: snapshot,
              itemBuilder: (context, emp) => EmpList(
                    emp: emp,
                    onTap: () => EmpDetailScreen.show(context, emp,
                        database: widget.database),
                  ));
        },
      );
    }
    if (radioItem == 'Student' && namecontroller.text.isNotEmpty) {
      return StreamBuilder<List<Stu>>(
        stream: widget.database.stuStreamSearch('s_name', fval),
        builder: (context, snapshot) {
          return ListItemsBuilder<Stu>(
              snapshot: snapshot,
              itemBuilder: (context, stu) => StuList(
                    stu: stu,
                    onTap: () => StuDetailScreen.show(context, stu,
                        database: widget.database),
                  ));
        },
      );
    }

    if (_selectedType == 'Student' &&
        _selectedDepartment.isNotEmpty &&
        _maskSelected.isNotEmpty) {
      return StreamBuilder<List<Stu>>(
        stream:
            widget.database.stuMultiSearch(_selectedDepartment, _maskSelected),
        builder: (context, snapshot) {
          return ListItemsBuilder<Stu>(
              snapshot: snapshot,
              itemBuilder: (context, stu) => StuList(
                    stu: stu,
                    onTap: () => StuDetailScreen.show(context, stu,
                        database: widget.database),
                  ));
        },
      );
    }
  }

  void msg() {
    print(namecontroller.text);
  }
}
