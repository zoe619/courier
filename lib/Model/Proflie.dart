class Profile {
  Data data;
  String message;

  Profile({this.data, this.message});

  Profile.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String firstName;
  String lastName;
  String phone;
  String email;
  int isEmailVerified;
  int phoneVerifiedAt;
  int isSuspended;
  int isGoOnline;
  int isApproved;
  String address;
  String gender;
  String dateOfBirth;
  dynamic lat;
  dynamic lng;
  dynamic seoUrl;
  dynamic country;
  dynamic city;
  dynamic profileImage;
  int todayEarning;
  int maxDeliveryKm;
  CourierTransportMode courierTransportMode;
  int hasBank;

  Data(
      {this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.isEmailVerified,
      this.phoneVerifiedAt,
      this.isSuspended,
      this.isGoOnline,
      this.isApproved,
      this.address,
      this.gender,
      this.dateOfBirth,
      this.lat,
      this.lng,
      this.seoUrl,
      this.country,
      this.city,
      this.profileImage,
      this.todayEarning,
      this.maxDeliveryKm,
      this.courierTransportMode,
      this.hasBank});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    phoneVerifiedAt = json['phone_verified_at'];
    isSuspended = json['is_suspended'];
    isGoOnline = json['is_go_online'];
    isApproved = json['is_approved'];
    address = json['address'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    lat = json['lat'];
    lng = json['lng'];
    seoUrl = json['seo_url'];
    country = json['country'];
    city = json['city'];
    profileImage = json['profile_image'];
    todayEarning = json['today_earning'];
    maxDeliveryKm = json['max_delivery_km'];
    courierTransportMode = json['courier_transport_mode'] != null
        ? new CourierTransportMode.fromJson(json['courier_transport_mode'])
        : null;
    hasBank = json['has_bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_email_verified'] = this.isEmailVerified;
    data['phone_verified_at'] = this.phoneVerifiedAt;
    data['is_suspended'] = this.isSuspended;
    data['is_go_online'] = this.isGoOnline;
    data['is_approved'] = this.isApproved;
    data['address'] = this.address;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['seo_url'] = this.seoUrl;
    data['country'] = this.country;
    data['city'] = this.city;
    data['profile_image'] = this.profileImage;
    data['today_earning'] = this.todayEarning;
    data['max_delivery_km'] = this.maxDeliveryKm;
    if (this.courierTransportMode != null) {
      data['courier_transport_mode'] = this.courierTransportMode.toJson();
    }
    data['has_bank'] = this.hasBank;
    return data;
  }
}

class CourierTransportMode {
  int id;
  String name;
  int isActive;
  String type;
  String mode;
  String createdAt;
  String updatedAt;

  CourierTransportMode(
      {this.id, this.name, this.isActive, this.type, this.mode, this.createdAt, this.updatedAt});

  CourierTransportMode.fromJson(Map<String, dynamic> json) {
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
