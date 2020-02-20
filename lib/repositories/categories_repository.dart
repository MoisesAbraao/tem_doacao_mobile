import 'dart:async';
import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;

import '../core/base_repositories.dart';
import '../core/errors/failures.dart';
import '../models/category.dart';

abstract class ICategoriesRepository implements BaseRestApiRepository {
  Future<Either<Failure, BuiltList<Category>>> getAll();
  Future<Either<Failure, Category>> getById(String id);
}

class CategoriesRepository implements ICategoriesRepository {
  final dio.Dio _client;

  CategoriesRepository(this._client);

  @override
  String get basePath => 'categories/';

  @override
  dio.Dio get client => _client;

  @override
  Future<Either<Failure, BuiltList<Category>>> getAll() async {
    try {
      final dio.Response response = await client.get(basePath);

      final categories = (response.data as List)
        .map((category) => Category.fromJson(category))
        .toList()
        .build();

      return Right(categories);
    } catch (e) {
      return Left(Failure.from(e));
    }
  }

  @override
  Future<Either<Failure, Category>> getById(String id) async {
    try {
      final dio.Response response = await client.get('$basePath$id/');

      final category = Category.fromJson(response.data);

      return Right(category);
    } catch (e) {
      return Left(Failure.from(e));
    }
  }
}
