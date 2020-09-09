class StateModel {
  String type;
  String alias;
  List<String> department;

  StateModel({this.type, this.alias, this.department});

  StateModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    alias = json['alias'];
    department = json['department'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['alias'] = this.alias;
    data['department'] = this.department;
    return data;
  }
}
