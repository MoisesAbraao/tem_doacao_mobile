import 'package:dio/dio.dart' as dio;

abstract class BaseRestApiRepository {
  dio.Dio get client;
  String get basePath;
}
