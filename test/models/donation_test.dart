import 'package:built_collection/built_collection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/core/parses.dart';
import 'package:tem_doacao_mobile/models/category.dart';
import 'package:tem_doacao_mobile/models/donation.dart';
import 'package:tem_doacao_mobile/models/donation_image.dart';
import 'package:tem_doacao_mobile/models/donation_status.dart';
import 'package:tem_doacao_mobile/models/user.dart';

import '../_fixtures/fixture.dart';

void main() {
  final Category category = Category(id: '1', name: 'category');
  final Category categoryDiff = Category(id: '2', name: 'other category');
  final User user = User(id: '1', name: 'user1', photoUrl: 'https://www.domain.com/storage/user1.jpg');
  final User userDiff = User(id: '2', name: 'user2', photoUrl: 'https://www.domain.com/storage/user2.jpg');
  final DonationImage image = DonationImage(id: '1', imageUrl: 'https://www.domain.com/storage/image1.jpg');
  final DonationImage imageDiff = DonationImage(id: '2', imageUrl: 'https://www.domain.com/storage/image2.jpg');
  final Donation donation = Donation(
    id: '1',
    description: 'description',
    longDescription: 'long description',
    category: category,
    donor: user,
    status: DonationStatus.started,
    images: [image].build(),
    startedAt: DateTime(2020, 1, 1),
    finalizedAt: DateTime(2020, 1, 1),
    canceledAt: DateTime(2020, 1, 1),
    updatedAt: DateTime(2020, 1, 1),
  );
  final Donation donationDiff = Donation(
    id: '2',
    description: 'description2',
    longDescription: 'long description2',
    category: categoryDiff,
    donor: userDiff,
    status: DonationStatus.finalized,
    images: [imageDiff].build(),
    startedAt: DateTime(2020, 2, 1),
    finalizedAt: DateTime(2020, 2, 1),
    canceledAt: DateTime(2020, 2, 1),
    updatedAt: DateTime(2020, 2, 1),
  );

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final Donation _donation = donation;

      expect(donation, _donation);
    });

    test('should be equals when same values and different objects', () {
      final Donation _donation = Donation(
        id: donation.id,
        description: donation.description,
        longDescription: donation.longDescription,
        category: donation.category,
        donor: donation.donor,
        status: donation.status,
        images: donation.images,
        startedAt: donation.startedAt,
        finalizedAt: donation.finalizedAt,
        canceledAt: donation.canceledAt,
        updatedAt: donation.updatedAt,
      );

      expect(donation, _donation);
    });

    group('should be different when differents values', () {
      Donation cloneDonationWith({
        String id,
        String description,
        String longDescription,
        Category category,
        User donor,
        DonationStatus status,
        BuiltList<DonationImage> images,
        DateTime startedAt,
        DateTime finalizedAt,
        DateTime canceledAt,
        DateTime updatedAt,
      }) =>
        Donation(
          id: id ?? donation.id,
          description: description ?? donation.description,
          longDescription: longDescription ?? donation.longDescription,
          category: category ?? donation.category,
          donor: donor ?? donation.donor,
          status: status ?? donation.status,
          images: images ?? donation.images,
          startedAt: startedAt ?? donation.startedAt,
          finalizedAt: finalizedAt ?? donation.finalizedAt,
          canceledAt: canceledAt ?? donation.canceledAt,
          updatedAt: updatedAt ?? donation.updatedAt,
        );

      test('field "id"', () {
        final Donation _donation = cloneDonationWith(id: donationDiff.id);

        expect(donation, isNot(_donation));
      });

      test('field "description"', () {
        final Donation _donation = cloneDonationWith(description: donationDiff.description);

        expect(donation, isNot(_donation));
      });

      test('field "longDescription"', () {
        final Donation _donation = cloneDonationWith(longDescription: donationDiff.longDescription);

        expect(donation, isNot(_donation));
      });

      test('field "category"', () {
        final Donation _donation = cloneDonationWith(category: donationDiff.category);

        expect(donation, isNot(_donation));
      });

      test('field "donor"', () {
        final Donation _donation = cloneDonationWith(donor: donationDiff.donor);

        expect(donation, isNot(_donation));
      });

      test('field "images"', () {
        final Donation _donation = cloneDonationWith(images: donationDiff.images);

        expect(donation, isNot(_donation));
      });

      test('field "startedAt"', () {
        final Donation _donation = cloneDonationWith(startedAt: donationDiff.startedAt);

        expect(donation, isNot(_donation));
      });

      test('field "finalizedAt"', () {
        final Donation _donation = cloneDonationWith(finalizedAt: donationDiff.finalizedAt);

        expect(donation, isNot(_donation));
      });

      test('field "canceledAt"', () {
        final Donation _donation = cloneDonationWith(canceledAt: donationDiff.canceledAt);

        expect(donation, isNot(_donation));
      });

      test('field "updatedAt"', () {
        final Donation _donation = cloneDonationWith(updatedAt: donationDiff.updatedAt);

        expect(donation, isNot(_donation));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map donationMap = fixtureAsMap('test/_fixtures/donation.json');
      final Donation donation = Donation.fromJson(donationMap);

      expect(donation.id, donationMap['id']);
      expect(donation.description, donationMap['description']);
      expect(donation.longDescription, donationMap['long_description']);
      // expect(donation.category.toJson(), donationMap['category']);
      // expect(donation.donor.toJson(), donationMap['donor']);
      expect(donation.status, parseDonationStatusStringToDonationStatus(donationMap['status']));
      // expect(donation.images.map((image) => image.toJson()).toList(), donationMap['images']);
      expect(donation.startedAt.toIso8601String(), donationMap['started_at']);
      expect(donation.finalizedAt.toIso8601String(), donationMap['finalized_at']);
      expect(donation.canceledAt.toIso8601String(), donationMap['canceled_at']);
      expect(donation.updatedAt.toIso8601String(), donationMap['updated_at']);
    });

    test('toJson', () {
      final _donation = donation.toJson();

      expect(_donation['id'], donation.id);
      expect(_donation['description'], donation.description);
      expect(_donation['long_description'], donation.longDescription);
      // expect(_donation['category'], donation.category.toJson());
      // expect(_donation['donor'], donation.donor.toJson());
      expect(_donation['status'], parseDonationStatusToDonationStatusString(donation.status));
      // expect(_donation['images'], donation.images.map((image) => image.toJson()).toList());
      expect(_donation['started_at'], donation.startedAt.toIso8601String());
      expect(_donation['finalized_at'], donation.finalizedAt.toIso8601String());
      expect(_donation['canceled_at'], donation.canceledAt.toIso8601String());
      expect(_donation['updated_at'], donation.updatedAt.toIso8601String());
    });
  });

  group('clone tests', () {
    group('copyWith', () {
      test('without fields', () {
        final Donation _donation = donation.copyWith();

        expect(_donation, donation);
        expect(identical(_donation, donation), false);
      });

      test('field "id"', () {
        final Donation _donation = donation.copyWith(id: donationDiff.id);

        expect(_donation.id, donationDiff.id);
      });

      test('field "description"', () {
        final Donation _donation = donation.copyWith(description: donationDiff.description);

        expect(_donation.description, donationDiff.description);
      });

      test('field "longDescription"', () {
        final Donation _donation = donation.copyWith(longDescription: donationDiff.longDescription);

        expect(_donation.longDescription, donationDiff.longDescription);
      });

      test('field "category"', () {
        final Donation _donation = donation.copyWith(category: donationDiff.category);

        expect(_donation.category, donationDiff.category);
      });

      test('field "donor"', () {
        final Donation _donation = donation.copyWith(donor: donationDiff.donor);

        expect(_donation.donor, donationDiff.donor);
      });

      test('field "status"', () {
        final Donation _donation = donation.copyWith(status: donationDiff.status);

        expect(_donation.status, donationDiff.status);
      });

      test('field "images"', () {
        final Donation _donation = donation.copyWith(images: donationDiff.images);

        expect(_donation.images, donationDiff.images);
      });

      test('field "startedAt"', () {
        final Donation _donation = donation.copyWith(startedAt: donationDiff.startedAt);

        expect(_donation.startedAt, donationDiff.startedAt);
      });

      test('field "finalizedAt"', () {
        final Donation _donation = donation.copyWith(finalizedAt: donationDiff.finalizedAt);

        expect(_donation.finalizedAt, donationDiff.finalizedAt);
      });

      test('field "canceledAt"', () {
        final Donation _donation = donation.copyWith(canceledAt: donationDiff.canceledAt);

        expect(_donation.canceledAt, donationDiff.canceledAt);
      });

      test('field "updatedAt"', () {
        final Donation _donation = donation.copyWith(updatedAt: donationDiff.updatedAt);

        expect(_donation.updatedAt, donationDiff.updatedAt);
      });
    });
  });
}
