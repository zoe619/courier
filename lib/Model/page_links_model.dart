class PageLinksModel {
  String first, last, prev, next;

  PageLinksModel.fromJson(Map<String, dynamic> data) {
    first = data['first'];
    last = data['last'];
    prev = data['prev'];
    next = data['next'];
  }
}
