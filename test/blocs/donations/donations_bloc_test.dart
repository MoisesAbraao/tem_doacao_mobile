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
      bloc.add(DonationsLoad());

      await Future.delayed(Duration(seconds: 1));

      verify(repository.getRecents());
    });

    test('with success', () {
      final loaded = DonationsLoaded(
        donations: paginatedResponse.results,
        nextCursor: paginatedResponse.nextCursor,
        loadingMore: false,
        errorMessage: '',
      );
      when(repository.getRecents()).thenAnswer((_) async => Right(paginatedResponse));

      expect(bloc, emitsInOrder([initialState, loaded]));

      bloc.add(DonationsLoad());
    });

    test('with fail', () {
      final failure = Failure.from(SocketException(''));
      final loaded = DonationsLoaded(
        donations: BuiltList.from([]),
        nextCursor: '',
        loadingMore: false,
        errorMessage: failure.message,
      );
      when(repository.getRecents()).thenAnswer((_) async => Left(failure));

      expect(bloc, emitsInOrder([initialState, loaded]));

      bloc.add(DonationsLoad());
    });
  });

  group('when LoadMore', () {
    final failure = Failure.from(SocketException(''));
    final loading = DonationsLoading();
    final loaded = DonationsLoaded(
      donations: paginatedResponse.results,
      nextCursor: paginatedResponse.nextCursor,
      loadingMore: false,
      errorMessage: '',
    );
    final loadedLoadingMore = loaded.copyWith(
      loadingMore: true,
      errorMessage: '',
    );
    final loadedMore = loaded.copyWith(
      donations: loaded.donations
        .rebuild((updates) => updates.addAll(paginatedResponse.results)),
      nextCursor: paginatedResponse.nextCursor,
      loadingMore: false,
      errorMessage: ''
    );
    final loadedMoreWithError = loaded.copyWith(
      loadingMore: false,
      errorMessage: failure.message,
    );

    setUpStateToLoadMore() {
      when(repository.getRecents()).thenAnswer((_) async => Right(paginatedResponse));

      bloc.add(DonationsLoad());
    }

    test('should uses the right repository method', () async {
      setUpStateToLoadMore();

      bloc.add(DonationsLoadMore(cursor: 'cursor'));

      await Future.delayed(Duration(seconds: 1));

      verify(repository.getByCursor(any));
    });

    test('with success', () async {
      setUpStateToLoadMore();

      when(repository.getByCursor(any)).thenAnswer((_) async => Right(paginatedResponse));

      expectLater(bloc, emitsInOrder([loading, loaded, loadedLoadingMore, loadedMore]));

      bloc.add(DonationsLoadMore(cursor: paginatedResponse.nextCursor));
    });

    test('with fail', () {
      setUpStateToLoadMore();

      when(repository.getByCursor(any)).thenAnswer((_) async => Left(failure));

      expectLater(bloc, emitsInOrder([loading, loaded, loadedLoadingMore, loadedMoreWithError]));

      bloc.add(DonationsLoadMore(cursor: paginatedResponse.nextCursor));
    });
  });
}
