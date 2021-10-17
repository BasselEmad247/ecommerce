class Product {
  var id;
  var name;
  var title;
  var category_id;
  var description;
  var price;
  var discount;
  var discount_type;
  var currency;
  var in_stock;
  var avatar;
  var price_final;
  var price_final_text;
  var userAmount;

  Product({
    required this.id,
    required this.name,
    this.title,
    required this.category_id,
    this.description = " ",
    required this.price,
    this.discount = 0,
    this.discount_type,
    this.currency = "EGP",
    this.in_stock = 0,
    required this.avatar,
    required this.price_final,
    required this.price_final_text,
    this.userAmount = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
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
      userAmount: json['userAmount'],
    );
  }
}
