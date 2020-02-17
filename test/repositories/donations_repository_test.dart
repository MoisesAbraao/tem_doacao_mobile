import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/models/category.dart';
import 'package:tem_doacao_mobile/models/donation.dart';
import 'package:tem_doacao_mobile/models/donation_status.dart';
import 'package:tem_doacao_mobile/models/paginated_response.dart';
import 'package:tem_doacao_mobile/models/user.dart';
import 'package:tem_doacao_mobile/repositories/donations_repository.dart';
import 'package:built_collection/built_collection.dart';

class MockHttpClient extends Mock implements dio.Dio {}

void main() {
  dio.Dio client;
  DonationsRepository repository;
  final Donation donation = Donation(
    id: '1',
    description: 'donation description',
    longDescription: 'donation long description',
    category: Category(id: '1', name: 'category'),
    donor: User(id: '1', name: 'username', photoUrl: ''),
    status: DonationStatus.started,
    images: BuiltList.from([]),
    startedAt: DateTime.now(),
    finalizedAt: null,
    canceledAt: DateTime.now(),
    updatedAt: null,
  );
  final String baseUrl = 'donations/';
  final resultException = SocketException('Without internet connection!');

  setUp(() {
    client = MockHttpClient();
    repository = DonationsRepositoryImpl(client);
  });

  group('getById', () {
    setUpSuccess() {
      when(client.get('$baseUrl${donation.id}/'))
        .thenAnswer((_) async => dio.Response(data: donation.toJson()));
    }

    test('should use right resource path', () async {
      setUpSuccess();

      await repository.getById(donation.id);

      verify(client.get('$baseUrl${donation.id}/'));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.getById(donation.id);

      expect(result, Right(donation));
    });

    test('with failure', () async {
      when(client.get('$baseUrl${donation.id}/')).thenThrow(resultException);

      final result = await repository.getById(donation.id);

      expect(result, Left(Failure.from(resultException)));
    });
  });

  group('search', () {
    final queryText = 'categ';
    final url = '$baseUrl?search=$queryText';
    final resultSuccess = PaginatedResponse(
      next: null,
      prev: null,
      results: [donation].build(),
    );
    final dataSuccess = resultSuccess.toJson();

    setUpSuccess() {
      when(client.get(url))
        .thenAnswer((_) async => dio.Response(data: dataSuccess));
    }

    test('should use right resource path and search query string', () async {
      setUpSuccess();

      await repository.search(queryText);

      verify(client.get(url));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.search(queryText);

      expect(result, Right(resultSuccess));
    });

    test('with failure', () async {
      when(client.get(url)).thenThrow(resultException);

      final result = await repository.search(queryText);

      expect(result, Left(Failure.from(resultException)));
    });
  });

  group('getRecents', () {
    final resultSuccess = PaginatedResponse(
      next: null,
      prev: null,
      results: [donation].build(),
    );
    final dataSuccess = resultSuccess.toJson();

    setUpSuccess() {
      when(client.get(baseUrl))
        .thenAnswer((_) async => dio.Response(data: dataSuccess));
    }

    test('should use only resource base path', () async {
      setUpSuccess();

      await repository.getRecents();

      verify(client.get(baseUrl));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.getRecents();

      expect(result, Right(resultSuccess));
    });

    test('with failure', () async {
      when(client.get(baseUrl)).thenThrow(resultException);

      final result = await repository.getRecents();

      expect(result, Left(Failure.from(resultException)));
    });
  });

  group('getByCursor', () {
    final cursor = base64.encode(utf8.encode('last donation'));
    final url = '$baseUrl?cursor=$cursor';
    final resultSuccess = PaginatedResponse(
      next: null,
      prev: 'old url',
      results: [donation].build(),
    );
    final dataSuccess = resultSuccess.toJson();

    setUpSuccess() {
      when(client.get(url))
        .thenAnswer((_) async => dio.Response(data: dataSuccess));
    }

    test('should use right resource path and cursor query string', () async {
      setUpSuccess();

      await repository.getByCursor(cursor);

      verify(client.get(url));
    });

    test('with success', () async {
      setUpSuccess();

      final result = await repository.getByCursor(cursor);

      expect(result, Right(resultSuccess));
    });

    test('with failure', () async {
      when(client.get(url)).thenThrow(resultException);

      final result = await repository.getByCursor(cursor);

      expect(result, Left(Failure.from(resultException)));
    });
  });

}
