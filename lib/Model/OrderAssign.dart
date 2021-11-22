class OrderAssign {
  bool success;
  Order order;

  OrderAssign({this.success, this.order});

  OrderAssign.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.order != null) {
      data['order'] = this.order.toJson();
    }
    return data;
  }
}

class Order {
  int id;
  String pickupaddress;
  String pickuplng;
  String picklat;
  String delupaddress;
  String delLng;
  String delLat;
  String vendorId;
  String coustomerId;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  int courierAccept;
  int dispatch;
  int delivered;

  Order(
      {this.id,
        this.pickupaddress,
        this.pickuplng,
        this.picklat,
        this.delupaddress,
        this.delLng,
        this.delLat,
        this.vendorId,
        this.coustomerId,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.courierAccept,
        this.dispatch,
        this.delivered});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupaddress = json['pickupaddress'];
    pickuplng = json['pickuplng'];
    picklat = json['picklat'];
    delupaddress = json['delupaddress'];
    delLng = json['delLng'];
    delLat = json['delLat'];
    vendorId = json['vendor_id'];
    coustomerId = json['coustomer_id'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courierAccept = json['courier_accept'];
    dispatch = json['dispatch'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pickupaddress'] = this.pickupaddress;
    data['pickuplng'] = this.pickuplng;
    data['picklat'] = this.picklat;
    data['delupaddress'] = this.delupaddress;
    data['delLng'] = this.delLng;
    data['delLat'] = this.delLat;
    data['vendor_id'] = this.vendorId;
    data['coustomer_id'] = this.coustomerId;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['courier_accept'] = this.courierAccept;
    data['dispatch'] = this.dispatch;
    data['delivered'] = this.delivered;
    return data;
  }
}
