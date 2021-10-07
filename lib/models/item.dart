class Item {
  final int id;
  final String name;
  final String title;
  final int category_id;
  final String description;
  final int price;
  final int discount;
  final String discount_type;
  final String currency;
  final int in_stock;
  final String avatar;
  final int price_final;
  final String price_final_text;

  Item({
    required this.id,
    required this.name,
    required this.title,
    required this.category_id,
    required this.description,
    required this.price,
    required this.discount,
    required this.discount_type,
    required this.currency,
    required this.in_stock,
    required this.avatar,
    required this.price_final,
    required this.price_final_text,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      category_id: json['category_id'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      discount_type: json['discount_type'],
      currency: json['currency'],
      in_stock: json['in_stock'],
      avatar: json['avatar'],
      price_final: json['price_final'],
      price_final_text: json['price_final_text'],
    );
  }
}
