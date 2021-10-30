class User {
  String id;
  String name;
  String email;
  String phone;
  String token;

  User({this.id, this.name, this.email, this.phone, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as String,
      name: json["name"] as String,
      email: json["email"] as String,
      phone: json["phone"] as String,
      token: json["token"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'token': token,
      };
}
