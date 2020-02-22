import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

import '../core/base_repositories.dart';
import '../core/errors/failures.dart';
import '../models/donation.dart';
import '../models/paginated_response.dart';

abstract class IDonationsRepository implements BaseRestApiRepository {
  Future<Either<Failure, Donation>> getById(String id);

  Future<Either<Failure, PaginatedResponse<Donation>>> search(String query);

  Future<Either<Failure, PaginatedResponse<Donation>>> getRecents();

  Future<Either<Failure, PaginatedResponse<Donation>>> getByCursor(String cursor);
}

class DonationsRepository implements IDonationsRepository {
  final dio.Dio _client;

  DonationsRepository(this._client);

  @override
  String get basePath => 'donations/';

  @override
  dio.Dio get client => _client;

  @override
  Future<Either<Failure, Donation>> getById(String id) async {
    try {
      final dio.Response response = await client.get('$basePath$id/');

      final donation = Donation.fromJson(response.data);

      return Right(donation);
    } catch(e) {
      return Left(Failure.from(e));
    }
  }

  Future<Either<Failure, PaginatedResponse<Donation>>> _getWithPath(String path) async {
    try {
      final dio.Response response = await client.get(path);

      final PaginatedResponse<Donation> paginatedResponse = PaginatedResponse
        .fromJson(response.data, (data) => Donation.fromJson(data));

      return Right(paginatedResponse);
    } catch(e) {
      return Left(Failure.from(e));
    }
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> search(String query) {
    return _getWithPath('$basePath?search=$query');
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> getByCursor(String cursor) {
    return _getWithPath('$basePath?cursor=$cursor');
  }

  @override
  Future<Either<Failure, PaginatedResponse<Donation>>> getRecents() {
    return _getWithPath('$basePath');
  }
}
