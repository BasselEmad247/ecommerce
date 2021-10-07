class Category {
  var id;
  var name;
  var avatar;

  Category({
    this.id,
    this.name,
    this.avatar,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
