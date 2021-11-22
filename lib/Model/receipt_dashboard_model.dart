class ReceiptDashboardModel {
  // List<Null> data;
  String message;
  List<Revenue> revenue;
  // List<Null> netIncome;
  int startingBalance;
  int currentBalance;
  int payoutBalance;

  ReceiptDashboardModel(
      {
      // this.data,
      this.message,
      this.revenue,
      // this.netIncome,
      this.startingBalance,
      this.currentBalance,
      this.payoutBalance});

  ReceiptDashboardModel.fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    //   data = new List<Null>();
    //   json['data'].forEach((v) {
    //     data.add(new Null.fromJson(v));
    //   });
    // }
    message = json['message'];
    if (json['revenue'] != null) {
      revenue = <Revenue>[];
      json['revenue'].forEach((v) {
        revenue.add(new Revenue.fromJson(v));
      });
    }
    // if (json['net_income'] != null) {
    //   netIncome = new List<Null>();
    //   json['net_income'].forEach((v) {
    //     netIncome.add(new Null.fromJson(v));
    //   });
    // }
    startingBalance = json['starting_balance'];
    currentBalance = json['current_balance'];
    payoutBalance = json['payout_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
    //   data['data'] = this.data.map((v) => v.toJson()).toList();
    // }
    data['message'] = this.message;
    if (this.revenue != null) {
      data['revenue'] = this.revenue.map((v) => v.toJson()).toList();
    }
    // if (this.netIncome != null) {
    //   data['net_income'] = this.netIncome.map((v) => v.toJson()).toList();
    // }
    data['starting_balance'] = this.startingBalance;
    data['current_balance'] = this.currentBalance;
    data['payout_balance'] = this.payoutBalance;
    return data;
  }
}

class Revenue {
  String day;
  int total;

  Revenue({this.day, this.total});

  Revenue.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['total'] = this.total;
    return data;
  }
}
