import 'package:tcourier/Model/ongoing_order_item_model.dart';
import 'package:tcourier/Model/page_links_model.dart';
import 'package:tcourier/Model/page_status_model.dart';

class OngoingOrdersModel {
  var data = <OngoingOrderItemModel>[];
  PageLinksModel links;
  PagesStatusModel meta;

  OngoingOrdersModel.fromJson(Map<String, dynamic> source) {
    (source['data'] as List).forEach((e) => data.add(OngoingOrderItemModel.fromJson(e)));
    links = PageLinksModel.fromJson(source['links']);
    meta = PagesStatusModel.fromJson(source['meta']);
  }
}


// class OngoingOrdersModel {
//   List<Data> data;
//   Links links;
//   Meta meta;
//   String message;

//   OngoingOrdersModel({this.data, this.links, this.meta, this.message});

//   OngoingOrdersModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//     links = json['links'] != null ? new Links.fromJson(json['links']) : null;
//     meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
//     message = json['message'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     if (this.links != null) {
//       data['links'] = this.links.toJson();
//     }
//     if (this.meta != null) {
//       data['meta'] = this.meta.toJson();
//     }
//     data['message'] = this.message;
//     return data;
//   }
// }

// class Data {
//   int id;
//   int courierId;
//   int courierCustomerId;
//   int bookingStatusId;
//   int currencyId;
//   int countryId;
//   dynamic courierTransportModeId;
//   String orderRef;
//   int delivered;
//   String itemDescription;
//   String customerPhoneNumber;
//   String customerAddress;
//   String customerLat;
//   String customerLng;
//   String consumerPhoneNumber;
//   String consumerAddress;
//   String consumerLat;
//   String consumerLng;
//   dynamic customerFinaleLat;
//   dynamic customerFinaleLng;
//   dynamic consumerFinaleLat;
//   dynamic consumerFinaleLng;
//   String orderValue;
//   dynamic finaleDistance;
//   double courierFee;
//   double distance;
//   int baseCharge;
//   int baseExtraCharge;
//   String paymentMode;
//   dynamic pickedUpTime;
//   dynamic deliveredTime;
//   String createdAt;
//   String updatedAt;
//   dynamic courierOrderableType;
//   dynamic courierOrderableId;
//   String deliveryMode;
//   String comment;
//   int collectPayment;
//   String building;
//   dynamic nextTry;
//   dynamic tries;
//   int consumerPays;
//   int customerPays;
//   int cityId;
//   int courierConsumerId;
//   String consumerName;
//   String humanTime;

//   Data(
//       {this.id,
//       this.courierId,
//       this.courierCustomerId,
//       this.bookingStatusId,
//       this.currencyId,
//       this.countryId,
//       this.courierTransportModeId,
//       this.orderRef,
//       this.delivered,
//       this.itemDescription,
//       this.customerPhoneNumber,
//       this.customerAddress,
//       this.customerLat,
//       this.customerLng,
//       this.consumerPhoneNumber,
//       this.consumerAddress,
//       this.consumerLat,
//       this.consumerLng,
//       this.customerFinaleLat,
//       this.customerFinaleLng,
//       this.consumerFinaleLat,
//       this.consumerFinaleLng,
//       this.orderValue,
//       this.finaleDistance,
//       this.courierFee,
//       this.distance,
//       this.baseCharge,
//       this.baseExtraCharge,
//       this.paymentMode,
//       this.pickedUpTime,
//       this.deliveredTime,
//       this.createdAt,
//       this.updatedAt,
//       this.courierOrderableType,
//       this.courierOrderableId,
//       this.deliveryMode,
//       this.comment,
//       this.collectPayment,
//       this.building,
//       this.nextTry,
//       this.tries,
//       this.consumerPays,
//       this.customerPays,
//       this.cityId,
//       this.courierConsumerId,
//       this.consumerName,
//       this.humanTime});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     courierId = json['courier_id'];
//     courierCustomerId = json['courier_customer_id'];
//     bookingStatusId = json['booking_status_id'];
//     currencyId = json['currency_id'];
//     countryId = json['country_id'];
//     courierTransportModeId = json['courier_transport_mode_id'];
//     orderRef = json['order_ref'];
//     delivered = json['delivered'];
//     itemDescription = json['item_description'];
//     customerPhoneNumber = json['customer_phone_number'];
//     customerAddress = json['customer_address'];
//     customerLat = json['customer_lat'];
//     customerLng = json['customer_lng'];
//     consumerPhoneNumber = json['consumer_phone_number'];
//     consumerAddress = json['consumer_address'];
//     consumerLat = json['consumer_lat'];
//     consumerLng = json['consumer_lng'];
//     customerFinaleLat = json['customer_finale_lat'];
//     customerFinaleLng = json['customer_finale_lng'];
//     consumerFinaleLat = json['consumer_finale_lat'];
//     consumerFinaleLng = json['consumer_finale_lng'];
//     orderValue = json['order_value'];
//     finaleDistance = json['finale_distance'];
//     courierFee = json['courier_fee'];
//     distance = json['distance'];
//     baseCharge = json['base_charge'];
//     baseExtraCharge = json['base_extra_charge'];
//     paymentMode = json['payment_mode'];
//     pickedUpTime = json['picked_up_time'];
//     deliveredTime = json['delivered_time'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     courierOrderableType = json['courier_orderable_type'];
//     courierOrderableId = json['courier_orderable_id'];
//     deliveryMode = json['delivery_mode'];
//     comment = json['comment'];
//     collectPayment = json['collect_payment'];
//     building = json['building'];
//     nextTry = json['next_try'];
//     tries = json['tries'];
//     consumerPays = json['consumer_pays'];
//     customerPays = json['customer_pays'];
//     cityId = json['city_id'];
//     courierConsumerId = json['courier_consumer_id'];
//     consumerName = json['consumer_name'];
//     humanTime = json['human_time'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['courier_id'] = this.courierId;
//     data['courier_customer_id'] = this.courierCustomerId;
//     data['booking_status_id'] = this.bookingStatusId;
//     data['currency_id'] = this.currencyId;
//     data['country_id'] = this.countryId;
//     data['courier_transport_mode_id'] = this.courierTransportModeId;
//     data['order_ref'] = this.orderRef;
//     data['delivered'] = this.delivered;
//     data['item_description'] = this.itemDescription;
//     data['customer_phone_number'] = this.customerPhoneNumber;
//     data['customer_address'] = this.customerAddress;
//     data['customer_lat'] = this.customerLat;
//     data['customer_lng'] = this.customerLng;
//     data['consumer_phone_number'] = this.consumerPhoneNumber;
//     data['consumer_address'] = this.consumerAddress;
//     data['consumer_lat'] = this.consumerLat;
//     data['consumer_lng'] = this.consumerLng;
//     data['customer_finale_lat'] = this.customerFinaleLat;
//     data['customer_finale_lng'] = this.customerFinaleLng;
//     data['consumer_finale_lat'] = this.consumerFinaleLat;
//     data['consumer_finale_lng'] = this.consumerFinaleLng;
//     data['order_value'] = this.orderValue;
//     data['finale_distance'] = this.finaleDistance;
//     data['courier_fee'] = this.courierFee;
//     data['distance'] = this.distance;
//     data['base_charge'] = this.baseCharge;
//     data['base_extra_charge'] = this.baseExtraCharge;
//     data['payment_mode'] = this.paymentMode;
//     data['picked_up_time'] = this.pickedUpTime;
//     data['delivered_time'] = this.deliveredTime;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['courier_orderable_type'] = this.courierOrderableType;
//     data['courier_orderable_id'] = this.courierOrderableId;
//     data['delivery_mode'] = this.deliveryMode;
//     data['comment'] = this.comment;
//     data['collect_payment'] = this.collectPayment;
//     data['building'] = this.building;
//     data['next_try'] = this.nextTry;
//     data['tries'] = this.tries;
//     data['consumer_pays'] = this.consumerPays;
//     data['customer_pays'] = this.customerPays;
//     data['city_id'] = this.cityId;
//     data['courier_consumer_id'] = this.courierConsumerId;
//     data['consumer_name'] = this.consumerName;
//     data['human_time'] = this.humanTime;
//     return data;
//   }
// }

// class Links {
//   String first;
//   String last;
//   dynamic prev;
//   dynamic next;

//   Links({this.first, this.last, this.prev, this.next});

//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//     prev = json['prev'];
//     next = json['next'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     data['prev'] = this.prev;
//     data['next'] = this.next;
//     return data;
//   }
// }

// class Meta {
//   int currentPage;
//   int from;
//   int lastPage;
//   String path;
//   int perPage;
//   int to;
//   int total;

//   Meta({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
