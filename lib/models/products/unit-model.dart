// ignore_for_file: file_names

class UnitModel {
  String? id;
  String? unitName;
  String? status;

  UnitModel({this.id, this.unitName, this.status});

  UnitModel.fromJson(Map<String, dynamic> json) {
    id = json['unit_id'];
    unitName = json['unit_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit_id'] = id;
    data['unit_name'] = unitName;
    data['status'] = status;

    return data;
  }
}
