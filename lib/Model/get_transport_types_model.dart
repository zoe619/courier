class GetTransportTypesModel {
  List<Data> data;
  String message;

  GetTransportTypesModel({this.data, this.message});

  GetTransportTypesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String name;
  int isActive;
  String type;
  String mode;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.name,
      this.isActive,
      this.type,
      this.mode,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isActive = json['is_active'];
    type = json['type'];
    mode = json['mode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_active'] = this.isActive;
    data['type'] = this.type;
    data['mode'] = this.mode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
