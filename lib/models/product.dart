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

  Product({
    this.id,
    this.name,
    this.title,
    this.category_id,
    this.description,
    this.price,
    this.discount,
    this.discount_type,
    this.currency,
    this.in_stock,
    this.avatar,
    this.price_final,
    this.price_final_text,
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
    );
  }
}
