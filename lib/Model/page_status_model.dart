// class PagesStatusModel {
//   int currentPage, from, lastPage;
//   var links = <PageInfoModel>[];
//   String path;
//   int perPage, to, total;

//   PagesStatusModel.fromJson(Map<String, dynamic> data) {
//     currentPage = data['current_page'];
//     from = data['from'];
//     lastPage = data['last_page'];
//     (data['links'] as List).forEach((e) => links.add(PageInfoModel.fromJson(e)));
//     path = data['path'];
//     perPage = data['per_page'];
//     to = data['to'];
//     total = data['total'];
//   }
// }
class PagesStatusModel {
  String first;
  String last;
  dynamic prev;
  dynamic next;

  PagesStatusModel({this.first, this.last, this.prev, this.next});

  PagesStatusModel.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class PageInfoModel {
  String url;
  dynamic label;
  bool active;

  PageInfoModel.fromJson(Map<String, dynamic> data) {
    url = data['url'];
    label = data['label'];
    active = data['active'];
  }
}
