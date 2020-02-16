import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/blocs/auth/auth_bloc.dart';
import 'package:tem_doacao_mobile/blocs/auth/auth_event.dart';
import 'package:tem_doacao_mobile/blocs/auth/auth_state.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/models/token_user.dart';
import 'package:tem_doacao_mobile/models/user.dart';
import 'package:tem_doacao_mobile/repositories/auth_repository.dart';
import 'package:tem_doacao_mobile/repositories/social_auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockSocialAuthRepository extends Mock implements SocialAuthRepository {}

void main() {
  AuthRepository authRepository;
  SocialAuthRepository socialAuthRepository;
  AuthBloc bloc;
  final AuthState initialState = Unauthenticated();
  // success
  final token = '123';
  final tokenUser = TokenUser(
    token: token,
    user: User(id: '1', name: 'user', photoUrl: '')
  );
  final Either<Failure, TokenUser> signInUp = Right(tokenUser);
  final Either<Failure, String> googleSignInSuccess = Right(token);

  void setUpSuccess() {
    when(authRepository.signInUp(any)).thenAnswer((_) async => signInUp);
    when(socialAuthRepository.googleSignIn()).thenAnswer((_) async => googleSignInSuccess);
  }

  setUp(() {
    authRepository = MockAuthRepository();
    socialAuthRepository = MockSocialAuthRepository();
    bloc = AuthBloc(authRepository, socialAuthRepository);
  });

  test('should initialize with correct initialState', () {
    expect(bloc.initialState, initialState);
  });

  group('when SignInUp', () {

    test('should use correctly the repositories', () async {
      setUpSuccess();

      bloc.add(SignInUp());

      await Future.delayed(Duration(seconds: 1));

      verify(socialAuthRepository.googleSignIn());
      verify(authRepository.signInUp(any));
    });

    test('should handle when everything works correctly', () {
      setUpSuccess();

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          Authenticating(),
          Authenticated(tokenUser: tokenUser),
        ])
      );

      bloc.add(SignInUp());
    });

    test('should handle when user cancel the process in the middle', () {
      when(socialAuthRepository.googleSignIn()).thenAnswer((_) async => Right(null));

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          Authenticating(),
          Unauthenticated(),
        ])
      );

      bloc.add(SignInUp());
    });

    test('should handle when occur an error in the google sign in', () {
      final exception = PlatformException(code: '10');
      final failure = Failure.from(exception);
      final Either<Failure, String> googleSignIn = Left(failure);
      when(socialAuthRepository.googleSignIn()).thenAnswer((_) async => googleSignIn);

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          Authenticating(),
          AuthenticationFail(message: failure.message),
        ])
      );

      bloc.add(SignInUp());
    });

    test('should handle when occur an error in the api auth', () {
      when(socialAuthRepository.googleSignIn()).thenAnswer((_) async => Right(token));
      final exception = SocketException('');
      final failure = Failure.from(exception);
      final Either<Failure, TokenUser> signInUp = Left(failure);
      when(authRepository.signInUp(token)).thenAnswer((_) async => signInUp);

      expectLater(
        bloc,
        emitsInOrder([
          initialState,
          Authenticating(),
          AuthenticationFail(message: failure.message),
        ])
      );

      bloc.add(SignInUp());
    });
  });

  group('when SignOut', () {
    test('should use socialAuthRepository.signOut', () async {
      bloc.add(SignOut());

      await Future.delayed(Duration(seconds: 1));

      verify(socialAuthRepository.googleSignOut());
    });

    test('with success', () async {
      setUpSuccess();

      bloc.add(SignInUp());

      await Future.delayed(Duration(seconds: 1));

      when(socialAuthRepository.googleSignOut()).thenAnswer((_) async => Right(null));

      expectLater(
        bloc,
        emitsInOrder([
          Authenticated(tokenUser: tokenUser),
          Unauthenticated(),
        ]),
      );

      bloc.add(SignOut());
    });

    // without feedback about error occurred in signout process
    // test('with failure', () async {});
  });
}
