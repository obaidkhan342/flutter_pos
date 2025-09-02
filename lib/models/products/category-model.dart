// ignore_for_file: non_constant_identifier_names, file_names

class CategoryModel {
  String? category_id;
  String? category_name;
  String? status;

  CategoryModel({this.category_id, this.category_name, this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category_id = json['category_id'];
    category_name = json['category_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = category_id;
    data['category_name'] = category_name;
    data['status'] = status;

    return data;
  }
}
