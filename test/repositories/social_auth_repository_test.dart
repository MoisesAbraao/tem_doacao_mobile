import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:tem_doacao_mobile/core/errors/failures.dart';
import 'package:tem_doacao_mobile/repositories/social_auth_repository.dart';

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  GoogleSignIn googleSignIn;
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  SocialAuthRepository repository;
  final googleAccessToken = 'google access token';
  final exception = PlatformException(code: '10', message: 'Occur an error');
  final failure = Failure.from(exception);

  setUp(() {
    googleSignIn = MockGoogleSignIn();
    googleSignInAccount = MockGoogleSignInAccount();
    googleSignInAuthentication = MockGoogleSignInAuthentication();
    repository = SocialAuthRepositoryImpl(googleSignIn);
  });

  group('googleSignIn', () {
    test('with success', () async {
      when(googleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);
      when(googleSignInAccount.authentication)
        .thenAnswer((_) async => googleSignInAuthentication);
      when(googleSignInAuthentication.accessToken).thenReturn(googleAccessToken);

      final result = await repository.googleSignIn();

      verify(googleSignIn.signIn());
      verify(googleSignInAccount.authentication);
      verify(googleSignInAuthentication.accessToken);
      expect(result, Right(googleAccessToken));
    });

    test('with user cancellation', () async {
      when(googleSignIn.signIn()).thenAnswer((_) async => null);

      final result = await repository.googleSignIn();

      expect(result, Right(null));
    });

    test('with failure', () async {
      when(googleSignIn.signIn()).thenThrow(PlatformException(code: '10'));

      final result = await repository.googleSignIn();

      expect(result, Left(failure));
    });
  });

  group('googleSignOut', () {
    test('with success', () async {
      when(repository.googleSignOut()).thenAnswer((_) async => null);

      final result = await repository.googleSignOut();

      verify(googleSignIn.signOut());
      expect(result, Right(null));
    });

    test('with failure', () async {
      when(repository.googleSignOut()).thenThrow(exception);

      final result = await repository.googleSignOut();

      expect(result, Left(failure));
    });
  });
}
