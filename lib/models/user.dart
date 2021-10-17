class User {
  var id;
  var name;
  var email;
  var token;

  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'],
    );
  }
}
