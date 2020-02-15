import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/models/category.dart';

import '../_fixtures/fixture.dart';

void main() {
  final Category category = Category(id: '1', name: 'category');
  final Category categoryDiff = Category(id: '2', name: 'other category');

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final Category _category = category;

      expect(category, _category);
    });

    test('should be equals when same values and different objects', () {
      final Category _category = Category(id: category.id, name: category.name);

      expect(category, _category);
    });

    group('should be different when differents values', () {
      test('field "id"', () {
        final Category _category = Category(id: categoryDiff.id, name: category.name);

        expect(category, isNot(_category));
      });

      test('field "name"', () {
        final Category _category = Category(id: category.id, name: categoryDiff.name);

        expect(category, isNot(_category));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map categoryMap = fixtureAsMap('category.json');
      final Category category = Category.fromJson(categoryMap);

      expect(category.id, categoryMap['id']);
      expect(category.name, categoryMap['name']);
    });

    test('toJson', () {
      final _category = category.toJson();

      expect(category.id, _category['id']);
      expect(category.name, _category['name']);
    });
  });

  group('clone tests', () {
    group('copyWith', () {
      test('without fields', () {
        final Category _category = category.copyWith();

        expect(_category, category);
        expect(identical(_category, category), false);
      });

      test('field "id"', () {
        final Category _category = category.copyWith(id: categoryDiff.id);

        expect(_category.id, categoryDiff.id);
      });

      test('field "name"', () {
        final Category _category = category.copyWith(name: categoryDiff.name);

        expect(_category.name, categoryDiff.name);
      });
    });
  });
}
