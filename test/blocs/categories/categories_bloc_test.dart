import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/blocs/categories/categories_bloc.dart';
import 'package:tem_doacao_mobile/blocs/categories/categories_event.dart';
import 'package:tem_doacao_mobile/blocs/categories/categories_state.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/models/category.dart';
import 'package:tem_doacao_mobile/repositories/categories_repository.dart';

class MockCategoriesRepository extends Mock implements ICategoriesRepository {}

void main() {
  ICategoriesRepository repository;
  CategoriesBloc bloc;
  final CategoriesState initialState = CategoriesLoading();
  final Category category = Category(id: '1', name: 'category');

  setUp(() {
    repository = MockCategoriesRepository();
    bloc = CategoriesBloc(repository);
  });

  test('should initialize with correct initialState', () {
    expect(bloc.initialState, initialState);
  });

  group('when CategoriesLoad', () {
    // success
    final BuiltList<Category> categories = BuiltList.from([category]);
    final Either<Failure, BuiltList<Category>> repositoryGetAllSuccess = Right(categories);
    final CategoriesState categoriesLoaded = CategoriesLoaded(categories: categories);
    // fail
    final Failure failure = Failure.from(SocketException(''));
    final Either<Failure, BuiltList<Category>> repositoryGetAllFailure = Left(failure);
    final CategoriesState categoriesLoadFail = CategoriesLoadFail(message: failure.message);

    setUpSuccess() {
      when(repository.getAll()).thenAnswer((_) async => repositoryGetAllSuccess);
    }

    test('should use correct repository method', () async {
      setUpSuccess();

      bloc.add(CategoriesLoad());

      // wait to ensure that bloc uses repository for make the server request
      await Future.delayed(Duration(seconds: 1));

      verify(repository.getAll());
    });

    test('should handle when server request with success', () async {
      setUpSuccess();

      bloc.add(CategoriesLoad());

      await expectLater(
        bloc,
        emitsInOrder([CategoriesLoading(), categoriesLoaded])
      );
    });

    test('should handle when server request with failure', () {
      when(repository.getAll()).thenAnswer((_) async => repositoryGetAllFailure);

      expectLater(
        bloc.asBroadcastStream(),
        emitsInOrder([CategoriesLoading(), categoriesLoadFail])
      );

      bloc.add(CategoriesLoad());
    });
  });
}
