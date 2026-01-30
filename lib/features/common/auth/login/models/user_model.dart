class User {
  String? id;
  String? email;
  String? role;

  User({this.id, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String?,
    email: json['email'] as String?,
    role: json['role'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'role': role};
}