import 'package:lectura/core/failures.dart';

abstract class ServerException implements Exception {
  Failure get failure;
}

class GenericException extends ServerException {
  @override
  Failure get failure => GenericFailure();
}

abstract class CacheException implements Exception {
  Failure get failure;
}