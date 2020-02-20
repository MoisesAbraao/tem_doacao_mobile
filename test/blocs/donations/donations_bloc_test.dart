import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/blocs/donations/donations_bloc.dart';
import 'package:tem_doacao_mobile/blocs/donations/donations_event.dart';
import 'package:tem_doacao_mobile/blocs/donations/donations_state.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/models/donation.dart';
import 'package:tem_doacao_mobile/models/paginated_response.dart';
import 'package:tem_doacao_mobile/repositories/donations_repository.dart';

import '../../_fixtures/fixture.dart';

class MockDonationsRepository extends Mock implements IDonationsRepository {}

void main() {
  IDonationsRepository repository;
  DonationsBloc bloc;
  final DonationsState initialState = DonationsLoading();
  final Map donationMap = fixtureAsMap('donation.json');
  final Donation donation = Donation.fromJson(donationMap);
  final paginatedResponse = PaginatedResponse(
    prev: null,
    next: 'https://domain.com/api/donations?cursor=cursor',
    results: [donation].toBuiltList(),
  );

  setUp(() {
    repository = MockDonationsRepository();
    bloc = DonationsBloc(repository);
  });

  test('should initialize with correct initialState', () {
    expect(bloc.initialState, initialState);
  });

  group('when Load', () {
    test('should uses the right repository method', () async {
      bloc.add(Load());

      await Future.delayed(Duration(seconds: 1));

      verify(repository.getRecents());
    });

    test('with success', () {
      final loaded = DonationsLoaded(
        donations: paginatedResponse.results,
        nextCursor: paginatedResponse.nextCursor,
        errorMessage: '',
      );
      when(repository.getRecents()).thenAnswer((_) async => Right(paginatedResponse));

      expect(bloc, emitsInOrder([initialState, loaded]));

      bloc.add(Load());
    });

    test('with fail', () {
      final failure = Failure.from(SocketException(''));
      final loaded = DonationsLoaded(
        donations: BuiltList.from([]),
        nextCursor: '',
        errorMessage: failure.message,
      );
      when(repository.getRecents()).thenAnswer((_) async => Left(failure));

      expect(bloc, emitsInOrder([initialState, loaded]));

      bloc.add(Load());
    });
  });
}
