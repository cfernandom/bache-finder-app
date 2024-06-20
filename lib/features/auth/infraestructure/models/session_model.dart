import 'package:bache_finder_app/features/auth/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({
    required super.token
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      token: json['token']
    );
  }
}
