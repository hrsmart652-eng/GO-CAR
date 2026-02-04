class AllClientsModel {
  final bool success;
  final List<ClientModel> clients;

  AllClientsModel({
    required this.success,
    required this.clients,
  });

  factory AllClientsModel.fromJson(Map<String, dynamic> json) {
    return AllClientsModel(
      success: json['success'],
      clients: List<ClientModel>.from(
        json['data'].map((e) => ClientModel.fromJson(e)),
      ),
    );
  }
}

class ClientModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String role;
  final String invitationCode;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;

  ClientModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.invitationCode,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.image,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      invitationCode: json['invitationCode'] ?? '',
      isActive: json['isActive'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      image: json['image']??"",
    );
  }
  Map<String,dynamic> toJson(){
    return {
      "_id":id,
      "fullName":fullName,
      "phoneNumber":phoneNumber,
      "email":email,
      "role":role,
      "invitationCode":invitationCode,
      "isActive":isActive,
      "createdAt":createdAt,
      "updatedAt":updatedAt,
      "image":image
    };
  }
}

