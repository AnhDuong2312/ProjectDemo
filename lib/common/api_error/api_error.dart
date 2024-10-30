class ApiError implements Exception {
  final String message;

  ApiError(this.message);

  @override
  String toString() {
    return message;
  }
}

class ServerError implements Exception {
  final String message;

  ServerError(this.message);

  @override
  String toString() {
    return message;
  }
}
