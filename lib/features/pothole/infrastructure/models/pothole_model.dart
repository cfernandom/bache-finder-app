import 'package:bache_finder_app/features/pothole/domain/entities/pothole.dart';

class PotholeModel extends Pothole {
  PotholeModel({
    required super.id,
    required super.type,
    required super.address,
    required super.locality,
    required super.image,
    required super.userId,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.latitude,
    required super.longitude,
    super.description,
    super.predictions,
    super.solutionDescription,
  });

  factory PotholeModel.fromJson(Map<String, dynamic> json) {
    return PotholeModel(
      id: json['id'].toString(),
      type: json['type'],
      address: json['address'],
      locality: json['locality'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      image: json['image'],
      status: json['status'],
      userId: json['user_id'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      description: json['description'],
      predictions: json['predictions'] != null
        ? List<double>.from(json['predictions'])
        : null,
      solutionDescription: json['solution_description'],
    );
  }
}