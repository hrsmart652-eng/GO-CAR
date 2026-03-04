class UserModel {
  String? id;
  String? email;
  String? role;

  UserModel({this.id, this.email, this.role});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String?,
    email: json['email'] as String?,
    role: json['role'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'role': role};
}