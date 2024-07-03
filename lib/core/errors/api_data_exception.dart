class ApiDataException implements Exception {
  final String message;

  ApiDataException(this.message);

  @override
  String toString() => message;
}
