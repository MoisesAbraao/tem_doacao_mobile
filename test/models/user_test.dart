import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/models/user.dart';

import '../_fixtures/fixture.dart';

void main() {
  final User user = User(id: '1', name: 'user', photoUrl: '');
  final User userDiff = User(id: '2', name: 'other user', photoUrl: 'https://www.domain.com/storage/image.jpg');

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final User _user = user;

      expect(user, _user);
    });

    test('should be equals when same values and different objects', () {
      final User _user = User(id: user.id, name: user.name, photoUrl: user.photoUrl);

      expect(user, _user);
    });

    group('should be different when differents values', () {
      test('field "id"', () {
        final User _user = User(id: userDiff.id, name: user.name, photoUrl: user.photoUrl);

        expect(user, isNot(_user));
      });

      test('field "name"', () {
        final User _user = User(id: user.id, name: userDiff.name, photoUrl: user.photoUrl);

        expect(user, isNot(_user));
      });

      test('field "photoUrl"', () {
        final User _user = User(id: user.id, name: user.name, photoUrl: userDiff.photoUrl);

        expect(user, isNot(_user));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map userMap = fixtureAsMap('user.json');
      final User user = User.fromJson(userMap);

      expect(user.id, userMap['id']);
      expect(user.name, userMap['name']);
      expect(user.photoUrl, userMap['photo_url']);
    });

    test('toJson', () {
      final _user = user.toJson();

      expect(user.id, _user['id']);
      expect(user.name, _user['name']);
      expect(user.photoUrl, _user['photo_url']);
    });
  });

  group('clone tests', () {
    group('copyWith', () {
      test('without fields', () {
        final User _user = user.copyWith();

        expect(_user, user);
        expect(identical(_user, user), false);
      });

      test('field "id"', () {
        final User _user = user.copyWith(id: userDiff.id);

        expect(_user.id, userDiff.id);
      });

      test('field "name"', () {
        final User _user = user.copyWith(name: userDiff.name);

        expect(_user.name, userDiff.name);
      });

      test('field "photoUrl"', () {
        final User _user = user.copyWith(photoUrl: userDiff.photoUrl);

        expect(_user.photoUrl, userDiff.photoUrl);
      });
    });
  });
}
