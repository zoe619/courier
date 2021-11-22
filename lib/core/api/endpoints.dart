class Endpoints {
  ///Auth Endpoints
  static final String login = "login";
  static final String create = "create_account";
  static final String createAccountV2 = "create account v2";
  static final String kycDetail = "update_account";
  static final String forgotPassword = "forgot password";
  static final String resetPassword = "reset password";
  static final String generateMobilePin = "generate_mobile_pin";
  static final String loginWithPhone = "login_with_phone";
  static final String pinVerification = "pinVerification";

  //Bank
  static final String addBankDetails = "add_courier_bank_account";

  //Id
  static final String addIdMeans = "add_indentification_means";

  //Courier visibility
  static final String goOnline = "go_online";
  static final String goOffline = "go_offline";
  static final String sendCurrentLocation = "save_lat_long";
  static final String addDeviceFcmToken = "add_device";

  //Order or Delivery Endpoints
  static final String getCourierDetails = "get_courier";
  static final String getCompletedOrder = "completed_orders";
  static final String getOngoingOrder = "on_going_orders";
  static final String getSingleOrder = "get_order";
  static final String getMyOrders = "my_orders";
  static final String orderAccept = "orderAccept";
  static final String orderReject = "orderReject";
  static final String orderAssign = "orderAssign";
  static final String getTransportType = "get_transport_types";
  static final String orderDispatch = "orderDispach";
  static final String orderDelivered = "orderDelivered";
  static final String estimatePickup = "estimatePickup";
  static final String estimateDelivery = "estimateDelivery";

//Settings Endpoints
  static final String getprofile = "get_courier";
  static final String maximumKm = "change_max_km";

  //Dashboard Endpoints
  static final String getDashboard = "get_payment_dashboard";
}
