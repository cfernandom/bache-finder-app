import 'package:bache_finder_app/features/auth/domain/entities/user.dart';

class UserMapper {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      roles: (json['role'] as List?)?.cast<String>() ?? [],
    );
  }
}