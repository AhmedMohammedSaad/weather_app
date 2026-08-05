/// Abstract class representing base domain failures.
abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({required this.message, this.statusCode});
}

/// Represents server-side HTTP or API errors.
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.statusCode});
}

/// Represents network connectivity failures (e.g. no internet connection, timeouts).
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.statusCode});
}

/// Represents failures related to local cache storage.
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.statusCode});
}

/// Represents validation failures when an invalid city name is searched.
class InvalidCityFailure extends Failure {
  const InvalidCityFailure({required super.message, super.statusCode});
}

/// Represents unhandled or unexpected system failures.
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.statusCode});
}
