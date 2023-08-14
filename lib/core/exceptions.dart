import 'package:lectura/core/failures.dart';

abstract class ServerException implements Exception {
  Failure get failure;
}

abstract class CacheException implements Exception {
  Failure get failure;
}