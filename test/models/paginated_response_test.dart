import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/models/paginated_response.dart';

import '../_fixtures/fixture.dart';

class _Response with EquatableMixin {
  final String id;

  _Response(this.id);

  factory _Response.fromJson(Map data) =>
    _Response(data['id'] as String);

  Map toJson() => {'id': id};

  @override
  List<Object> get props => [id];
}

void main() {
  final PaginatedResponse<_Response> paginatedResponse = PaginatedResponse(
    prev: 'prev',
    next: 'next',
    results: BuiltList.from([_Response('1')]),
  );
  final PaginatedResponse<_Response> paginatedResponseDiff = PaginatedResponse(
    prev: '_prev',
    next: '_next',
    results: BuiltList.from([_Response('2')]),
  );

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final PaginatedResponse<_Response> _paginatedResponse = paginatedResponse;

      expect(_paginatedResponse, paginatedResponse);
    });

    test('should be equals when same values and different objects', () {
      final PaginatedResponse<_Response> _paginatedResponse =
        PaginatedResponse<_Response>(
          prev: paginatedResponse.prev,
          next: paginatedResponse.next,
          results: paginatedResponse.results,
        );

      expect(_paginatedResponse, paginatedResponse);
    });

    group('should be different when differents values', () {
      test('field "prev"', () {
        final PaginatedResponse<_Response> _paginatedResponse =
          PaginatedResponse<_Response>(
            prev: paginatedResponseDiff.prev,
            next: paginatedResponse.next,
            results: paginatedResponse.results,
          );

        expect(_paginatedResponse, isNot(paginatedResponse));
      });

      test('field "next"', () {
        final PaginatedResponse<_Response> _paginatedResponse =
          PaginatedResponse<_Response>(
            prev: paginatedResponse.prev,
            next: paginatedResponseDiff.next,
            results: paginatedResponse.results,
          );

        expect(_paginatedResponse, isNot(paginatedResponse));
      });

      test('field "results"', () {
        final PaginatedResponse<_Response> _paginatedResponse =
          PaginatedResponse<_Response>(
            prev: paginatedResponse.prev,
            next: paginatedResponse.next,
            results: paginatedResponseDiff.results,
          );

        expect(_paginatedResponse, isNot(paginatedResponse));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map paginatedResponseMap = fixtureAsMap('paginated_response.json');
      final PaginatedResponse<_Response> paginatedResponse =
        PaginatedResponse<_Response>.fromJson(
          paginatedResponseMap,
          (data) => _Response.fromJson(data)
        );

      expect(paginatedResponse.prev, paginatedResponseMap['prev']);
      expect(paginatedResponse.next, paginatedResponseMap['next']);
      expect(
        paginatedResponse.results,
        (paginatedResponseMap['results'] as List)
          .map((data) => _Response.fromJson(data))
          .toBuiltList()
      );
    });

    test('toJson', () {
      final _paginatedResponse = paginatedResponse.toJson();

      expect(_paginatedResponse['prev'], paginatedResponse.prev);
      expect(_paginatedResponse['next'], paginatedResponse.next);
      expect((_paginatedResponse['results'] as List).length, 1);
      expect(
        (_paginatedResponse['results'] as List).first['id'],
        paginatedResponse.results.first.id
      );
    });

    test('should build the same object when toJson and fromJson combined', () {
      expect(
        paginatedResponse,
        PaginatedResponse.fromJson(
          paginatedResponse.toJson(),
          (data) => _Response.fromJson(data)
        )
      );
    });
  });

  test('string representation', () {
    final stringRepresentation = paginatedResponse.toString();

    final startRepresentation = '${paginatedResponse.runtimeType.toString()} {';

    expect(stringRepresentation.startsWith(startRepresentation), true);
  });
}
