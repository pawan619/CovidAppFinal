import 'package:covidCare/model/department.dart';

class Repository {
  List<Map> getAll() => _dataSource;
  getLocalByType(String type) => _dataSource
      .map((map) => StateModel.fromJson(map))
      .where((item) => item.type == type)
      .map((item) => item.department)
      .expand((i) => i)
      .toList();

  List<String> getDataSource() => _dataSource
      .map((map) => StateModel.fromJson(map))
      .map((item) => item.type)
      .toList();

  List _dataSource = [
    {
      "type": "Employee",
      "alias": "employee",
      "department": [
        "Teaching",
        "Non-Teaching",
      ]
    },
    {
      "type": "Student",
      "alias": "student",
      "department": [
        "Msc_IT(III)",
        "MCA(II)",
        "BE_CS(IV)",
        "Bsc_IT(II)",
      ]
    },
  ];
}
