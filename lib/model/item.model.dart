class Item {
  Item({this.userId, this.id, this.title, this.body, this.isFav});

  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  bool? isFav;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
