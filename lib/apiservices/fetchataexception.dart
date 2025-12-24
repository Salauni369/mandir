class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);

  @override
  String toString() => "FetchDataException: $message";
}

class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);

  @override
  String toString() => "BadRequestException: $message";
}

class UnauthorisedException implements Exception {
  final String message;
  UnauthorisedException(this.message);

  @override
  String toString() => "UnauthorisedException: $message";
}
