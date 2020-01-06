import 'package:flutter_test/flutter_test.dart';
import 'package:tem_doacao_mobile/models/donation_image.dart';

import '../_fixtures/fixture.dart';

void main() {
  final DonationImage donationImage = DonationImage(id: '1', imageUrl: 'https://www.domain.com/storage.image1.jpg');
  final DonationImage donationImageDiff = DonationImage(id: '2', imageUrl: 'https://www.domain.com/storage.image2.jpg');

  group('equality tests', () {
    test('should be equals when identical objects', () {
      final DonationImage _donationImage = donationImage;

      expect(_donationImage, donationImage);
    });

    test('should be equals when same values and different objects', () {
      final DonationImage _donationImage = DonationImage(id: donationImage.id, imageUrl: donationImage.imageUrl);

      expect(_donationImage, donationImage);
    });

    group('should be different when differents values', () {
      test('field "id"', () {
        final DonationImage _donationImage = DonationImage(id: donationImageDiff.id, imageUrl: donationImage.imageUrl);

        expect(_donationImage, isNot(donationImage));
      });

      test('field "imageUrl"', () {
        final DonationImage _donationImage = DonationImage(id: donationImage.id, imageUrl: donationImageDiff.imageUrl);

        expect(_donationImage, isNot(donationImage));
      });
    });
  });

  group('serializers tests', () {
    test('fromJson', () {
      final Map donationImageMap = fixtureAsMap('test/_fixtures/donation_image.json');
      final DonationImage _donationImage = DonationImage.fromJson(donationImageMap);

      expect(_donationImage.id, donationImageMap['id']);
      expect(_donationImage.imageUrl, donationImageMap['image_url']);
    });

    test('toJson', () {
      final _donationImage = donationImage.toJson();

      expect(donationImage.id, _donationImage['id']);
      expect(donationImage.imageUrl, _donationImage['image_url']);
    });
  });

  group('clone tests', () {
    group('copyWith', () {
      test('without fields', () {
        final DonationImage _donationImage = donationImage.copyWith();

        expect(_donationImage, donationImage);
        expect(identical(_donationImage, donationImage), false);
      });

      test('field "id"', () {
        final DonationImage _donationImage = donationImage.copyWith(id: donationImageDiff.id);

        expect(_donationImage.id, donationImageDiff.id);
      });

      test('field "imageUrl"', () {
        final DonationImage _donationImage = donationImage.copyWith(imageUrl: donationImageDiff.imageUrl);

        expect(_donationImage.imageUrl, donationImageDiff.imageUrl);
      });
    });
  });
}
