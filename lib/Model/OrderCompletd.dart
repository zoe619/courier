class CompletedOrder {
  int id;
  int courierId;
  int courierOrderId;
  int status;
  String createdAt;
  String updatedAt;
  String bookingableType;
  int bookingableId;
  int quantity;
  double total;
  String data;
  String redemptionCode;
  int userId;
  Null supplierId;
  int bookingStatusId;
  int paymentId;
  Null deletedAt;
  int restaurantId;
  String bookingRef;
  Null sessionId;
  int resturentAccept;
  int courierAccept;
  int dispatch;
  int delivered;

  CompletedOrder(
      {this.id,
        this.courierId,
        this.courierOrderId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.bookingableType,
        this.bookingableId,
        this.quantity,
        this.total,
        this.data,
        this.redemptionCode,
        this.userId,
        this.supplierId,
        this.bookingStatusId,
        this.paymentId,
        this.deletedAt,
        this.restaurantId,
        this.bookingRef,
        this.sessionId,
        this.resturentAccept,
        this.courierAccept,
        this.dispatch,
        this.delivered});

  CompletedOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courierId = json['courier_id'];
    courierOrderId = json['courier_order_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bookingableType = json['bookingable_type'];
    bookingableId = json['bookingable_id'];
    quantity = json['quantity'];
    total = json['total'];
    data = json['data'];
    redemptionCode = json['redemption_code'];
    userId = json['user_id'];
    supplierId = json['supplier_id'];
    bookingStatusId = json['booking_status_id'];
    paymentId = json['payment_id'];
    deletedAt = json['deleted_at'];
    restaurantId = json['restaurant_id'];
    bookingRef = json['booking_ref'];
    sessionId = json['session_id'];
    resturentAccept = json['resturent_accept'];
    courierAccept = json['courier_accept'];
    dispatch = json['dispatch'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courier_id'] = this.courierId;
    data['courier_order_id'] = this.courierOrderId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['bookingable_type'] = this.bookingableType;
    data['bookingable_id'] = this.bookingableId;
    data['quantity'] = this.quantity;
    data['total'] = this.total;
    data['data'] = this.data;
    data['redemption_code'] = this.redemptionCode;
    data['user_id'] = this.userId;
    data['supplier_id'] = this.supplierId;
    data['booking_status_id'] = this.bookingStatusId;
    data['payment_id'] = this.paymentId;
    data['deleted_at'] = this.deletedAt;
    data['restaurant_id'] = this.restaurantId;
    data['booking_ref'] = this.bookingRef;
    data['session_id'] = this.sessionId;
    data['resturent_accept'] = this.resturentAccept;
    data['courier_accept'] = this.courierAccept;
    data['dispatch'] = this.dispatch;
    data['delivered'] = this.delivered;
    return data;
  }
}
