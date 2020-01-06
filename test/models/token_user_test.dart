import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/models/token_user.dart';
import 'package:tem_doacao_mobile/models/user.dart';

import '../_fixtures/fixture.dart';

void main() {
  final User user = User(id: '1', name: 'user', photoUrl: 'https://www.domain.com/storage/user1.jpg');
  final User userDiff = User(id: '2', name: 'other user', photoUrl: 'https://www.domain.com/storage/user2.jpg');
  final String token = '123';
  final String tokenDiff = '321';
  final TokenUser tokenUser = TokenUser(token: token, user: user);
  final TokenUser tokenUserDiff = TokenUser(token: tokenDiff, user: userDiff);

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final TokenUser _tokenUser = tokenUser;

      expect(_tokenUser, tokenUser);
    });

    test('should be equals when same values and different objects', () {
      final TokenUser _tokenUser = TokenUser(token: tokenUser.token, user: tokenUser.user);

      expect(_tokenUser, tokenUser);
    });

    group('should be different when differents values', () {
      test('field "token"', () {
        final TokenUser _tokenUser = TokenUser(token: tokenUserDiff.token, user: tokenUser.user);

        expect(_tokenUser, isNot(tokenUser));
      });

      test('field "user"', () {
        final TokenUser _tokenUser = TokenUser(token: tokenUser.token, user: tokenUserDiff.user);

        expect(_tokenUser, isNot(tokenUser));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map tokenUserMap = fixtureAsMap('test/_fixtures/token_user.json');
      final TokenUser _tokenUser = TokenUser.fromJson(tokenUserMap);

      expect(_tokenUser.token, tokenUserMap['token']);
      expect(_tokenUser.user.toJson(), tokenUserMap['user']);
    });

    test('toJson', () {
      final _tokenUser = tokenUser.toJson();

      expect(_tokenUser['token'], tokenUser.token);
      expect(_tokenUser['user'], tokenUser.user.toJson());
    });
  });

  group('clone tests', () {
    group('copyWith', () {
      test('without fields', () {
        final TokenUser _tokenUser = tokenUser.copyWith();

        expect(_tokenUser, tokenUser);
        expect(identical(_tokenUser, tokenUser), false);
      });

      test('field "token"', () {
        final TokenUser _tokenUser = tokenUser.copyWith(token: tokenUserDiff.token);

        expect(_tokenUser.token, tokenUserDiff.token);
      });

      test('field "user"', () {
        final TokenUser _tokenUser = tokenUser.copyWith(user: tokenUserDiff.user);

        expect(_tokenUser.user, tokenUserDiff.user);
      });
    });
  });
}
