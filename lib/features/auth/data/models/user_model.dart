import 'package:nuli_app/features/auth/data/models/user_role.dart';

class UserModel{
  final String uid;
  final String email;
  final String displayName;
  final DateTime createdAt;
  final UserRole role;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.createdAt,
    required this.role,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String,
      role: UserRole.fromJson(json['role'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':uid,
      'email': email,
      'display_name': displayName,
      'role': role.toJson(),
      'created_at': createdAt.toIso8601String(),
    };
  }

}