class AllCitiesModel {
  List<Data> data;
  String message;

  AllCitiesModel({this.data, this.message});

  AllCitiesModel.fromJson(Map<String, dynamic> json) {
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
  String country;
  String city;
  String cityAscii;
  String region;
  int population;
  String latitude;
  String longitude;
  String createdAt;
  String updatedAt;

  Data(
      {this.id,
      this.country,
      this.city,
      this.cityAscii,
      this.region,
      this.population,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    city = json['city'];
    cityAscii = json['city_ascii'];
    region = json['region'];
    population = json['population'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['city'] = this.city;
    data['city_ascii'] = this.cityAscii;
    data['region'] = this.region;
    data['population'] = this.population;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
