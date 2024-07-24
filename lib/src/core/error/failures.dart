abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure()
      : super("Server Failure: Unable to fetch data from the server.");
}

class CacheFailure extends Failure {
  CacheFailure()
      : super("Cache Failure: Unable to fetch data from the local cache.");
}

class NetworkFailure extends Failure {
  NetworkFailure() : super("Network Failure: No internet connection.");
}
