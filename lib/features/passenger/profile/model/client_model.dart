class ClientModel {
  String? id;
  String? fullName;
  String? phoneNumber;
  String? email;
  String? role;
  String? invitationCode;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  final image;

  ClientModel({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.role,
    this.invitationCode,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json['data']['_id'] as String?,
    fullName: json['data']['fullName'] as String?,
    phoneNumber: json['data']['phoneNumber'] as String?,
    email: json['data']['email'] as String?,
    role: json['data']['role'] as String?,
    invitationCode: json['data']['invitationCode'] as String?,
    isActive: json['data']['isActive'] as bool?,
    createdAt:
        json['data']['createdAt'] == null
            ? null
            : DateTime.parse(json['data']['createdAt'] as String),
    updatedAt:
        json['data']['updatedAt'] == null
            ? null
            : DateTime.parse(json['data']['updatedAt'] as String),
    image: json['data']['image'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'email': email,
    'role': role,
    'invitationCode': invitationCode,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    'image': image,
  };
}
