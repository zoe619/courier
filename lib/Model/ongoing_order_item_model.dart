class OngoingOrderItemModel {
  dynamic id;
  dynamic courierId;
  dynamic courierCustomerId;
  dynamic bookingStatusId;
  dynamic currencyId;
  dynamic countryId;
  dynamic courierTransportModeId;
  String orderRef;
  dynamic delivered;
  String itemDescription;
  String customerPhoneNumber;
  String customerAddress;
  String customerLat;
  String customerLng;
  String consumerPhoneNumber;
  String consumerAddress;
  String consumerLat;
  String consumerLng;
  dynamic customerFinaleLat;
  dynamic customerFinaleLng;
  dynamic consumerFinaleLat;
  dynamic consumerFinaleLng;
  String orderValue;
  dynamic finaleDistance;
  dynamic courierFee;
  dynamic distance;
  dynamic baseCharge;
  dynamic baseExtraCharge;
  String paymentMode;
  dynamic pickedUpTime;
  dynamic deliveredTime;
  String createdAt;
  String updatedAt;
  dynamic courierOrderableType;
  dynamic courierOrderableId;
  String deliveryMode;
  String comment;
  dynamic collectPayment;
  String building;
  dynamic nextTry;
  dynamic tries;
  dynamic consumerPays;
  dynamic customerPays;
  dynamic cityId;
  dynamic courierConsumerId;
  String consumerName;
  String humanTime;

  OngoingOrderItemModel(
      {this.id,
      this.courierId,
      this.courierCustomerId,
      this.bookingStatusId,
      this.currencyId,
      this.countryId,
      this.courierTransportModeId,
      this.orderRef,
      this.delivered,
      this.itemDescription,
      this.customerPhoneNumber,
      this.customerAddress,
      this.customerLat,
      this.customerLng,
      this.consumerPhoneNumber,
      this.consumerAddress,
      this.consumerLat,
      this.consumerLng,
      this.customerFinaleLat,
      this.customerFinaleLng,
      this.consumerFinaleLat,
      this.consumerFinaleLng,
      this.orderValue,
      this.finaleDistance,
      this.courierFee,
      this.distance,
      this.baseCharge,
      this.baseExtraCharge,
      this.paymentMode,
      this.pickedUpTime,
      this.deliveredTime,
      this.createdAt,
      this.updatedAt,
      this.courierOrderableType,
      this.courierOrderableId,
      this.deliveryMode,
      this.comment,
      this.collectPayment,
      this.building,
      this.nextTry,
      this.tries,
      this.consumerPays,
      this.customerPays,
      this.cityId,
      this.courierConsumerId,
      this.consumerName,
      this.humanTime});

  OngoingOrderItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courierId = json['courier_id'];
    courierCustomerId = json['courier_customer_id'];
    bookingStatusId = json['booking_status_id'];
    currencyId = json['currency_id'];
    countryId = json['country_id'];
    courierTransportModeId = json['courier_transport_mode_id'];
    orderRef = json['order_ref'];
    delivered = json['delivered'];
    itemDescription = json['item_description'];
    customerPhoneNumber = json['customer_phone_number'];
    customerAddress = json['customer_address'];
    customerLat = json['customer_lat'];
    customerLng = json['customer_lng'];
    consumerPhoneNumber = json['consumer_phone_number'];
    consumerAddress = json['consumer_address'];
    consumerLat = json['consumer_lat'];
    consumerLng = json['consumer_lng'];
    customerFinaleLat = json['customer_finale_lat'];
    customerFinaleLng = json['customer_finale_lng'];
    consumerFinaleLat = json['consumer_finale_lat'];
    consumerFinaleLng = json['consumer_finale_lng'];
    orderValue = json['order_value'];
    finaleDistance = json['finale_distance'];
    courierFee = json['courier_fee'];
    distance = json['distance'];
    baseCharge = json['base_charge'];
    baseExtraCharge = json['base_extra_charge'];
    paymentMode = json['payment_mode'];
    pickedUpTime = json['picked_up_time'];
    deliveredTime = json['delivered_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courierOrderableType = json['courier_orderable_type'];
    courierOrderableId = json['courier_orderable_id'];
    deliveryMode = json['delivery_mode'];
    comment = json['comment'];
    collectPayment = json['collect_payment'];
    building = json['building'];
    nextTry = json['next_try'];
    tries = json['tries'];
    consumerPays = json['consumer_pays'];
    customerPays = json['customer_pays'];
    cityId = json['city_id'];
    courierConsumerId = json['courier_consumer_id'];
    consumerName = json['consumer_name'];
    humanTime = json['human_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['courier_id'] = this.courierId;
    data['courier_customer_id'] = this.courierCustomerId;
    data['booking_status_id'] = this.bookingStatusId;
    data['currency_id'] = this.currencyId;
    data['country_id'] = this.countryId;
    data['courier_transport_mode_id'] = this.courierTransportModeId;
    data['order_ref'] = this.orderRef;
    data['delivered'] = this.delivered;
    data['item_description'] = this.itemDescription;
    data['customer_phone_number'] = this.customerPhoneNumber;
    data['customer_address'] = this.customerAddress;
    data['customer_lat'] = this.customerLat;
    data['customer_lng'] = this.customerLng;
    data['consumer_phone_number'] = this.consumerPhoneNumber;
    data['consumer_address'] = this.consumerAddress;
    data['consumer_lat'] = this.consumerLat;
    data['consumer_lng'] = this.consumerLng;
    data['customer_finale_lat'] = this.customerFinaleLat;
    data['customer_finale_lng'] = this.customerFinaleLng;
    data['consumer_finale_lat'] = this.consumerFinaleLat;
    data['consumer_finale_lng'] = this.consumerFinaleLng;
    data['order_value'] = this.orderValue;
    data['finale_distance'] = this.finaleDistance;
    data['courier_fee'] = this.courierFee;
    data['distance'] = this.distance;
    data['base_charge'] = this.baseCharge;
    data['base_extra_charge'] = this.baseExtraCharge;
    data['payment_mode'] = this.paymentMode;
    data['picked_up_time'] = this.pickedUpTime;
    data['delivered_time'] = this.deliveredTime;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['courier_orderable_type'] = this.courierOrderableType;
    data['courier_orderable_id'] = this.courierOrderableId;
    data['delivery_mode'] = this.deliveryMode;
    data['comment'] = this.comment;
    data['collect_payment'] = this.collectPayment;
    data['building'] = this.building;
    data['next_try'] = this.nextTry;
    data['tries'] = this.tries;
    data['consumer_pays'] = this.consumerPays;
    data['customer_pays'] = this.customerPays;
    data['city_id'] = this.cityId;
    data['courier_consumer_id'] = this.courierConsumerId;
    data['consumer_name'] = this.consumerName;
    data['human_time'] = this.humanTime;
    return data;
  }
}
