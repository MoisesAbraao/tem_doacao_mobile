import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/models/category.dart';
import 'package:tem_doacao_mobile/repositories/categories_repository.dart';
import 'package:built_collection/built_collection.dart';

class MockHttpClient extends Mock implements dio.Dio {}

void main() {
  dio.Dio client;
  CategoriesRepository repository;
  final Category category = Category(id: '1', name: 'category');
  final String baseUrl = 'categories/';
  final resultException = SocketException('Without internet connection!');

  setUp(() {
    client = MockHttpClient();
    repository = CategoriesRepositoryImpl(client);
  });

  group('getAll', () {
    final resultSuccess = [category].build();
    final dataSuccess = resultSuccess
      .map((result) => result.toJson())
      .toList();

    void setUpSuccess() {
      when(client.get(baseUrl))
        .thenAnswer((_) async => dio.Response(data: dataSuccess));
    }

    test('should client.get use just baseUrl when requesting', () async {
      setUpSuccess();

      await repository.getAll();

      verify(client.get(baseUrl));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.getAll();

      expect(result, Right(resultSuccess));
    });

    test('with failure', () async {
      when(client.get(baseUrl)).thenThrow(resultException);

      final result = await repository.getAll();

      expect(result, Left(Failure.from(resultException)));
    });
  });

  group('getById', () {
    final basePathWithCategoryId = '$baseUrl${category.id}/';

    void setUpSuccess() {
      when(client.get(basePathWithCategoryId))
        .thenAnswer((_) async => dio.Response(data: category.toJson()));
    }

    test('should use the right path', () async {
      setUpSuccess();

      await repository.getById(category.id);

      verify(client.get(basePathWithCategoryId));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.getById(category.id);

      expect(result, Right(category));
    });

    test('with failure', () async {
      when(client.get(basePathWithCategoryId)).thenThrow(resultException);

      final result = await repository.getById(category.id);

      expect(result, Left(Failure.from(resultException)));
    });
  });
}
