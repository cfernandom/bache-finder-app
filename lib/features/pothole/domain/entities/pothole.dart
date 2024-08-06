class Pothole {
  final String id;
  final String type;
  final String address;
  final String locality;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String userId;
  final double latitude;
  final double longitude;
  final String? description;
  final List<double>? weights;
  final String? solutionDescription;

  Pothole({
    required this.id,
    required this.type,
    required this.address,
    required this.locality,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.latitude,
    required this.longitude,
    this.description,
    this.weights,
    this.solutionDescription,
  });
}
