import 'package:bache_finder_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      email: json['email'],
      name: json['name'],
    );
  }
}