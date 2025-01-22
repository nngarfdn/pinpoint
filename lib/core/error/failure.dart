class Failure {
  final String message;

  const Failure(this.message);

  @override
  String toString() => message;
}

// Example specific failures
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}